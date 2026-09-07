import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/register_result.dart';

part 'register_response_dto.freezed.dart';
part 'register_response_dto.g.dart';

/// Wire shape of `RegisterResponse`. It carries **no tokens** — registration
/// only creates the account and emails the OTP.
@freezed
abstract class RegisterResponseDto with _$RegisterResponseDto {
  const factory RegisterResponseDto({
    required int userId,
    required String email,
    required bool requiresEmailVerification,
    required String message,
  }) = _RegisterResponseDto;

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDtoFromJson(json);
}

extension RegisterResponseDtoMapper on RegisterResponseDto {
  /// The server's `email` is the address the OTP was actually sent to, so it —
  /// not the string the user typed — is what `/Auth/verify-email` must be
  /// called with.
  RegisterResult toEntity() => RegisterResult(
    userId: userId,
    email: email,
    requiresEmailVerification: requiresEmailVerification,
    message: message,
  );
}
