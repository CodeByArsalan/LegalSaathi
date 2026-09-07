import '../../../core/constants/api_error_codes.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/mock/mock_data_source.dart';
import '../../../core/utils/server_date.dart';
import '../models/auth_response_dto.dart';
import '../models/login_request_dto.dart';
import '../models/register_request_dto.dart';
import '../models/register_response_dto.dart';
import '../models/send_otp_response_dto.dart';
import '../models/user_profile_dto.dart';
import 'auth_remote_data_source.dart';

/// Offline/demo stand-in for `/Auth/*`. It mirrors the real API's contract:
/// registration yields **no** tokens, the session is born at OTP verification,
/// and a login attempt on an unverified account is refused with the
/// `EmailNotVerified` code.
///
/// Demo accounts (also listed in ARCHITECTURE.md):
///  • `demo@legalsathi.pk` / `demo1234` — signs in
///  • `pending@legalsathi.pk` / `demo1234` — refused until the OTP is entered
///  • `error@legalsathi.pk` / anything — forces a server failure to exercise
///    the retry path
///  • verification code `123456`
class AuthRemoteDataSourceMock extends MockDataSource
    implements AuthRemoteDataSource {
  static const String _demoOtp = '123456';
  static const String _serverErrorEmail = 'error@legalsathi.pk';
  static const int _otpExpirySeconds = 300;

  final List<Map<String, dynamic>> _users = <Map<String, dynamic>>[];

  int? _signedInUserId;
  int _nextUserId = 2000;

  @override
  Future<AuthResponseDto> login(LoginRequestDto request) async {
    await _ensureSeeded();

    final String identifier = request.emailOrPhone.trim().toLowerCase();
    if (identifier == _serverErrorEmail) {
      throw const AppException(
        'Auth service is offline (mock failure).',
        kind: AppExceptionKind.server,
        statusCode: 503,
      );
    }

    final Map<String, dynamic>? row = _find(identifier);
    if (row == null || row['password'] != request.password) {
      throw const AppException(
        'Invalid email/phone or password.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
      );
    }
    if (row['emailVerified'] != true) {
      throw AppException(
        'Your email address (${row['email']}) has not been verified yet. '
        'A 6-digit verification OTP has been sent to your email.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
        code: ApiErrorCodes.emailNotVerified,
      );
    }

    _signedInUserId = row['id'] as int;
    return withLatency(_authResponse(row));
  }

  @override
  Future<RegisterResponseDto> register(RegisterRequestDto request) async {
    await _ensureSeeded();

    final String email = request.email.trim().toLowerCase();
    if (_find(email) != null) {
      throw const AppException(
        'An account with this email already exists.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
        fieldErrors: <String, String>{'email': 'already_registered'},
      );
    }

    final Map<String, dynamic> row = <String, dynamic>{
      'id': _nextUserId++,
      'email': email,
      'password': request.password,
      'fullName': request.fullName.trim(),
      'phoneNumber': request.phoneNumber.trim(),
      'emailVerified': false,
      'role': 'EndUser',
      'cnic': request.cnic,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
    };
    _users.add(row);

    return withLatency(
      RegisterResponseDto(
        userId: row['id']! as int,
        email: email,
        requiresEmailVerification: true,
        message:
            'Registration successful! A 6-digit verification code has been '
            'sent to $email.',
      ),
    );
  }

  @override
  Future<AuthResponseDto> verifyEmail({
    required String email,
    required String otpCode,
  }) async {
    await _ensureSeeded();

    final Map<String, dynamic>? row = _find(email);
    if (row == null) {
      throw const AppException(
        'User account not found.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
      );
    }
    if (otpCode.trim() != _demoOtp) {
      throw const AppException(
        'Incorrect OTP code.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
        fieldErrors: <String, String>{'otpCode': 'invalid_code'},
      );
    }

    row['emailVerified'] = true;
    _signedInUserId = row['id'] as int;
    return withLatency(_authResponse(row));
  }

  @override
  Future<SendOtpResponseDto> resendVerification(String email) async {
    await _ensureSeeded();

    final Map<String, dynamic>? row = _find(email);
    if (row == null) {
      throw const AppException(
        'User account not found.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
      );
    }

    return withLatency(
      SendOtpResponseDto(
        success: true,
        message: 'A new verification code has been sent to ${row['email']}.',
        expirySeconds: _otpExpirySeconds,
      ),
    );
  }

  @override
  Future<UserProfileDto> me() async {
    await _ensureSeeded();

    final Map<String, dynamic>? row = _signedIn();
    if (row == null) {
      // Nothing signed in during this run — a restored session came from secure
      // storage, which the mock backend cannot see.
      throw const AppException(
        'User account not found.',
        kind: AppExceptionKind.notFound,
        statusCode: 404,
      );
    }
    return withLatency(_profile(row));
  }

  @override
  Future<UserProfileDto> updateProfile({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  }) async {
    await _ensureSeeded();

    final Map<String, dynamic>? row = _signedIn();
    if (row == null) {
      throw const AppException(
        'User account not found.',
        kind: AppExceptionKind.notFound,
        statusCode: 404,
      );
    }

    row['fullName'] = fullName.trim();
    row['phoneNumber'] = phoneNumber.trim();
    if (cnic != null) row['cnic'] = cnic;
    return withLatency(_profile(row));
  }

  @override
  Future<void> revokeToken() async {
    _signedInUserId = null;
    await withLatency<void>(null);
  }

  Future<void> _ensureSeeded() async {
    if (_users.isNotEmpty) return;
    _users.addAll(await loadRows(AssetPaths.mockUsers));
  }

  Map<String, dynamic>? _signedIn() {
    final int? id = _signedInUserId;
    if (id == null) return null;
    for (final Map<String, dynamic> row in _users) {
      if (row['id'] == id) return row;
    }
    return null;
  }

  /// Matches on either identifier, the way the API's `emailOrPhone` does.
  Map<String, dynamic>? _find(String identifier) {
    final String needle = identifier.trim().toLowerCase();
    for (final Map<String, dynamic> row in _users) {
      if ('${row['email']}'.toLowerCase() == needle) return row;
      if ('${row['phoneNumber']}' == needle) return row;
    }
    return null;
  }

  AuthResponseDto _authResponse(Map<String, dynamic> row) {
    final String suffix =
        '${row['id']}-${DateTime.now().millisecondsSinceEpoch}';
    return AuthResponseDto(
      userId: row['id']! as int,
      fullName: row['fullName']! as String,
      email: row['email']! as String,
      phoneNumber: row['phoneNumber']! as String,
      role: row['role']! as String,
      cnic: row['cnic'] as String?,
      accessToken: 'mock-jwt.$suffix',
      refreshToken: 'mock-refresh.$suffix',
    );
  }

  UserProfileDto _profile(Map<String, dynamic> row) => UserProfileDto(
    userId: row['id']! as int,
    fullName: row['fullName']! as String,
    email: row['email']! as String,
    phoneNumber: row['phoneNumber']! as String,
    role: row['role']! as String,
    isEmailVerified: row['emailVerified'] == true,
    createdDateTime: ServerDate.parse(row['createdAt']),
    cnic: row['cnic'] as String?,
  );
}
