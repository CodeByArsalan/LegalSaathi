import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/legal_document.dart';
import '../domain/usecases/get_user_documents.dart';
import 'my_documents_state.dart';

/// There is no removal here on purpose: the API exposes no DELETE route for a
/// document, so the list can only grow.
class MyDocumentsCubit extends Cubit<MyDocumentsState> {
  MyDocumentsCubit({required GetUserDocumentsUseCase getDocuments})
    : _getDocuments = getDocuments,
      super(const MyDocumentsState.loading());

  final GetUserDocumentsUseCase _getDocuments;

  Future<void> load() async {
    emit(const MyDocumentsState.loading());
    final result = await _getDocuments();
    if (isClosed) return;

    emit(
      result.fold<MyDocumentsState>(
        onSuccess: (List<LegalDocument> documents) =>
            MyDocumentsState.ready(documents),
        onFailure: (Failure failure) => MyDocumentsState.failure(failure),
      ),
    );
  }

  /// Silent reload for tab re-entry: the shell keeps this view alive, so a
  /// returning user must see freshly built documents without a loading
  /// flash. Failures keep the current list on screen — pull-to-refresh
  /// surfaces them properly.
  Future<void> refresh() async {
    final result = await _getDocuments();
    if (isClosed) return;

    emit(
      result.fold<MyDocumentsState>(
        onSuccess: (List<LegalDocument> documents) =>
            MyDocumentsState.ready(documents),
        onFailure: (Failure failure) => state,
      ),
    );
  }
}
