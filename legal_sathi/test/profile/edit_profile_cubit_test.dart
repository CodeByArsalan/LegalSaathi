import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/auth/cubit/auth_cubit.dart';
import 'package:legal_sathi/auth/data/models/user_profile_dto.dart';
import 'package:legal_sathi/auth/domain/entities/app_user.dart';
import 'package:legal_sathi/auth/domain/entities/auth_session.dart';
import 'package:legal_sathi/auth/domain/entities/credentials.dart';
import 'package:legal_sathi/auth/domain/entities/register_result.dart';
import 'package:legal_sathi/auth/domain/repositories/auth_repository.dart';
import 'package:legal_sathi/auth/domain/usecases/get_current_user.dart';
import 'package:legal_sathi/auth/domain/usecases/logout.dart';
import 'package:legal_sathi/auth/domain/usecases/restore_session.dart';
import 'package:legal_sathi/auth/domain/usecases/update_profile.dart';
import 'package:legal_sathi/core/errors/app_exception.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';
import 'package:legal_sathi/core/network/api_envelope.dart';
import 'package:legal_sathi/profile/cubit/edit_profile_cubit.dart';
import 'package:legal_sathi/profile/cubit/edit_profile_state.dart';

import '../support/fixtures.dart';

/// Saving an edit has to land in two places at once: the server, and the session
/// every other screen reads identity from. These pin down the hand-over.
void main() {
  final AppUser signedIn = AppUser(
    id: 3,
    email: 'lsgate66921159@uberip.com',
    fullName: 'Gate Check',
    phoneNumber: '03788768671',
    emailVerified: true,
    cnic: '35201-1234567-1',
  );

  late _FakeAuthRepository repository;
  late AuthCubit auth;
  late EditProfileCubit cubit;

  setUp(() {
    repository = _FakeAuthRepository(signedIn);
    auth = AuthCubit(
      restoreSession: RestoreSessionUseCase(repository),
      getCurrentUser: GetCurrentUserUseCase(repository),
      logout: LogoutUseCase(repository),
    )..applyUser(signedIn);
    cubit = EditProfileCubit(
      updateProfile: UpdateProfileUseCase(repository),
      auth: auth,
    );
  });

  tearDown(() async {
    await cubit.close();
    await auth.close();
  });

  test('a saved edit reaches the session, and the screen can pop', () async {
    repository.profileResult = Success<AppUser>(
      signedIn.copyWith(fullName: 'Ayesha Khan'),
    );

    await cubit.save(
      fullName: 'Ayesha Khan',
      phoneNumber: '03001234567',
      cnic: '35201-1234567-1',
    );

    expect(cubit.state.saved, isTrue);
    expect(cubit.state.isSaving, isFalse);
    expect(cubit.state.failure, isNull);
    // The header on the profile tab reads this, not the form that was closed.
    expect(auth.currentUser?.fullName, 'Ayesha Khan');
  });

  test('the fields go out exactly as the endpoint takes them', () async {
    await cubit.save(
      fullName: 'Ayesha Khan',
      phoneNumber: '03001234567',
      cnic: null,
    );

    expect(repository.lastFullName, 'Ayesha Khan');
    expect(repository.lastPhoneNumber, '03001234567');
    // Null is what clears a stored CNIC, so it has to travel as null rather
    // than as the empty string the field would otherwise hand over.
    expect(repository.lastCnic, isNull);
  });

  test('saving shows progress while the call is in flight', () async {
    final List<EditProfileState> states = <EditProfileState>[];
    cubit.stream.listen(states.add);

    await cubit.save(fullName: 'Ayesha Khan', phoneNumber: '03001234567');
    await pumpEventQueue();

    expect(states.first.isSaving, isTrue);
    expect(states.first.saved, isFalse);
    expect(cubit.state.isSaving, isFalse);
    expect(cubit.state.saved, isTrue);
  });

  test('a second tap while saving is ignored', () async {
    final Future<void> first = cubit.save(
      fullName: 'Ayesha Khan',
      phoneNumber: '03001234567',
    );
    await cubit.save(fullName: 'Someone Else', phoneNumber: '03001234567');
    await first;

    expect(repository.updateCalls, 1);
    expect(repository.lastFullName, 'Ayesha Khan');
  });

  test('a refused edit leaves the session alone', () async {
    // The server answers 400 with the rule it applied, which is worth showing.
    repository.profileResult = FailureResult<AppUser>(
      Failure.from(
        const AppException(
          'A valid Pakistani mobile number is required.',
          kind: AppExceptionKind.validation,
          statusCode: 400,
        ),
      ),
    );

    await cubit.save(fullName: 'Ayesha Khan', phoneNumber: '12345');

    expect(cubit.state.saved, isFalse);
    expect(cubit.state.isSaving, isFalse);
    expect(cubit.state.failure, isA<ValidationFailure>());
    expect(
      cubit.state.failure!.message,
      'A valid Pakistani mobile number is required.',
    );
    expect(auth.currentUser?.fullName, 'Gate Check');
  });

  test('a failure to retry after clears the one before it', () async {
    repository.profileResult = const FailureResult<AppUser>(NetworkFailure());
    await cubit.save(fullName: 'Ayesha Khan', phoneNumber: '03001234567');
    expect(cubit.state.failure, isA<NetworkFailure>());

    repository.profileResult = Success<AppUser>(signedIn);
    await cubit.save(fullName: 'Ayesha Khan', phoneNumber: '03001234567');

    expect(cubit.state.failure, isNull);
    expect(cubit.state.saved, isTrue);
  });

  group('PUT /Auth/profile payload', () {
    test('is the account as it now stands, and becomes the session', () {
      final AppUser user = ApiEnvelope.unwrapObject<UserProfileDto>(
        fixtureResponse('auth_update_profile', statusCode: 200),
        UserProfileDto.fromJson,
      ).toEntity();

      expect(user.id, 3);
      expect(user.fullName, 'Gate Check');
      expect(user.phoneNumber, '03788768671');
      expect(user.cnic, '35201-1234567-1');
      expect(user.emailVerified, isTrue);
      // Naive on the wire, so it has to be read as UTC rather than as
      // device-local time — the header shows it as a join date.
      expect(user.createdAt, isNotNull);
      expect(user.createdAt!.isUtc, isTrue);
    });
  });
}

