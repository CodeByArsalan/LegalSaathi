import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/server_date.dart';
import '../../domain/entities/signing_otp.dart';

part 'signing_otp_dto.freezed.dart';
part 'signing_otp_dto.g.dart';

/// Wire shape of the `data` object from `POST /Documents/{id}/signatures/request-otp`.
///
/// It carries its own `success` and `message` fields inside the envelope's, both
/// of which the controller only fills on the happy path — the app shows its own
/// localised text, so neither is read.
@freezed
abstract class SigningOtpDto with _$SigningOtpDto {
  const factory SigningOtpDto({
    @Default('') String destinationMasked,
    @JsonKey(fromJson: ServerDate.required) required DateTime expiresAt,
  }) = _SigningOtpDto;

  factory SigningOtpDto.fromJson(Map<String, dynamic> json) =>
      _$SigningOtpDtoFromJson(json);
}

extension SigningOtpDtoMapper on SigningOtpDto {
  SigningOtp toEntity() =>
      SigningOtp(destinationMasked: destinationMasked, expiresAt: expiresAt);
}
