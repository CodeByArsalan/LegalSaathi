import '../../../core/errors/result.dart';
import '../entities/app_user.dart';
import '../entities/auth_session.dart';
import '../entities/credentials.dart';
import '../entities/register_result.dart';

abstract class AuthRepository {
  Future<Result<AuthSession>> login(LoginCredentials credentials);

  /// Creates the account. Returns no session: the API emails an OTP and refuses
  /// login until [verifyEmail] succeeds.
  Future<Result<RegisterResult>> register(RegisterCredentials credentials);

  /// Redeems the emailed OTP. This is where the session is born.
  Future<Result<AuthSession>> verifyEmail({
    required String email,
    required String code,
  });

  /// Re-sends the OTP. The success value is the server's own message, which is
  /// worth showing.
  Future<Result<String>> resendVerificationCode(String email);

  /// Reads the stored token pair, if any — no network call.
  Future<Result<AuthSession?>> restoreSession();

  /// `GET /Auth/me`. Reconciles the cached user with the server, which is the
  /// only source of `emailVerified` and `createdAt`.
  Future<Result<AppUser>> currentUser();

  Future<Result<AppUser>> updateProfile({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  });

  Future<Result<bool>> logout();
}
