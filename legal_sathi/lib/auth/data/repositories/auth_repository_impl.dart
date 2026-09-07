import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/credentials.dart';
import '../../domain/entities/register_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_response_dto.dart';
import '../models/login_request_dto.dart';
import '../models/register_request_dto.dart';
import '../models/register_response_dto.dart';
import '../models/send_otp_response_dto.dart';
import '../models/user_profile_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  Future<Result<AuthSession>> login(LoginCredentials credentials) async {
    try {
      final AuthResponseDto response = await _remote.login(
        LoginRequestDto.fromEntity(credentials),
      );
      return Success<AuthSession>(await _cache(response.toSession()));
    } on Object catch (error) {
      return FailureResult<AuthSession>(Failure.from(error));
    }
  }

  /// Deliberately caches nothing: the API returns no tokens here, so there is no
  /// session yet. The next screen is the OTP one.
  @override
  Future<Result<RegisterResult>> register(
    RegisterCredentials credentials,
  ) async {
    try {
      final RegisterResponseDto response = await _remote.register(
        RegisterRequestDto.fromEntity(credentials),
      );
      return Success<RegisterResult>(response.toEntity());
    } on Object catch (error) {
      return FailureResult<RegisterResult>(Failure.from(error));
    }
  }

  @override
  Future<Result<AuthSession>> verifyEmail({
    required String email,
    required String code,
  }) async {
    try {
      final AuthResponseDto response = await _remote.verifyEmail(
        email: email,
        otpCode: code,
      );
      return Success<AuthSession>(await _cache(response.toSession()));
    } on Object catch (error) {
      return FailureResult<AuthSession>(Failure.from(error));
    }
  }

  @override
  Future<Result<String>> resendVerificationCode(String email) async {
    try {
      final SendOtpResponseDto response = await _remote.resendVerification(
        email,
      );
      return Success<String>(response.message);
    } on Object catch (error) {
      return FailureResult<String>(Failure.from(error));
    }
  }

  @override
  Future<Result<AuthSession?>> restoreSession() async =>
      Success<AuthSession?>(await _local.readSession());

  @override
  Future<Result<AppUser>> currentUser() async {
    try {
      return Success<AppUser>(
        await _cacheUser((await _remote.me()).toEntity()),
      );
    } on Object catch (error) {
      return FailureResult<AppUser>(Failure.from(error));
    }
  }

  @override
  Future<Result<AppUser>> updateProfile({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  }) async {
    try {
      final AppUser user = (await _remote.updateProfile(
        fullName: fullName,
        phoneNumber: phoneNumber,
        cnic: cnic,
      )).toEntity();
      return Success<AppUser>(await _cacheUser(user));
    } on Object catch (error) {
      return FailureResult<AppUser>(Failure.from(error));
    }
  }

  @override
  Future<Result<bool>> logout() async {
    final AuthSession? session = await _local.readSession();
    try {
      if (session != null) await _remote.revokeToken();
    } on Object catch (_) {
      // A failed remote revoke must not strand the user in a signed-in UI.
    }
    await _local.clear();
    return const Success<bool>(true);
  }

  Future<AuthSession> _cache(AuthSession session) async {
    await _local.cacheSession(session);
    return session;
  }

  /// Replaces only the cached user, keeping the stored token pair: `/Auth/me` is
  /// the authoritative source for `emailVerified` and `createdAt`, but it does
  /// not reissue tokens.
  Future<AppUser> _cacheUser(AppUser user) async {
    final AuthSession? session = await _local.readSession();
    if (session != null) {
      await _local.cacheSession(session.copyWith(user: user));
    }
    return user;
  }
}
