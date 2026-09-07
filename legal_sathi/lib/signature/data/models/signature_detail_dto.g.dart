// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignatureDetailDto _$SignatureDetailDtoFromJson(Map<String, dynamic> json) =>
    _SignatureDetailDto(
      signatureId: (json['signatureId'] as num).toInt(),
      userDocumentId: (json['userDocumentId'] as num).toInt(),
      signerName: json['signerName'] as String? ?? '',
      signerCnic: json['signerCnic'] as String? ?? '',
      signerRole: json['signerRole'] as String? ?? '',
      signatureUri: json['signatureUri'] as String? ?? '',
      isOtpVerified: json['isOtpVerified'] as bool? ?? false,
      signerEmail: json['signerEmail'] as String?,
      signerPhone: json['signerPhone'] as String?,
      ipAddress: json['ipAddress'] as String?,
      signedAt: ServerDate.required(json['signedAt']),
    );

Map<String, dynamic> _$SignatureDetailDtoToJson(_SignatureDetailDto instance) =>
    <String, dynamic>{
      'signatureId': instance.signatureId,
      'userDocumentId': instance.userDocumentId,
      'signerName': instance.signerName,
      'signerCnic': instance.signerCnic,
      'signerRole': instance.signerRole,
      'signatureUri': instance.signatureUri,
      'isOtpVerified': instance.isOtpVerified,
      'signerEmail': instance.signerEmail,
      'signerPhone': instance.signerPhone,
      'ipAddress': instance.ipAddress,
      'signedAt': instance.signedAt.toIso8601String(),
    };
