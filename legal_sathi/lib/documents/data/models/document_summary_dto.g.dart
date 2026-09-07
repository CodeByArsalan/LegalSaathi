// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentSummaryDto _$DocumentSummaryDtoFromJson(Map<String, dynamic> json) =>
    _DocumentSummaryDto(
      userDocumentId: (json['userDocumentId'] as num).toInt(),
      documentGuid: json['documentGuid'] as String,
      templateId: (json['templateId'] as num).toInt(),
      templateTitleEn: json['templateTitleEn'] as String? ?? '',
      templateTitleUr: json['templateTitleUr'] as String? ?? '',
      title: json['title'] as String? ?? '',
      status: json['status'] as String? ?? 'Draft',
      statusId: (json['statusId'] as num?)?.toInt() ?? 1,
      isPaid: json['isPaid'] as bool? ?? false,
      createdAt: ServerDate.required(json['createdAt']),
      completedAt: ServerDate.parse(json['completedAt']),
    );

Map<String, dynamic> _$DocumentSummaryDtoToJson(_DocumentSummaryDto instance) =>
    <String, dynamic>{
      'userDocumentId': instance.userDocumentId,
      'documentGuid': instance.documentGuid,
      'templateId': instance.templateId,
      'templateTitleEn': instance.templateTitleEn,
      'templateTitleUr': instance.templateTitleUr,
      'title': instance.title,
      'status': instance.status,
      'statusId': instance.statusId,
      'isPaid': instance.isPaid,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };
