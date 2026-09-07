import 'package:freezed_annotation/freezed_annotation.dart';

import 'document_status.dart';

part 'document_generation.freezed.dart';

/// What `POST /Documents/{id}/generate` reports.
///
/// The payload also carries `pdfDownloadUrl` and `docxDownloadUrl`, but they are
/// path-only (`/api/documents/3/download/pdf`) and relative to the host rather
/// than to the API base, so they are dropped: the app builds its own download
/// requests from the document id, which cannot drift from the host it is
/// already talking to.
@freezed
abstract class DocumentGeneration with _$DocumentGeneration {
  const factory DocumentGeneration({
    required int documentId,
    required String guid,
    required DocumentStatus status,
    required bool hasPdf,
    required bool hasDocx,
  }) = _DocumentGeneration;
}
