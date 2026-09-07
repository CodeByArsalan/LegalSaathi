// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signing_otp_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SigningOtpDto _$SigningOtpDtoFromJson(Map<String, dynamic> json) =>
    _SigningOtpDto(
      destinationMasked: json['destinationMasked'] as String? ?? '',
      expiresAt: ServerDate.required(json['expiresAt']),
    );

Map<String, dynamic> _$SigningOtpDtoToJson(_SigningOtpDto instance) =>
    <String, dynamic>{
      'destinationMasked': instance.destinationMasked,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
