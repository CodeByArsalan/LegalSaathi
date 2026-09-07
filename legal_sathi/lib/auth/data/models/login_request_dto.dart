import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/credentials.dart';

part 'login_request_dto.freezed.dart';
part 'login_request_dto.g.dart';

/// Body of `POST /Auth/login`. The server's field is `emailOrPhone`, not
/// `email`, and it accepts either identifier.
@freezed
abstract class LoginRequestDto with _$LoginRequestDto {
  const factory LoginRequestDto({
    required String emailOrPhone,
    required String password,
  }) = _LoginRequestDto;

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);

  factory LoginRequestDto.fromEntity(LoginCredentials credentials) =>
      LoginRequestDto(
        emailOrPhone: credentials.emailOrPhone,
        password: credentials.password,
      );
}
