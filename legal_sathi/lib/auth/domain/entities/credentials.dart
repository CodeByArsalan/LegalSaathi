import 'package:freezed_annotation/freezed_annotation.dart';

part 'credentials.freezed.dart';

@freezed
abstract class LoginCredentials with _$LoginCredentials {
  /// The API's `LoginRequest.EmailOrPhone` accepts either identifier, so the
  /// field keeps that name rather than pretending it is email-only.
  const factory LoginCredentials({
    required String emailOrPhone,
    required String password,
  }) = _LoginCredentials;
}

@freezed
abstract class RegisterCredentials with _$RegisterCredentials {
  const factory RegisterCredentials({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? cnic,
  }) = _RegisterCredentials;
}
