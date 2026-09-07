// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentDetailDto _$DocumentDetailDtoFromJson(Map<String, dynamic> json) =>
    _DocumentDetailDto(
      userDocumentId: (json['userDocumentId'] as num).toInt(),
      documentGuid: json['documentGuid'] as String,
      templateId: (json['templateId'] as num).toInt(),
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      templateTitleEn: json['templateTitleEn'] as String? ?? '',
      templateTitleUr: json['templateTitleUr'] as String? ?? '',
      title: json['title'] as String? ?? '',
      formAnswersJson: json['formAnswersJson'] as String?,
      status: json['status'] as String? ?? 'Draft',
      statusId: (json['statusId'] as num?)?.toInt() ?? 1,
      isPaid: json['isPaid'] as bool? ?? false,
      createdAt: ServerDate.required(json['createdAt']),
      updatedAt: ServerDate.parse(json['updatedAt']),
      completedAt: ServerDate.parse(json['completedAt']),
      storagePath: json['storagePath'] as String?,
      docxStoragePath: json['docxStoragePath'] as String?,
      documentHash: json['documentHash'] as String?,
    );

Map<String, dynamic> _$DocumentDetailDtoToJson(_DocumentDetailDto instance) =>
    <String, dynamic>{
      'userDocumentId': instance.userDocumentId,
      'documentGuid': instance.documentGuid,
      'templateId': instance.templateId,
      'userId': instance.userId,
      'templateTitleEn': instance.templateTitleEn,
      'templateTitleUr': instance.templateTitleUr,
      'title': instance.title,
      'formAnswersJson': instance.formAnswersJson,
      'status': instance.status,
      'statusId': instance.statusId,
      'isPaid': instance.isPaid,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'storagePath': instance.storagePath,
      'docxStoragePath': instance.docxStoragePath,
      'documentHash': instance.documentHash,
    };
