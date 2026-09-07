import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/auth/cubit/auth_cubit.dart';
import 'package:legal_sathi/auth/cubit/auth_state.dart';
import 'package:legal_sathi/auth/cubit/login_cubit.dart';
import 'package:legal_sathi/auth/cubit/login_state.dart';
import 'package:legal_sathi/auth/domain/entities/app_user.dart';
import 'package:legal_sathi/auth/domain/entities/auth_session.dart';
import 'package:legal_sathi/auth/domain/entities/credentials.dart';
import 'package:legal_sathi/auth/domain/entities/register_result.dart';
import 'package:legal_sathi/auth/domain/repositories/auth_repository.dart';
import 'package:legal_sathi/auth/domain/usecases/get_current_user.dart';
import 'package:legal_sathi/auth/domain/usecases/login.dart';
import 'package:legal_sathi/auth/domain/usecases/logout.dart';
import 'package:legal_sathi/auth/domain/usecases/restore_session.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';

final user = AppUser(
  id: 1001,
  email: 'demo@legalsathi.pk',
  fullName: 'Ayesha Khan',
  phoneNumber: '03001234567',
  emailVerified: true,
  createdAt: _joinedOn,
);

final session = AuthSession(
  user: user,
  accessToken: 'mock-jwt',
  refreshToken: 'mock-refresh',
);

final DateTime _joinedOn = DateTime(2026, 1, 12);

/// Proves the spine of the architecture: a Cubit drives a usecase, maps
/// `Result` into a sealed state, and hands the session to the app-wide
/// [AuthCubit] — with no Flutter or platform dependencies.
void main() {
  late _FakeAuthRepository repository;
  late AuthCubit auth;
  late LoginCubit cubit;

  setUp(() {
    repository = _FakeAuthRepository();
    auth = AuthCubit(
      restoreSession: RestoreSessionUseCase(repository),
      getCurrentUser: GetCurrentUserUseCase(repository),
      logout: LogoutUseCase(repository),
    );
    cubit = LoginCubit(login: LoginUseCase(repository), auth: auth);
  });

  tearDown(() async {
    await cubit.close();
    await auth.close();
  });

  test('a good password emits submitting then success and signs in', () async {
    final states = <LoginState>[];
    cubit.stream.listen(states.add);

    await cubit.submit(
      emailOrPhone: 'demo@legalsathi.pk',
      password: 'demo1234',
    );
    await pumpEventQueue();

    expect(states, contains(isA<LoginSubmitting>()));
    expect(cubit.state, isA<LoginSuccess>());
    expect(auth.currentUser?.email, 'demo@legalsathi.pk');
  });

  test('a rejected login surfaces the failure, never signs in', () async {
    repository.loginResult = const FailureResult(InvalidCredentialsFailure());

    await cubit.submit(emailOrPhone: 'demo@legalsathi.pk', password: 'wrong');

    final state = cubit.state;
    expect(state, isA<LoginFailureState>());
    expect(
      (state as LoginFailureState).failure.l10nKey,
      'errors.invalid_credentials',
    );
    expect(auth.currentUser, isNull);
  });

  test(
    'an unverified account routes to the code screen, not a dead end',
    () async {
      // Both this and a wrong password arrive as HTTP 400; only the failure type
      // separates them, and only this one has a next step.
      repository.loginResult = const FailureResult(
        EmailNotVerifiedFailure(message: 'Your email address (a@b.com) …'),
      );

      await cubit.submit(emailOrPhone: '03001234567', password: 'demo1234');

      final state = cubit.state;
      expect(state, isA<LoginUnverified>());
      expect((state as LoginUnverified).message, contains('a@b.com'));
      expect(auth.currentUser, isNull);
    },
  );

  test('reset returns the form to its initial state', () async {
    repository.loginResult = const FailureResult(NetworkFailure());
    await cubit.submit(emailOrPhone: 'a@b.com', password: 'whatever');
    expect(cubit.state, isA<LoginFailureState>());

    cubit.reset();
    expect(cubit.state, isA<LoginInitial>());
  });

  test('a stored session restores straight to authenticated', () async {
    repository.storedSession = session;

    await auth.start();

    expect(auth.state, isA<AuthAuthenticated>());
    expect((auth.state as AuthAuthenticated).user.id, 1001);
  });

  test('restoring reconciles the cached user against /Auth/me', () async {
    // The cache has no join date or verification flag; only this call does.
    repository.storedSession = session;
    repository.currentUserResult = Success<AppUser>(
      user.copyWith(fullName: 'Ayesha K.', createdAt: _joinedOn),
    );

    await auth.start();

    expect((auth.state as AuthAuthenticated).user.fullName, 'Ayesha K.');
  });

  test('an unreachable /Auth/me keeps the cached session', () async {
    // Starting offline must not sign anyone out — dead tokens are the refresh
    // interceptor's business, and it clears storage itself.
    repository.storedSession = session;
    repository.currentUserResult = const FailureResult<AppUser>(
      NetworkFailure(),
    );

    await auth.start();

    expect(auth.state, isA<AuthAuthenticated>());
    expect((auth.state as AuthAuthenticated).user.id, 1001);
  });

  test('no stored session means unauthenticated, not a failure', () async {
    repository.storedSession = null;

    await auth.start();

    expect(auth.state, const AuthState.unauthenticated());
  });

  test('signing out clears storage and the session', () async {
    repository.storedSession = session;
    await auth.start();

    await auth.signOut();

    expect(repository.logoutCalls, 1);
    expect(auth.state, isA<AuthUnauthenticated>());
  });
}

class _FakeAuthRepository implements AuthRepository {
  Result<AuthSession> loginResult = Success<AuthSession>(session);
  Result<AppUser> currentUserResult = Success<AppUser>(user);
  AuthSession? storedSession;
  int logoutCalls = 0;

  @override
  Future<Result<AuthSession>> login(LoginCredentials credentials) async =>
      loginResult;

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
  Future<Result<AuthSession?>> restoreSession() async =>
      Success<AuthSession?>(storedSession);

  @override
  Future<Result<AppUser>> currentUser() async => currentUserResult;

  @override
  Future<Result<AppUser>> updateProfile({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  }) => throw UnimplementedError();

  @override
  Future<Result<bool>> logout() async {
    logoutCalls++;
    storedSession = null;
    return const Success<bool>(true);
  }
}
