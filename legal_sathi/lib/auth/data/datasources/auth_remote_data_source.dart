import '../models/auth_response_dto.dart';
import '../models/login_request_dto.dart';
import '../models/register_request_dto.dart';
import '../models/register_response_dto.dart';
import '../models/send_otp_response_dto.dart';
import '../models/user_profile_dto.dart';

/// `/Auth/*`. Implementations throw `AppException`; the repository turns those
/// into `Failure`s so nothing else crosses this boundary.
abstract class AuthRemoteDataSource {
  Future<AuthResponseDto> login(LoginRequestDto request);

  /// Creates the account and triggers the OTP email. Returns no tokens.
  Future<RegisterResponseDto> register(RegisterRequestDto request);

  /// Redeems the emailed OTP and returns the session — this is the first call
  /// that yields tokens for a new account.
  Future<AuthResponseDto> verifyEmail({
    required String email,
    required String otpCode,
  });

  Future<SendOtpResponseDto> resendVerification(String email);

  Future<UserProfileDto> me();

  Future<UserProfileDto> updateProfile({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  });

  /// Invalidates the session server-side. Best effort: the caller signs out
  /// locally even if this fails.
  Future<void> revokeToken();
}
