import 'dart:convert';
import 'dart:typed_data';

import '../../../core/constants/asset_paths.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/mock/mock_data_source.dart';
import '../../../core/mock/mock_session_store.dart';
import '../../domain/entities/document_format.dart';
import '../models/document_detail_dto.dart';
import '../models/document_summary_dto.dart';
import '../models/generated_document_dto.dart';
import 'document_remote_data_source.dart';

/// Stands in for `/Documents`. Seeded rows are copied into [MockSessionStore] on
/// first use so creating, saving and generating behave like the real backend for
/// the length of the run.
///
/// Rows are held in the detail shape and read back through whichever DTO the
/// caller asked for, which is how the API itself splits them. `formAnswersJson`
/// stays a JSON *string* in the bundled asset, so demo mode exercises the same
/// second decode the live payload needs.
class DocumentRemoteDataSourceMock extends MockDataSource
    implements DocumentRemoteDataSource {
  DocumentRemoteDataSourceMock(this._session);

  final MockSessionStore _session;

  bool _seeded = false;

  @override
  Future<List<DocumentSummaryDto>> getUserDocuments() async {
    await _ensureSeeded();
    final List<DocumentSummaryDto> documents =
        _session.documents.map(DocumentSummaryDto.fromJson).toList()..sort(
          (DocumentSummaryDto a, DocumentSummaryDto b) =>
              b.createdAt.compareTo(a.createdAt),
        );
    return withLatency(documents);
  }

  @override
  Future<DocumentDetailDto> getDocument(int documentId) async {
    await _ensureSeeded();
    return withLatency(DocumentDetailDto.fromJson(_requireRow(documentId)));
  }

  @override
  Future<DocumentDetailDto> createDocument({
    required int templateId,
    String? title,
    Map<String, String>? answers,
  }) async {
    await _ensureSeeded();

    final (String titleEn, String titleUr) = await _templateTitles(templateId);
    final String now = DateTime.now().toIso8601String();
    final Map<String, dynamic> row = <String, dynamic>{
      'userDocumentId': _session.nextDocumentId(),
      'documentGuid': _newGuid(),
      'userId': 0,
      'templateId': templateId,
      'templateTitleEn': titleEn,
      'templateTitleUr': titleUr,
      'title': title?.trim() ?? '',
      'formAnswersJson': answers == null ? null : jsonEncode(answers),
      'status': 'Draft',
      'statusId': 1,
      'isPaid': false,
      'storagePath': null,
      'docxStoragePath': null,
      'documentHash': null,
      'createdAt': now,
      'updatedAt': now,
      'completedAt': null,
    };
    _session.putDocument(row);

    return withLatency(DocumentDetailDto.fromJson(row));
  }

  @override
  Future<DocumentDetailDto> saveAnswers({
    required int documentId,
    required Map<String, String> answers,
  }) async {
    await _ensureSeeded();
    final Map<String, dynamic> current = _requireRow(documentId);

    final Map<String, dynamic> next = Map<String, dynamic>.of(current)
      ..['formAnswersJson'] = jsonEncode(<String, String>{
        ...parseAnswers(current['formAnswersJson'] as String?),
        ...answers,
      })
      ..['updatedAt'] = DateTime.now().toIso8601String();

    _session.putDocument(next);
    return withLatency(DocumentDetailDto.fromJson(next));
  }

  @override
  Future<GeneratedDocumentDto> generateDocument({
    required int documentId,
    required String language,
  }) async {
    await _ensureSeeded();
    final Map<String, dynamic> current = _requireRow(documentId);
    final String now = DateTime.now().toIso8601String();

    // The API renders a PDF and a DOCX here. Demo mode has nothing to render, so
    // the storage paths stay null and `LegalDocument.hasDownloads` keeps the
    // preview's download buttons hidden instead of offering a file that cannot
    // exist.
    final Map<String, dynamic> next = Map<String, dynamic>.of(current)
      ..['status'] = 'Completed'
      ..['statusId'] = 2
      ..['updatedAt'] = now
      ..['completedAt'] = now;
    _session.putDocument(next);

    return withLatency(
      GeneratedDocumentDto(
        userDocumentId: documentId,
        documentGuid: current['documentGuid'] as String,
        status: 'Completed',
      ),
    );
  }

  @override
  Future<Uint8List> download(int documentId, DocumentFormat format) async {
    await _ensureSeeded();
    _requireRow(documentId);
    throw const AppException(
      'Offline demo mode keeps no rendered file to download.',
      kind: AppExceptionKind.notFound,
      statusCode: 404,
    );
  }

  Future<void> _ensureSeeded() async {
    if (_seeded) return;
    for (final Map<String, dynamic> row in await loadRows(
      AssetPaths.mockDocuments,
    )) {
      _session.putDocument(row);
    }
    _seeded = true;
  }

  /// The API stamps the template's titles onto the document it creates; demo
  /// mode reads them out of the bundled catalogue so a new draft is not
  /// nameless in the list.
  Future<(String, String)> _templateTitles(int templateId) async {
    for (final Map<String, dynamic> row in await loadRows(
      AssetPaths.mockTemplates,
    )) {
      if (row['templateId'] == templateId) {
        return (
          row['titleEn'] as String? ?? '',
          row['titleUr'] as String? ?? '',
        );
      }
    }
    return ('', '');
  }

  Map<String, dynamic> _requireRow(int documentId) {
    final Map<String, dynamic>? row = _session.document(documentId);
    if (row == null) {
      throw AppException(
        'No document with id $documentId.',
        kind: AppExceptionKind.notFound,
        statusCode: 404,
      );
    }
    return row;
  }

  /// An opaque unique-enough stand-in for the server's GUID. Only its first
  /// eight characters are ever read, for the download filename.
  String _newGuid() =>
      DateTime.now().microsecondsSinceEpoch.toRadixString(16).padLeft(16, '0');
}
