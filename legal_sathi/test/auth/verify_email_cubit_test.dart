import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/auth/cubit/auth_cubit.dart';
import 'package:legal_sathi/auth/cubit/verify_email_cubit.dart';
import 'package:legal_sathi/auth/cubit/verify_email_state.dart';
import 'package:legal_sathi/auth/domain/entities/app_user.dart';
import 'package:legal_sathi/auth/domain/entities/auth_session.dart';
import 'package:legal_sathi/auth/domain/entities/credentials.dart';
import 'package:legal_sathi/auth/domain/entities/register_result.dart';
import 'package:legal_sathi/auth/domain/repositories/auth_repository.dart';
import 'package:legal_sathi/auth/domain/usecases/get_current_user.dart';
import 'package:legal_sathi/auth/domain/usecases/logout.dart';
import 'package:legal_sathi/auth/domain/usecases/resend_verification_code.dart';
import 'package:legal_sathi/auth/domain/usecases/restore_session.dart';
import 'package:legal_sathi/auth/domain/usecases/verify_email.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';

class _FakeAuthRepository implements AuthRepository {
  Failure? verifyFailure;
  String? verifiedEmail;
  String? verifiedCode;
  String? resentEmail;

  @override
  Future<Result<AuthSession>> verifyEmail({
    required String email,
    required String code,
  }) async {
    verifiedEmail = email;
    verifiedCode = code;
    final Failure? failure = verifyFailure;
    if (failure != null) return FailureResult<AuthSession>(failure);
    return Success<AuthSession>(session);
  }

  @override
  Future<Result<String>> resendVerificationCode(String email) async {
    resentEmail = email;
    return Success<String>('A 6-digit code was sent to $email.');
  }

  @override
  Future<Result<AuthSession?>> restoreSession() async =>
      Success<AuthSession?>(null);

  @override
  Future<Result<bool>> logout() async => const Success<bool>(true);

  @override
  Future<Result<AuthSession>> login(LoginCredentials credentials) =>
      throw UnimplementedError();

  @override
  Future<Result<RegisterResult>> register(RegisterCredentials credentials) =>
      throw UnimplementedError();

  @override
  Future<Result<AppUser>> currentUser() => throw UnimplementedError();

  @override
  Future<Result<AppUser>> updateProfile({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  }) => throw UnimplementedError();
}

final session = AuthSession(
  accessToken: 'access',
  refreshToken: 'refresh',
  user: AppUser(
    id: 7,
    email: 'user@example.com',
    fullName: 'Test User',
    phoneNumber: '03001234567',
    // Always true for a session that exists: the API issues tokens only to a
    // verified account, and this call is what produces them.
    emailVerified: true,
  ),
);

/// Verification as pure cubit logic. This is where a session is born — the API
/// returns no tokens at registration and refuses to log an unverified account
/// in — so the cubit both hands the tokens to [AuthCubit] and seeds its screen
/// from an address the route supplied.
void main() {
  late _FakeAuthRepository repository;
  late AuthCubit auth;
  late VerifyEmailCubit cubit;

  setUp(() {
    repository = _FakeAuthRepository();
    auth = AuthCubit(
      restoreSession: RestoreSessionUseCase(repository),
      getCurrentUser: GetCurrentUserUseCase(repository),
      logout: LogoutUseCase(repository),
    );
    cubit = VerifyEmailCubit(
      email: 'user@example.com',
      verifyEmail: VerifyEmailUseCase(repository),
      resendCode: ResendVerificationCodeUseCase(repository),
      auth: auth,
    );
  });

  tearDown(() async {
    await cubit.close();
    await auth.close();
  });

  test('starts from the address the route carried, with no session', () {
    expect(cubit.state.email, 'user@example.com');
    expect(auth.currentUser, isNull);
  });

  test('an accepted code signs in and emits verified', () async {
    await cubit.submit(email: 'user@example.com', code: '424242');

    expect(cubit.state, isA<VerifyEmailVerified>());
    expect(auth.currentUser?.id, 7);
    expect(auth.currentUser?.emailVerified, isTrue);
  });

  test('the address comes from the form, not the seeded state', () async {
    // A refused login deep-links here with whatever was typed, which may be a
    // mobile number; the field is editable so the real address can be entered.
    await cubit.submit(email: '  other@example.com ', code: '424242');

    expect(repository.verifiedEmail, 'other@example.com');
    expect(repository.verifiedCode, '424242');
    expect(cubit.state.email, 'other@example.com');
  });

  test('a rejected code surfaces the failure and signs nobody in', () async {
    repository.verifyFailure = const ServerFailure(message: 'OTP has expired.');

    await cubit.submit(email: 'user@example.com', code: '000000');

    final state = cubit.state;
    expect(state, isA<VerifyEmailFailure>());
    expect((state as VerifyEmailFailure).failure.message, 'OTP has expired.');
    expect(auth.currentUser, isNull);
  });

  test('resend returns to codeSent carrying the server message', () async {
    await cubit.resend('user@example.com');

    final state = cubit.state;
    expect(state, isA<VerifyEmailCodeSent>());
    expect(
      (state as VerifyEmailCodeSent).message,
      contains('user@example.com'),
    );
    expect(auth.currentUser, isNull);
  });
}
