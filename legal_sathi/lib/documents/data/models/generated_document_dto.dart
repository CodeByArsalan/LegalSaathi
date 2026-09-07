import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/document_generation.dart';
import '../../domain/entities/document_status.dart';

part 'generated_document_dto.freezed.dart';
part 'generated_document_dto.g.dart';

/// Wire shape of `POST /Documents/{id}/generate`.
///
/// `pdfDownloadUrl` and `docxDownloadUrl` are read only to learn whether each
/// format exists; their values are host-relative paths that the app has no use
/// for, since it builds download requests from the document id.
@freezed
abstract class GeneratedDocumentDto with _$GeneratedDocumentDto {
  const factory GeneratedDocumentDto({
    required int userDocumentId,
    required String documentGuid,
    @Default('Completed') String status,
    String? storagePath,
    String? docxStoragePath,
    String? documentHash,
    String? pdfDownloadUrl,
    String? docxDownloadUrl,
  }) = _GeneratedDocumentDto;

  factory GeneratedDocumentDto.fromJson(Map<String, dynamic> json) =>
      _$GeneratedDocumentDtoFromJson(json);
}

extension GeneratedDocumentDtoMapper on GeneratedDocumentDto {
  DocumentGeneration toEntity() => DocumentGeneration(
    documentId: userDocumentId,
    guid: documentGuid,
    status: DocumentStatus.parse(status),
    hasPdf: _present(pdfDownloadUrl) || _present(storagePath),
    hasDocx: _present(docxDownloadUrl) || _present(docxStoragePath),
  );

  static bool _present(String? value) => value?.trim().isNotEmpty ?? false;
}
