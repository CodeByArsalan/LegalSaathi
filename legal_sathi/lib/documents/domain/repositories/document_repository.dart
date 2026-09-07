import 'dart:typed_data';

import '../../../core/errors/result.dart';
import '../entities/document_format.dart';
import '../entities/document_generation.dart';
import '../entities/document_language.dart';
import '../entities/legal_document.dart';

/// The bearer token identifies the owner, so no user id travels in these calls.
///
/// There is no delete: the API exposes no DELETE route, so a document cannot be
/// removed from the app either.
abstract class DocumentRepository {
  /// Summaries, newest first. A summary carries no answers — read the document
  /// itself for those.
  Future<Result<List<LegalDocument>>> getUserDocuments();

  Future<Result<LegalDocument>> getDocument(int documentId);

  /// Creates the draft, storing [answers] in the same call. Sending them here is
  /// the reliable path; see [saveAnswers].
  Future<Result<LegalDocument>> createDocument({
    required int templateId,
    String? title,
    Map<String, String>? answers,
  });

  /// Persists answers to a draft and returns the document as the server holds it
  /// afterwards. Fails if any of [answers] did not land.
  Future<Result<LegalDocument>> saveAnswers({
    required int documentId,
    required Map<String, String> answers,
  });

  Future<Result<DocumentGeneration>> generateDocument({
    required int documentId,
    required DocumentLanguage language,
  });

  /// The rendered file's bytes, named by the API from the document's title.
  Future<Result<Uint8List>> download({
    required int documentId,
    required DocumentFormat format,
  });
}
