// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  fullName: json['fullName'] as String,
  phoneNumber: json['phoneNumber'] as String,
  emailVerified: json['emailVerified'] as bool,
  role: json['role'] as String? ?? 'EndUser',
  cnic: json['cnic'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'fullName': instance.fullName,
  'phoneNumber': instance.phoneNumber,
  'emailVerified': instance.emailVerified,
  'role': instance.role,
  'cnic': instance.cnic,
  'createdAt': instance.createdAt?.toIso8601String(),
};