/// Answers `PUT /Auth/profile` and writes down what it was asked to save. The
/// session calls are stubbed out: [AuthCubit] is driven directly here.
final class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository(this._user) {
    profileResult = Success<AppUser>(_user);
  }

  final AppUser _user;

  /// The account as it stands after a save. A success by default, because most
  /// of these tests are about what happens to the session rather than about a
  /// refusal.
  late Result<AppUser> profileResult;

  int updateCalls = 0;
  String? lastFullName;
  String? lastPhoneNumber;
  String? lastCnic;

  @override
  Future<Result<AppUser>> updateProfile({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  }) async {
    updateCalls++;
    lastFullName = fullName;
    lastPhoneNumber = phoneNumber;
    lastCnic = cnic;
    return profileResult;
  }

  @override
  Future<Result<AuthSession>> login(LoginCredentials credentials) =>
      throw UnimplementedError();

  @override
  Future<Result<RegisterResult>> register(RegisterCredentials credentials) =>
      throw UnimplementedError();

  @override
  Future<Result<AuthSession>> verifyEmail({
    required String email,
    required String code,
  }) => throw UnimplementedError();

  @override
  Future<Result<String>> resendVerificationCode(String email) =>
      throw UnimplementedError();

  @override
  Future<Result<AuthSession?>> restoreSession() => throw UnimplementedError();

  @override
  Future<Result<AppUser>> currentUser() async => Success<AppUser>(_user);

  @override
  Future<Result<bool>> logout() => throw UnimplementedError();
}
