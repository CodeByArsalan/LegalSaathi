import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';
import 'package:legal_sathi/core/mock/mock_session_store.dart';
import 'package:legal_sathi/core/widgets/state_view.dart';
import 'package:legal_sathi/documents/cubit/document_builder_cubit.dart';
import 'package:legal_sathi/documents/cubit/document_builder_state.dart';
import 'package:legal_sathi/documents/data/datasources/document_remote_data_source_mock.dart';
import 'package:legal_sathi/documents/data/models/document_detail_dto.dart';
import 'package:legal_sathi/documents/data/repositories/document_repository_impl.dart';
import 'package:legal_sathi/documents/domain/entities/document_generation.dart';
import 'package:legal_sathi/documents/domain/entities/document_status.dart';
import 'package:legal_sathi/documents/domain/entities/legal_document.dart';
import 'package:legal_sathi/documents/domain/repositories/document_repository.dart';
import 'package:legal_sathi/documents/domain/usecases/create_document.dart';
import 'package:legal_sathi/documents/domain/usecases/generate_document.dart';
import 'package:legal_sathi/documents/domain/usecases/save_answers.dart';
import 'package:legal_sathi/templates/data/datasources/template_remote_data_source_mock.dart';
import 'package:legal_sathi/templates/data/repositories/template_repository_impl.dart';
import 'package:legal_sathi/templates/domain/entities/field_type.dart';
import 'package:legal_sathi/templates/domain/entities/legal_template.dart';
import 'package:legal_sathi/templates/domain/entities/template_field.dart';
import 'package:legal_sathi/templates/domain/repositories/template_repository.dart';
import 'package:legal_sathi/templates/domain/usecases/get_template_detail.dart';

