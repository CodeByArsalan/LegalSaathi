import 'dart:typed_data';

import '../../domain/entities/document_format.dart';
import '../models/document_detail_dto.dart';
import '../models/document_summary_dto.dart';
import '../models/generated_document_dto.dart';

/// `/Documents` endpoints. Implementations throw `AppException`.
///
/// There is deliberately no delete: the API exposes no DELETE route, so a
/// document cannot be removed from the app either.
abstract class DocumentRemoteDataSource {
  Future<List<DocumentSummaryDto>> getUserDocuments();

  Future<DocumentDetailDto> getDocument(int documentId);

  /// Creates the draft. Sending the answers here is the reliable path — the
  /// update endpoint is not (see [saveAnswers]).
  Future<DocumentDetailDto> createDocument({
    required int templateId,
    String? title,
    Map<String, String>? answers,
  });

  /// Persists answers and returns what the server holds afterwards, re-read.
  Future<DocumentDetailDto> saveAnswers({
    required int documentId,
    required Map<String, String> answers,
  });

  Future<GeneratedDocumentDto> generateDocument({
    required int documentId,
    required String language,
  });

  Future<Uint8List> download(int documentId, DocumentFormat format);
}
