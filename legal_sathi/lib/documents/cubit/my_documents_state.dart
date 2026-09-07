import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../../../core/widgets/state_view.dart';
import '../domain/entities/legal_document.dart';

part 'my_documents_state.freezed.dart';

@freezed
abstract class MyDocumentsState with _$MyDocumentsState {
  const factory MyDocumentsState.loading() = MyDocumentsLoading;

  const factory MyDocumentsState.ready(List<LegalDocument> documents) =
      MyDocumentsReady;

  const factory MyDocumentsState.failure(Failure failure) = MyDocumentsFailure;
}

extension MyDocumentsStateX on MyDocumentsState {
  List<LegalDocument> get documents => maybeWhen(
    ready: (List<LegalDocument> value) => value,
    orElse: () => const <LegalDocument>[],
  );

  Failure? get failure =>
      maybeWhen(failure: (Failure value) => value, orElse: () => null);

  ViewState get viewState => when(
    loading: () => ViewState.loading,
    ready: (List<LegalDocument> docs) =>
        docs.isEmpty ? ViewState.empty : ViewState.ready,
    failure: (Failure failure) => ViewState.failure,
  );
}
