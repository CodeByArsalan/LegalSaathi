import 'package:dio/dio.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_envelope.dart';
import '../../../core/network/request_extras.dart';
import '../models/auth_response_dto.dart';
import '../models/login_request_dto.dart';
import '../models/register_request_dto.dart';
import '../models/register_response_dto.dart';
import '../models/send_otp_response_dto.dart';
import '../models/user_profile_dto.dart';
import 'auth_remote_data_source.dart';

final class AuthRemoteDataSourceDio implements AuthRemoteDataSource {
  AuthRemoteDataSourceDio(this._dio);

  final Dio _dio;

  /// Everything before a session exists. These calls must not carry a stale
  /// bearer token, and a 401 on them must not start the refresh flow — there is
  /// no session to refresh.
  static final Options _anonymous = Options(
    extra: <String, Object>{RequestExtras.skipAuth: true},
  );

  @override
  Future<AuthResponseDto> login(LoginRequestDto request) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.login,
      data: request.toJson(),
      options: _anonymous,
    );
    return ApiEnvelope.unwrapObject<AuthResponseDto>(
      response,
      AuthResponseDto.fromJson,
    );
  }

  @override
  Future<RegisterResponseDto> register(RegisterRequestDto request) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.register,
      data: request.toJson(),
      options: _anonymous,
    );
    return ApiEnvelope.unwrapObject<RegisterResponseDto>(
      response,
      RegisterResponseDto.fromJson,
    );
  }

  @override
  Future<AuthResponseDto> verifyEmail({
    required String email,
    required String otpCode,
  }) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.verifyEmail,
      data: <String, String>{'email': email, 'otpCode': otpCode},
      options: _anonymous,
    );
    return ApiEnvelope.unwrapObject<AuthResponseDto>(
      response,
      AuthResponseDto.fromJson,
    );
  }

  @override
  Future<SendOtpResponseDto> resendVerification(String email) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.resendVerification,
      data: <String, String>{'email': email},
      options: _anonymous,
    );
    return ApiEnvelope.unwrapObject<SendOtpResponseDto>(
      response,
      SendOtpResponseDto.fromJson,
    );
  }

  @override
  Future<UserProfileDto> me() async {
    final Response<dynamic> response = await _dio.get<dynamic>(ApiEndpoints.me);
    return ApiEnvelope.unwrapObject<UserProfileDto>(
      response,
      UserProfileDto.fromJson,
    );
  }

  @override
  Future<UserProfileDto> updateProfile({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  }) async {
    final Response<dynamic> response = await _dio.put<dynamic>(
      ApiEndpoints.profile,
      data: <String, String?>{
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'cnic': cnic,
      },
    );
    return ApiEnvelope.unwrapObject<UserProfileDto>(
      response,
      UserProfileDto.fromJson,
    );
  }

  @override
  Future<void> revokeToken() async {
    // The server identifies the session from the bearer token alone; it takes no
    // body. Its reply is the non-generic envelope, which carries no payload.
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.revokeToken,
    );
    ApiEnvelope.ensureSuccess(response);
  }
}
