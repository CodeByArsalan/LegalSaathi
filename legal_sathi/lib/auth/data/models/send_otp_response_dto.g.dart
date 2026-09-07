// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendOtpResponseDto _$SendOtpResponseDtoFromJson(Map<String, dynamic> json) =>
    _SendOtpResponseDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      expirySeconds: (json['expirySeconds'] as num).toInt(),
    );

Map<String, dynamic> _$SendOtpResponseDtoToJson(_SendOtpResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'expirySeconds': instance.expirySeconds,
    };