/// The wizard end to end against the offline backend: the template's questions
/// come from the catalogue asset, the pages come from the server's own
/// `stepNumber`, and the draft is created on the first save rather than on entry.
///
/// Both repositories are the real ones, so this covers cubit → usecase →
/// repository → data source → session store, which is the path the app runs.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const String slug = 'residential-rent-agreement';

  late MockSessionStore session;
  late DocumentRepository documents;
  late TemplateRepository templates;

  /// The offline backend copies its bundled rows into the session on first use,
  /// so counts are asserted relative to that seeding rather than absolutely.
  late int seeded;

  setUp(() async {
    session = MockSessionStore();
    documents = DocumentRepositoryImpl(DocumentRemoteDataSourceMock(session));
    templates = TemplateRepositoryImpl(TemplateRemoteDataSourceMock());

    await documents.getUserDocuments();
    seeded = session.documents.length;
  });

  DocumentBuilderCubit builderFor(String templateSlug) => DocumentBuilderCubit(
    getTemplateDetail: GetTemplateDetailUseCase(templates),
    createDocument: CreateDocumentUseCase(documents),
    saveAnswers: SaveAnswersUseCase(documents),
    generateDocument: GenerateDocumentUseCase(documents),
    slug: templateSlug,
  );

  /// Runs [body] against a fresh cubit and closes it, so a failing expectation
  /// cannot leak a subscription.
  Future<void> withBuilder(
    Future<void> Function(DocumentBuilderCubit cubit) body, {
    String templateSlug = slug,
  }) async {
    final DocumentBuilderCubit cubit = builderFor(templateSlug);
    try {
      await body(cubit);
    } finally {
      await cubit.close();
    }
  }

  test('start reads the pages the server chose and stores nothing', () async {
    await withBuilder((DocumentBuilderCubit cubit) async {
      await cubit.start();
      final DocumentBuilderReady ready = cubit.state.readyOrNull!;

      // Nine questions the backend splits over two pages of five and four.
      final LegalTemplate template = ready.template;
      expect(template.title('en'), 'Residential Rent Agreement');
      expect(ready.steps, hasLength(2));
      expect(ready.steps.first, hasLength(5));
      expect(ready.steps.last, hasLength(4));
      expect(ready.currentStep, 0);
      expect(ready.isLastStep, isFalse);
      expect(ready.totalSteps, template.stepCount);

      // Reading the questions must not leave a draft behind.
      expect(ready.document, isNull);
      expect(session.documents, hasLength(seeded));
    });
  });

  test('start surfaces the server answer to an unknown slug', () async {
    await withBuilder((DocumentBuilderCubit cubit) async {
      await cubit.start();

      expect(cubit.state.viewState, ViewState.failure);
      expect(cubit.state.readyOrNull, isNull);
      // The API answers a bad slug with a 400 carrying the reason, not a 404.
      expect(cubit.state.failure, isA<ValidationFailure>());
      expect(
        cubit.state.failure!.message,
        contains("Template with slug 'no-such-template' not found."),
      );
    }, templateSlug: 'no-such-template');
  });

  test('next refuses to advance while a required answer is missing', () async {
    await withBuilder((DocumentBuilderCubit cubit) async {
      await cubit.start();

      await cubit.next();
      final DocumentBuilderReady ready = cubit.state.readyOrNull!;

      expect(ready.currentStep, 0);
      expect(ready.invalidTick, 1);
      expect(ready.document, isNull);
      expect(session.documents, hasLength(seeded));
    });
  });

  test('next refuses an answer that breaks the server pattern', () async {
    await withBuilder((DocumentBuilderCubit cubit) async {
      await cubit.start();
      answerPage(cubit, 0);
      // This question carries `^[0-9]{5}-[0-9]{7}-[0-9]$`.
      cubit.setAnswer('LandlordCnic', '3520112345671');

      await cubit.next();
      final DocumentBuilderReady ready = cubit.state.readyOrNull!;

      expect(ready.currentStep, 0);
      expect(ready.invalidTick, 1);
      expect(ready.document, isNull);
      expect(session.documents, hasLength(seeded));
    });
  });

  test('saveDraft on an untouched form keeps nothing', () async {
    await withBuilder((DocumentBuilderCubit cubit) async {
      await cubit.start();

      await cubit.saveDraft();
      final DocumentBuilderReady ready = cubit.state.readyOrNull!;

      expect(ready.draftTick, 0);
      expect(ready.document, isNull);
      expect(session.documents, hasLength(seeded));
    });
  });

  test('answered next creates the draft, persists it and moves on', () async {
    await withBuilder((DocumentBuilderCubit cubit) async {
      await cubit.start();
      answerPage(cubit, 0);

      await cubit.next();
      final DocumentBuilderReady ready = cubit.state.readyOrNull!;

      expect(ready.currentStep, 1);
      expect(ready.invalidTick, 0);
      expect(ready.saving, isFalse);

      final LegalDocument saved = ready.document!;
      expect(saved.status, DocumentStatus.draft);
      expect(saved.templateId, ready.template.id);
      // No title is sent on create, so the list falls back to the template's.
      expect(saved.title, isEmpty);
      expect(saved.displayName('en'), 'Residential Rent Agreement');

      final Iterable<String> asked = ready.steps.first.map(
        (TemplateField field) => field.fieldKey,
      );
      expect(saved.answers.keys, containsAll(asked));

      // The store holds the same answers, as the JSON string the API keeps.
      final Map<String, dynamic> stored = session.document(saved.id)!;
      expect(stored['status'], 'Draft');
      expect(
        parseAnswers(stored['formAnswersJson'] as String?).keys,
        containsAll(asked),
      );
      expect(session.documents, hasLength(seeded + 1));
    });
  });

  test(
    'a later page updates the same draft instead of making another',
    () async {
      await withBuilder((DocumentBuilderCubit cubit) async {
        await cubit.start();
        answerPage(cubit, 0);
        await cubit.next();
        final int documentId = cubit.state.readyOrNull!.document!.id;

        answerPage(cubit, 1);
        await cubit.saveDraft();
        final DocumentBuilderReady ready = cubit.state.readyOrNull!;

        expect(ready.draftTick, 1);
        expect(ready.document!.id, documentId);
        expect(session.documents, hasLength(seeded + 1));

        // Both pages are on the one row: the seeded rows are untouched because
        // nothing read them yet.
        final Map<String, dynamic> stored = session.document(documentId)!;
        final Map<String, String> answers = parseAnswers(
          stored['formAnswersJson'] as String?,
        );
        expect(answers, hasLength(ready.template.fieldCount));
      });
    },
  );

  test('back steps without losing answers', () async {
    await withBuilder((DocumentBuilderCubit cubit) async {
      await cubit.start();
      answerPage(cubit, 0);
      await cubit.next();

      cubit.back();
      final DocumentBuilderReady ready = cubit.state.readyOrNull!;

      expect(ready.currentStep, 0);
      expect(ready.answers, isNotEmpty);
      expect(ready.hasAnswers, isTrue);
    });
  });

  test(
    'finish jumps to the first incomplete page instead of generating',
    () async {
      await withBuilder((DocumentBuilderCubit cubit) async {
        await cubit.start();
        answerPage(cubit, 0);

        await cubit.finish();
        final DocumentBuilderReady ready = cubit.state.readyOrNull!;

        expect(ready.generation, isNull);
        expect(ready.currentStep, 1);
        expect(ready.invalidTick, 1);
        expect(ready.document, isNull);
      });
    },
  );

  test('finish generates the document and it lands in my documents', () async {
    await withBuilder((DocumentBuilderCubit cubit) async {
      await cubit.start();
      answerEverything(cubit);

      await cubit.finish();
      final DocumentBuilderReady ready = cubit.state.readyOrNull!;

      final DocumentGeneration? generation = ready.generation;
      expect(generation, isNotNull);
      expect(generation!.status, DocumentStatus.completed);
      expect(ready.errorTick, 0);

      final LegalDocument done = ready.document!;
      expect(done.status, DocumentStatus.completed);
      expect(done.answeredCount, ready.template.fieldCount);
      // Demo mode renders no file, so the preview keeps its downloads hidden
      // rather than offering a button that can only fail.
      expect(done.hasDownloads, isFalse);
      expect(generation.hasPdf, isFalse);

      final Map<String, dynamic> stored = session.document(done.id)!;
      expect(stored['status'], 'Completed');
      expect(stored['statusId'], 2);
      expect(stored['completedAt'], isNotNull);
      expect(stored['storagePath'], isNull);

      final Result<List<LegalDocument>> listed = await documents
          .getUserDocuments();
      expect(
        listed.value!.map((LegalDocument document) => document.id),
        contains(done.id),
      );
    });
  });

  test('finishing a second time reuses the draft it already created', () async {
    await withBuilder((DocumentBuilderCubit cubit) async {
      await cubit.start();
      answerEverything(cubit);
      await cubit.finish();
      final int documentId = cubit.state.readyOrNull!.document!.id;

      await cubit.finish();

      expect(cubit.state.readyOrNull!.document!.id, documentId);
      expect(session.documents, hasLength(seeded + 1));
    });
  });
}

/// Answers every question on one page with something that satisfies it.
///
/// Two of the rent agreement's questions are CNIC fields and the server sends a
/// pattern with them, which the builder applies before it will advance — so a
/// generic placeholder string is not an acceptable answer to everything.
void answerPage(DocumentBuilderCubit cubit, int page) {
  final DocumentBuilderReady ready = cubit.state.readyOrNull!;
  for (final TemplateField field in ready.steps[page]) {
    cubit.setAnswer(field.fieldKey, answerFor(field));
  }
}

String answerFor(TemplateField field) => switch (field.fieldType) {
  FieldType.cnic => '35201-1234567-1',
  FieldType.phone => '03001234567',
  FieldType.email => 'landlord@example.com',
  FieldType.date => '2026-09-07',
  FieldType.number || FieldType.currencyPkr => '15000',
  FieldType.dropdown ||
  FieldType.radio ||
  FieldType.checkbox => field.options.isEmpty ? 'Choice' : field.options.first,
  _ => 'Test ${field.fieldKey}',
};

void answerEverything(DocumentBuilderCubit cubit) {
  final DocumentBuilderReady ready = cubit.state.readyOrNull!;
  for (int page = 0; page < ready.steps.length; page++) {
    answerPage(cubit, page);
  }
}
