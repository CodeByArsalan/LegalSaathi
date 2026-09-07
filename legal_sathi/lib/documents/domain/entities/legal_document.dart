import 'package:freezed_annotation/freezed_annotation.dart';

import 'document_format.dart';
import 'document_status.dart';

part 'legal_document.freezed.dart';

/// A document the user is building, has built, or has signed.
///
/// One shape serves both endpoints: `GET /Documents` returns summaries with no
/// answers and no storage paths, while `GET /Documents/{id}` adds
/// `formAnswersJson`, the rendered file locations and the hash. The detail-only
/// members therefore stay null (or empty, for [answers]) on a list row.
@freezed
abstract class LegalDocument with _$LegalDocument {
  const factory LegalDocument({
    required int id,

    /// The server's `documentGuid` — the name its rendered files are stored
    /// under, and the value its download URLs are built from.
    required String guid,
    required int templateId,
    required String templateTitleEn,
    required String templateTitleUr,

    /// The user's own label for this copy. Empty until one is chosen.
    required String title,
    required DocumentStatus status,
    required bool isPaid,
    required DateTime createdAt,
    @Default(<String, String>{}) Map<String, String> answers,
    String? storagePath,
    String? docxStoragePath,
    String? documentHash,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) = _LegalDocument;
}

extension LegalDocumentX on LegalDocument {
  String templateTitle(String languageCode) =>
      languageCode == 'ur' ? templateTitleUr : templateTitleEn;

  /// What the list should call this document: the user's label when they gave
  /// one, otherwise the template it came from.
  String displayName(String languageCode) =>
      title.trim().isEmpty ? templateTitle(languageCode) : title;

  /// Answers keyed by the template's `fieldKey`.
  String valueFor(String fieldKey) => answers[fieldKey] ?? '';

  int get answeredCount =>
      answers.values.where((String value) => value.trim().isNotEmpty).length;

  /// Both rendered formats, when the document has been generated.
  bool get hasDownloads => storagePath != null || docxStoragePath != null;

  /// The name the API's own download endpoints give the file — the title with
  /// spaces underscored, plus the first eight characters of the guid — so a copy
  /// saved from the app matches what the web client produces.
  String fileNameFor(DocumentFormat format) {
    final String label = title.trim().isEmpty ? 'document-$id' : title.trim();
    final String suffix = guid.length >= 8 ? guid.substring(0, 8) : guid;
    return '${label.replaceAll(' ', '_')}_$suffix.${format.extension}';
  }
}
