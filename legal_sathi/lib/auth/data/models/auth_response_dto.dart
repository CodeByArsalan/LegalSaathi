import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_session.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

/// Wire shape of `AuthResponse`, returned by `/Auth/login`, `/Auth/verify-email`
/// and `/Auth/refresh-token`. `expiresAt` is deliberately not modelled: the
/// access token lives only 15 minutes and the refresh interceptor reacts to the
/// 401 rather than pre-empting it.
@freezed
abstract class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required int userId,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String role,
    required String accessToken,
    required String refreshToken,
    String? cnic,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
}

extension AuthResponseDtoMapper on AuthResponseDto {
  /// The API refuses to issue tokens for an account whose email is unverified,
  /// so a session built here is verified by construction. `createdAt` is left
  /// null — only `/Auth/me` reports it.
  AuthSession toSession() => AuthSession(
    user: AppUser(
      id: userId,
      email: email,
      fullName: fullName,
      phoneNumber: phoneNumber,
      emailVerified: true,
      role: role,
      cnic: cnic,
    ),
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}
