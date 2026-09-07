import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/errors/app_exception.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';
import 'package:legal_sathi/core/mock/mock_session_store.dart';
import 'package:legal_sathi/documents/data/datasources/document_remote_data_source.dart';
import 'package:legal_sathi/documents/data/datasources/document_remote_data_source_mock.dart';
import 'package:legal_sathi/documents/data/models/document_detail_dto.dart';
import 'package:legal_sathi/documents/data/models/document_summary_dto.dart';
import 'package:legal_sathi/documents/data/models/generated_document_dto.dart';
import 'package:legal_sathi/documents/data/repositories/document_repository_impl.dart';
import 'package:legal_sathi/documents/domain/entities/document_format.dart';
import 'package:legal_sathi/documents/domain/entities/document_generation.dart';
import 'package:legal_sathi/documents/domain/entities/document_language.dart';
import 'package:legal_sathi/documents/domain/entities/document_status.dart';
import 'package:legal_sathi/documents/domain/entities/legal_document.dart';
import 'package:legal_sathi/documents/domain/repositories/document_repository.dart';

/// The repository's one piece of judgement, and the round trip behind it.
///
/// `PUT /Documents/{id}/answers` answers 400 "Failed to update document
/// answers." and stores the answers anyway, so neither a success nor a failure
/// from that call means anything. The data source ignores it and re-reads the
/// document; what the repository does with that re-read is what these tests pin
/// down, because a write that silently did not land has to reach the user as a
/// failure rather than as a draft that looks saved.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const Map<String, String> answers = <String, String>{
    'DeponentName': 'Muhammad Ali',
    'Cnic': '35201-1234567-1',
  };

  group('answer verification', () {
    test('a write that landed is a success', () async {
      final DocumentRepository repository = DocumentRepositoryImpl(
        _FakeUpdate(),
      );

      final Result<LegalDocument> result = await repository.saveAnswers(
        documentId: 7,
        answers: answers,
      );

      expect(result.failure, isNull);
      expect(result.value!.answers, answers);
    });

    test('a write that did not land names the answers it lost', () async {
      final DocumentRepository repository = DocumentRepositoryImpl(
        _FakeUpdate(dropped: const <String>{'Cnic'}),
      );

      final Result<LegalDocument> result = await repository.saveAnswers(
        documentId: 7,
        answers: answers,
      );

      expect(result.value, isNull);
      expect(result.failure, isA<ServerFailure>());
      expect(result.failure!.message, contains('Cnic'));
      expect(result.failure!.message, isNot(contains('DeponentName')));
    });

    test('a re-read that cannot be made is reported as that failure', () async {
      final DocumentRepository repository = DocumentRepositoryImpl(
        _FakeUpdate(
          updateFailure: const AppException(
            'No internet connection.',
            kind: AppExceptionKind.network,
          ),
        ),
      );

      final Result<LegalDocument> result = await repository.saveAnswers(
        documentId: 7,
        answers: answers,
      );

      expect(result.value, isNull);
      expect(result.failure, isA<NetworkFailure>());
    });
  });

  group('round trip', () {
    late MockSessionStore session;
    late DocumentRepository repository;

    setUp(() {
      session = MockSessionStore();
      repository = DocumentRepositoryImpl(
        DocumentRemoteDataSourceMock(session),
      );
    });

    test('create, save and generate walk the statuses the API uses', () async {
      final LegalDocument created = (await repository.createDocument(
        templateId: 1,
        answers: answers,
      )).value!;

      expect(created.status, DocumentStatus.draft);
      expect(created.status.isEditable, isTrue);
      expect(created.templateTitleEn, 'General Affidavit (Bayan-e-Halfi)');
      expect(created.answers, answers);
      expect(created.hasDownloads, isFalse);

      // Updating merges into what is already stored rather than replacing it,
      // which is how the wizard can save one page at a time.
      final LegalDocument saved = (await repository.saveAnswers(
        documentId: created.id,
        answers: const <String, String>{'Address': '12 Test Street'},
      )).value!;

      expect(saved.answers.keys, containsAll(answers.keys));
      expect(saved.valueFor('Address'), '12 Test Street');

      final DocumentGeneration generation = (await repository.generateDocument(
        documentId: created.id,
        language: DocumentLanguage.bilingual,
      )).value!;

      expect(generation.documentId, created.id);
      expect(generation.status, DocumentStatus.completed);
      // Demo mode renders no file, so there is nothing to offer for download.
      expect(generation.hasPdf, isFalse);
      expect(generation.hasDocx, isFalse);

      final LegalDocument read = (await repository.getDocument(
        created.id,
      )).value!;
      expect(read.status, DocumentStatus.completed);
      expect(read.completedAt, isNotNull);

      final List<LegalDocument> listed =
          (await repository.getUserDocuments()).value!;
      expect(
        listed.map((LegalDocument document) => document.id),
        contains(created.id),
      );
      expect(session.document(created.id), isNotNull);
    });

    test('a document that does not exist is a not-found failure', () async {
      final Result<LegalDocument> result = await repository.getDocument(9999);

      expect(result.value, isNull);
      expect(result.failure, isA<NotFoundFailure>());
    });

    test('demo mode keeps no rendered file to hand over', () async {
      final LegalDocument created = (await repository.createDocument(
        templateId: 1,
      )).value!;

      final Result<Uint8List> result = await repository.download(
        documentId: created.id,
        format: DocumentFormat.pdf,
      );

      expect(result.value, isNull);
      expect(result.failure, isA<NotFoundFailure>());
    });
  });
}

/// Stands in for the update endpoint. It answers with the document as it would
/// be re-read afterwards, minus any key in [dropped] — which is what a write
/// that did not land looks like from the app's side.
final class _FakeUpdate implements DocumentRemoteDataSource {
  _FakeUpdate({this.dropped = const <String>{}, this.updateFailure});

  final Set<String> dropped;
  final AppException? updateFailure;

  Map<String, String> _stored = const <String, String>{};

  @override
  Future<DocumentDetailDto> saveAnswers({
    required int documentId,
    required Map<String, String> answers,
  }) async {
    final AppException? failure = updateFailure;
    if (failure != null) throw failure;

    _stored = Map<String, String>.fromEntries(
      answers.entries.where(
        (MapEntry<String, String> entry) => !dropped.contains(entry.key),
      ),
    );
    return _detail(documentId);
  }

  DocumentDetailDto _detail(int documentId) => DocumentDetailDto(
    userDocumentId: documentId,
    documentGuid: 'guid-$documentId',
    templateId: 1,
    formAnswersJson: jsonEncode(_stored),
    createdAt: DateTime.utc(2026, 9, 7),
  );

  @override
  Future<List<DocumentSummaryDto>> getUserDocuments() =>
      throw UnimplementedError();

  @override
  Future<DocumentDetailDto> getDocument(int documentId) =>
      throw UnimplementedError();

  @override
  Future<DocumentDetailDto> createDocument({
    required int templateId,
    String? title,
    Map<String, String>? answers,
  }) => throw UnimplementedError();

  @override
  Future<GeneratedDocumentDto> generateDocument({
    required int documentId,
    required String language,
  }) => throw UnimplementedError();

  @override
  Future<Uint8List> download(int documentId, DocumentFormat format) =>
      throw UnimplementedError();
}
