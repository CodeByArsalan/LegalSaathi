import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_otp_response_dto.freezed.dart';
part 'send_otp_response_dto.g.dart';

/// Wire shape of `SendOtpResponse`, returned by `/Auth/resend-verification` and
/// `/Auth/send-otp`. The envelope's own `success` is separate from this one,
/// which reports whether the mail was handed to SMTP.
@freezed
abstract class SendOtpResponseDto with _$SendOtpResponseDto {
  const factory SendOtpResponseDto({
    required bool success,
    required String message,
    required int expirySeconds,
  }) = _SendOtpResponseDto;

  factory SendOtpResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseDtoFromJson(json);
}
