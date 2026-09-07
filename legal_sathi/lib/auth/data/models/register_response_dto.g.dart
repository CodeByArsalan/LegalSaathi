// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterResponseDto _$RegisterResponseDtoFromJson(Map<String, dynamic> json) =>
    _RegisterResponseDto(
      userId: (json['userId'] as num).toInt(),
      email: json['email'] as String,
      requiresEmailVerification: json['requiresEmailVerification'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$RegisterResponseDtoToJson(
  _RegisterResponseDto instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'email': instance.email,
  'requiresEmailVerification': instance.requiresEmailVerification,
  'message': instance.message,
};
