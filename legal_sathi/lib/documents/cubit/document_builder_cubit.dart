import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/failure.dart';
import '../../core/errors/result.dart';
import '../../templates/domain/entities/legal_template.dart';
import '../../templates/domain/entities/template_field.dart';
import '../../templates/domain/usecases/get_template_detail.dart';
import '../domain/entities/document_generation.dart';
import '../domain/entities/legal_document.dart';
import '../domain/usecases/create_document.dart';
import '../domain/usecases/generate_document.dart';
import '../domain/usecases/save_answers.dart';
import 'document_builder_state.dart';

/// Drives the guided wizard: reads the template's questions, persists the
/// answers as the user moves through them, and renders the document on [finish].
///
/// The pages come from the server, which groups the questions by `stepNumber`,
/// so nothing here decides how many fields make a page. The draft itself is
/// created on the first save rather than on entry: an empty draft left behind by
/// someone who only looked at the questions would be a row with no name and no
/// answers.
class DocumentBuilderCubit extends Cubit<DocumentBuilderState> {
  DocumentBuilderCubit({
    required GetTemplateDetailUseCase getTemplateDetail,
    required CreateDocumentUseCase createDocument,
    required SaveAnswersUseCase saveAnswers,
    required GenerateDocumentUseCase generateDocument,
    required String slug,
  }) : _getTemplateDetail = getTemplateDetail,
       _createDocument = createDocument,
       _saveAnswers = saveAnswers,
       _generateDocument = generateDocument,
       _slug = slug,
       super(const DocumentBuilderState.loading());

  final GetTemplateDetailUseCase _getTemplateDetail;
  final CreateDocumentUseCase _createDocument;
  final SaveAnswersUseCase _saveAnswers;
  final GenerateDocumentUseCase _generateDocument;
  final String _slug;

  Future<void> start() async {
    emit(const DocumentBuilderState.loading());

    final Result<LegalTemplate> result = await _getTemplateDetail(_slug);
    if (isClosed) return;
    final LegalTemplate? template = result.value;
    if (template == null) {
      emit(DocumentBuilderState.failure(_failureOf(result)));
      return;
    }

    // A template with no questions still gets one page, so the user reaches the
    // generate button instead of facing an empty wizard they cannot leave.
    final List<List<TemplateField>> pages = template.steps;
    emit(
      DocumentBuilderState.ready(
        template: template,
        steps: pages.isEmpty
            ? const <List<TemplateField>>[<TemplateField>[]]
            : pages,
      ),
    );
  }

  void setAnswer(String fieldKey, String value) {
    final DocumentBuilderReady? ready = state.readyOrNull;
    if (ready == null) return;
    emit(
      ready.copyWith(
        answers: <String, String>{...ready.answers, fieldKey: value},
      ),
    );
  }

  /// Validates the current page, persists the answers and advances. A failed
  /// save keeps the user on the page so nothing is lost.
  Future<void> next() async {
    final DocumentBuilderReady? ready = state.readyOrNull;
    if (ready == null || ready.saving || ready.isLastStep) return;

    if (!_pageIsValid(ready, ready.currentStep)) {
      emit(ready.copyWith(invalidTick: ready.invalidTick + 1));
      return;
    }

    final LegalDocument? saved = await _store(ready);
    if (isClosed) return;
    if (saved == null) return;

    emit(
      ready.copyWith(
        document: saved,
        currentStep: ready.currentStep + 1,
        saving: false,
      ),
    );
  }

  void back() {
    final DocumentBuilderReady? ready = state.readyOrNull;
    if (ready == null || ready.saving || ready.currentStep == 0) return;
    emit(ready.copyWith(currentStep: ready.currentStep - 1));
  }

  Future<void> saveDraft() async {
    final DocumentBuilderReady? ready = state.readyOrNull;
    if (ready == null || ready.saving) return;

    // An untouched form is not a draft; storing one would leave a row behind
    // that the user never asked for.
    if (ready.document == null && !ready.hasAnswers) return;

    final LegalDocument? saved = await _store(ready);
    if (isClosed) return;
    if (saved == null) return;

    emit(
      ready.copyWith(
        document: saved,
        saving: false,
        draftTick: ready.draftTick + 1,
      ),
    );
  }

  /// Validates every page, stores the answers and renders the document. The view
  /// reacts to `generation` and navigates to the preview.
  Future<void> finish() async {
    final DocumentBuilderReady? ready = state.readyOrNull;
    if (ready == null || ready.saving) return;

    final int? invalidPage = _firstInvalidPage(ready);
    if (invalidPage != null) {
      emit(
        ready.copyWith(
          currentStep: invalidPage,
          invalidTick: ready.invalidTick + 1,
        ),
      );
      return;
    }

    final LegalDocument? saved = await _store(ready);
    if (isClosed) return;
    if (saved == null) return;

    final Result<DocumentGeneration> generated = await _generateDocument(
      documentId: saved.id,
    );
    if (isClosed) return;
    final DocumentGeneration? generation = generated.value;
    if (generation == null) {
      emit(_withError(ready.copyWith(document: saved), _failureOf(generated)));
      return;
    }

    emit(
      ready.copyWith(
        // The generate call is the only thing that knows the new status; the
        // document in hand is still the pre-render draft.
        document: saved.copyWith(status: generation.status),
        saving: false,
        generation: generation,
      ),
    );
  }

  /// Creates the draft on the first store and updates it afterwards, so both
  /// paths leave the state holding what the server has. A failure is reported
  /// here rather than at each call site.
  Future<LegalDocument?> _store(DocumentBuilderReady ready) async {
    emit(ready.copyWith(saving: true));

    final LegalDocument? existing = ready.document;
    final Result<LegalDocument> result = existing == null
        ? await _createDocument(
            templateId: ready.template.id,
            answers: ready.answers,
          )
        : await _saveAnswers(documentId: existing.id, answers: ready.answers);
    if (isClosed) return null;

    final LegalDocument? stored = result.value;
    if (stored == null) {
      emit(_withError(ready, _failureOf(result)));
      return null;
    }
    return stored;
  }

  bool _pageIsValid(DocumentBuilderReady ready, int pageIndex) {
    return ready.steps[pageIndex].every(
      (TemplateField field) =>
          field.errorKeyFor(ready.answers[field.fieldKey] ?? '') == null,
    );
  }

  int? _firstInvalidPage(DocumentBuilderReady ready) {
    for (int i = 0; i < ready.steps.length; i++) {
      if (!_pageIsValid(ready, i)) return i;
    }
    return null;
  }

  DocumentBuilderReady _withError(DocumentBuilderReady ready, Failure failure) {
    return ready.copyWith(
      saving: false,
      errorTick: ready.errorTick + 1,
      error: failure,
    );
  }

  Failure _failureOf<T>(Result<T> result) =>
      result.failure ?? const UnknownFailure();
}
