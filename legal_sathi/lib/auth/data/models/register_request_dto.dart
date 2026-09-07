import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/credentials.dart';

part 'register_request_dto.freezed.dart';
part 'register_request_dto.g.dart';

/// Body of `POST /Auth/register`. `role` is omitted on purpose: the server
/// defaults it to `EndUser`, and its `UserRole` enum is not registered for
/// string deserialization.
@freezed
abstract class RegisterRequestDto with _$RegisterRequestDto {
  const factory RegisterRequestDto({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? cnic,
  }) = _RegisterRequestDto;

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDtoFromJson(json);

  factory RegisterRequestDto.fromEntity(RegisterCredentials credentials) =>
      RegisterRequestDto(
        fullName: credentials.fullName,
        email: credentials.email,
        phoneNumber: credentials.phoneNumber,
        password: credentials.password,
        cnic: credentials.cnic,
      );
}
