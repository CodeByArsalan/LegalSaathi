import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/errors/failure.dart';
import '../../core/widgets/state_view.dart';
import '../../signature/domain/entities/document_signature.dart';
import '../domain/entities/document_format.dart';
import '../domain/entities/legal_document.dart';

part 'document_preview_state.freezed.dart';

@freezed
abstract class DocumentPreviewState with _$DocumentPreviewState {
  const factory DocumentPreviewState.loading() = DocumentPreviewLoading;

  /// [busyFormat] is the format being fetched, so only that button spins.
  ///
  /// [signatures] is empty until the document has been rendered: nothing can be
  /// signed before then, so the call that would fetch them is skipped.
  ///
  /// [failure] and [errorTick] describe a download that went wrong, and they sit
  /// alongside the document rather than replacing it: a failed fetch is no reason
  /// to take the page away.
  const factory DocumentPreviewState.ready({
    required LegalDocument document,
    @Default(<DocumentSignature>[]) List<DocumentSignature> signatures,
    DocumentFormat? busyFormat,
    Failure? failure,
    @Default(0) int errorTick,
  }) = DocumentPreviewReady;

  const factory DocumentPreviewState.failure(Failure failure) =
      DocumentPreviewFailure;
}

extension DocumentPreviewStateX on DocumentPreviewState {
  ViewState get viewState => maybeWhen(
    loading: () => ViewState.loading,
    failure: (_) => ViewState.failure,
    orElse: () => ViewState.ready,
  );

  Failure? get failure =>
      maybeWhen(failure: (Failure value) => value, orElse: () => null);

  DocumentPreviewReady? get readyOrNull =>
      this is DocumentPreviewReady ? this as DocumentPreviewReady : null;
}
