import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/errors/failure.dart';
import '../../core/widgets/state_view.dart';
import '../../templates/domain/entities/legal_template.dart';
import '../../templates/domain/entities/template_field.dart';
import '../domain/entities/document_generation.dart';
import '../domain/entities/legal_document.dart';

part 'document_builder_state.freezed.dart';

/// Wizard state. The transient signals (`invalidTick`, `draftTick`,
/// `errorTick`) are monotonic counters so a `BlocListener` can fire exactly
/// once per event via a simple `!=` comparison.
@freezed
abstract class DocumentBuilderState with _$DocumentBuilderState {
  const factory DocumentBuilderState.loading() = DocumentBuilderLoading;

  /// [steps] is the server's own paging: each inner list is one wizard page,
  /// already ordered the way the questions should be asked.
  ///
  /// [document] stays null until the first save, because the draft is created
  /// with its answers attached — reading a template's questions and leaving
  /// again should store nothing. [generation] is set once the document has been
  /// rendered, which is what the view navigates away on.
  const factory DocumentBuilderState.ready({
    required LegalTemplate template,
    required List<List<TemplateField>> steps,
    LegalDocument? document,
    DocumentGeneration? generation,
    @Default(0) int currentStep,
    @Default(<String, String>{}) Map<String, String> answers,
    @Default(false) bool saving,
    @Default(0) int invalidTick,
    @Default(0) int draftTick,
    @Default(0) int errorTick,
    Failure? error,
  }) = DocumentBuilderReady;

  const factory DocumentBuilderState.failure(Failure failure) =
      DocumentBuilderFailure;
}

extension DocumentBuilderStateX on DocumentBuilderState {
  ViewState get viewState => maybeWhen(
    loading: () => ViewState.loading,
    failure: (_) => ViewState.failure,
    orElse: () => ViewState.ready,
  );

  Failure? get failure =>
      maybeWhen(failure: (Failure value) => value, orElse: () => null);

  DocumentBuilderReady? get readyOrNull =>
      this is DocumentBuilderReady ? this as DocumentBuilderReady : null;
}

extension DocumentBuilderReadyX on DocumentBuilderReady {
  /// The questions on the page the user is looking at.
  List<TemplateField> get step => steps[currentStep];

  bool get isLastStep => currentStep == steps.length - 1;

  int get totalSteps => steps.length;

  /// Whether anything has been answered, which decides if there is a draft worth
  /// storing yet.
  bool get hasAnswers =>
      answers.values.any((String value) => value.trim().isNotEmpty);
}
