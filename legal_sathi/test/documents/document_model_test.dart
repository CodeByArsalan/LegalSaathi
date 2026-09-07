import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/network/api_envelope.dart';
import 'package:legal_sathi/documents/data/models/document_detail_dto.dart';
import 'package:legal_sathi/documents/data/models/document_summary_dto.dart';
import 'package:legal_sathi/documents/data/models/generated_document_dto.dart';
import 'package:legal_sathi/documents/domain/entities/document_format.dart';
import 'package:legal_sathi/documents/domain/entities/document_generation.dart';
import 'package:legal_sathi/documents/domain/entities/document_language.dart';
import 'package:legal_sathi/documents/domain/entities/document_status.dart';
import 'package:legal_sathi/documents/domain/entities/legal_document.dart';

import '../support/fixtures.dart';

/// The document model against payloads captured from the live API: the answers
/// column that has to be decoded twice, the two statuses the server sends for
/// one document, and the shapes both endpoints produce.
void main() {
  group('formAnswersJson', () {
    test('is a JSON object inside a string column', () {
      expect(
        parseAnswers('{"DeponentName":"Ali","Cnic":"35201-1234567-1"}'),
        <String, String>{'DeponentName': 'Ali', 'Cnic': '35201-1234567-1'},
      );
    });

    test('coerces values that are not strings', () {
      expect(parseAnswers('{"Rent":15000,"Paid":true}'), <String, String>{
        'Rent': '15000',
        'Paid': 'true',
      });
      expect(parseAnswers('{"Note":null}'), <String, String>{'Note': ''});
    });

    test('yields no answers rather than crashing on anything unexpected', () {
      expect(parseAnswers(null), isEmpty);
      expect(parseAnswers(''), isEmpty);
      expect(parseAnswers('   '), isEmpty);
      expect(parseAnswers('{"unclosed'), isEmpty);
      expect(parseAnswers('["not","an","object"]'), isEmpty);
    });
  });

  group('DocumentStatus', () {
    test('parses the names the server sends, in whatever case', () {
      expect(DocumentStatus.parse('Draft'), DocumentStatus.draft);
      expect(
        DocumentStatus.parse('PendingSignature'),
        DocumentStatus.pendingSignature,
      );
      expect(
        DocumentStatus.parse(' underlawyerreview '),
        DocumentStatus.underLawyerReview,
      );
      expect(DocumentStatus.parse('Archived'), DocumentStatus.archived);
    });

    test('an unknown name falls back to draft, and tryParse says so', () {
      expect(DocumentStatus.tryParse('Something New'), isNull);
      expect(DocumentStatus.parse('Something New'), DocumentStatus.draft);
      expect(DocumentStatus.parse(null), DocumentStatus.draft);
    });

    test('the numeric id covers a name this build does not know', () {
      expect(DocumentStatus.fromId(4), DocumentStatus.signed);
      expect(DocumentStatus.fromId(99), DocumentStatus.draft);
      // The name wins when both are present and agree.
      expect(DocumentStatus.resolve('Signed', 1), DocumentStatus.signed);
      expect(DocumentStatus.resolve('Bogus', 2), DocumentStatus.completed);
      expect(DocumentStatus.signed.id, 4);
      expect(DocumentStatus.archived.id, 7);
    });

    test('the lifecycle predicates drive what the screens offer', () {
      expect(DocumentStatus.draft.isEditable, isTrue);
      expect(DocumentStatus.completed.isEditable, isFalse);

      expect(DocumentStatus.draft.isGenerated, isFalse);
      expect(DocumentStatus.completed.isGenerated, isTrue);

      expect(DocumentStatus.completed.needsSignature, isTrue);
      expect(DocumentStatus.pendingSignature.needsSignature, isTrue);
      expect(DocumentStatus.signed.needsSignature, isFalse);

      expect(DocumentStatus.signed.isSigned, isTrue);
      expect(DocumentStatus.lawyerApproved.isSigned, isTrue);
      expect(DocumentStatus.archived.isClosed, isTrue);
    });

    test('every status has a translation key', () {
      for (final DocumentStatus status in DocumentStatus.values) {
        expect(status.l10nKey, startsWith('documents.status.'));
      }
      expect(
        DocumentStatus.pendingSignature.l10nKey,
        'documents.status.pending_signature',
      );
    });
  });

  group('generate languages', () {
    test('are the codes the endpoint accepts', () {
      expect(DocumentLanguage.english.code, 'en');
      expect(DocumentLanguage.urdu.code, 'ur');
      expect(DocumentLanguage.bilingual.code, 'bilingual');
    });
  });

  group('live payloads', () {
    test('a draft comes back with its answers and no files yet', () {
      final LegalDocument document = _detail('document_create');

      expect(document.id, 3);
      expect(document.status, DocumentStatus.draft);
      expect(document.status.isEditable, isTrue);
      expect(document.answeredCount, 5);
      expect(document.valueFor('Cnic'), '35201-1234567-1');
      expect(document.hasDownloads, isFalse);
      expect(document.completedAt, isNull);
      expect(document.displayName('en'), 'Fixture Affidavit');
      expect(
        document.fileNameFor(DocumentFormat.pdf),
        'Fixture_Affidavit_6f2cfb93.pdf',
      );
    });

    test('a signed document carries both file locations and the hash', () {
      final LegalDocument document = _detail('document_detail');

      expect(document.id, 4);
      expect(document.status, DocumentStatus.signed);
      expect(document.status.isSigned, isTrue);
      expect(document.isPaid, isFalse);
      expect(document.hasDownloads, isTrue);
      expect(document.documentHash, hasLength(64));
      expect(document.completedAt, isNotNull);
      expect(document.answers, hasLength(5));
      // Naive timestamps are read as UTC rather than as device-local time.
      expect(document.createdAt.isUtc, isTrue);
      expect(
        document.fileNameFor(DocumentFormat.docx),
        'Answers_Probe_344ec64d.docx',
      );
    });

    test('the list is a summary: no answers and no file locations', () {
      final List<LegalDocument> rows = ApiEnvelope.unwrapList<LegalDocument>(
        fixtureResponse('documents_list', statusCode: 200),
        (Map<String, dynamic> json) =>
            DocumentSummaryDto.fromJson(json).toEntity(),
      );

      expect(rows, hasLength(2));
      expect(rows.first.id, 4);
      expect(rows.first.status, DocumentStatus.signed);
      expect(rows.first.answers, isEmpty);
      expect(rows.first.hasDownloads, isFalse);
      expect(rows.first.completedAt, isNotNull);
      // The list keeps the server's order, newest first.
      expect(rows.last.id, 3);
    });

    test('generation reports which formats now exist', () {
      final DocumentGeneration generation =
          ApiEnvelope.unwrapObject<GeneratedDocumentDto>(
            fixtureResponse('document_generate', statusCode: 200),
            GeneratedDocumentDto.fromJson,
          ).toEntity();

      expect(generation.documentId, 3);
      expect(generation.status, DocumentStatus.completed);
      expect(generation.hasPdf, isTrue);
      expect(generation.hasDocx, isTrue);
      expect(generation.guid, '6f2cfb93-1a2f-47aa-83fe-2270a8eac69f');
    });

    test('an empty document list is a success with nothing in it', () {
      final List<LegalDocument> rows = ApiEnvelope.unwrapList<LegalDocument>(
        fixtureResponse('documents_list_empty', statusCode: 200),
        (Map<String, dynamic> json) =>
            DocumentSummaryDto.fromJson(json).toEntity(),
      );

      expect(rows, isEmpty);
    });
  });

  group('file names', () {
    test('an untitled document falls back to its id', () {
      final LegalDocument document = LegalDocument(
        id: 12,
        guid: 'abcd1234-ef56-7890-abcd-ef1234567890',
        templateId: 1,
        templateTitleEn: 'General Affidavit',
        templateTitleUr: 'عمومی بیان حلفی',
        title: '',
        status: DocumentStatus.completed,
        isPaid: false,
        createdAt: DateTime.utc(2026, 9, 7),
      );

      // The list shows the template's name even though the title is empty.
      expect(document.displayName('en'), 'General Affidavit');
      expect(document.displayName('ur'), 'عمومی بیان حلفی');
      expect(
        document.fileNameFor(DocumentFormat.pdf),
        'document-12_abcd1234.pdf',
      );
    });

    test('a guid shorter than the prefix is used whole', () {
      final LegalDocument document = LegalDocument(
        id: 1,
        guid: 'abc',
        templateId: 1,
        templateTitleEn: 'General Affidavit',
        templateTitleUr: 'عمومی بیان حلفی',
        title: 'My Deed',
        status: DocumentStatus.draft,
        isPaid: false,
        createdAt: DateTime.utc(2026, 9, 7),
      );

      expect(document.fileNameFor(DocumentFormat.docx), 'My_Deed_abc.docx');
    });

    test('formats carry the mime type the share sheet needs', () {
      expect(DocumentFormat.pdf.mimeType, 'application/pdf');
      expect(
        DocumentFormat.docx.mimeType,
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      );
    });
  });
}

LegalDocument _detail(String fixture) =>
    ApiEnvelope.unwrapObject<DocumentDetailDto>(
      fixtureResponse(fixture, statusCode: 200),
      DocumentDetailDto.fromJson,
    ).toEntity();
