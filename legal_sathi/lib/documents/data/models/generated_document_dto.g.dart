// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_document_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeneratedDocumentDto _$GeneratedDocumentDtoFromJson(
  Map<String, dynamic> json,
) => _GeneratedDocumentDto(
  userDocumentId: (json['userDocumentId'] as num).toInt(),
  documentGuid: json['documentGuid'] as String,
  status: json['status'] as String? ?? 'Completed',
  storagePath: json['storagePath'] as String?,
  docxStoragePath: json['docxStoragePath'] as String?,
  documentHash: json['documentHash'] as String?,
  pdfDownloadUrl: json['pdfDownloadUrl'] as String?,
  docxDownloadUrl: json['docxDownloadUrl'] as String?,
);

Map<String, dynamic> _$GeneratedDocumentDtoToJson(
  _GeneratedDocumentDto instance,
) => <String, dynamic>{
  'userDocumentId': instance.userDocumentId,
  'documentGuid': instance.documentGuid,
  'status': instance.status,
  'storagePath': instance.storagePath,
  'docxStoragePath': instance.docxStoragePath,
  'documentHash': instance.documentHash,
  'pdfDownloadUrl': instance.pdfDownloadUrl,
  'docxDownloadUrl': instance.docxDownloadUrl,
};
