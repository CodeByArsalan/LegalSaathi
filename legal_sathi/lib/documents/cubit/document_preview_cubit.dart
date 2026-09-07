import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/failure.dart';
import '../../core/errors/result.dart';
import '../../signature/domain/entities/document_signature.dart';
import '../../signature/domain/usecases/get_signatures.dart';
import '../data/sharing/document_sharer.dart';
import '../domain/entities/document_format.dart';
import '../domain/entities/legal_document.dart';
import '../domain/usecases/download_document.dart';
import '../domain/usecases/get_document.dart';
import 'document_preview_state.dart';

/// Loads one document and fetches its rendered files on demand.
///
/// Nothing is downloaded until the user asks: a PDF and a DOCX are tens of
/// kilobytes each, and the page is useful without them.
class DocumentPreviewCubit extends Cubit<DocumentPreviewState> {
  DocumentPreviewCubit({
    required GetDocumentUseCase getDocument,
    required DownloadDocumentUseCase downloadDocument,
    required GetSignaturesUseCase getSignatures,
    required DocumentSharer sharer,
    required int documentId,
  }) : _getDocument = getDocument,
       _downloadDocument = downloadDocument,
       _getSignatures = getSignatures,
       _sharer = sharer,
       _documentId = documentId,
       super(const DocumentPreviewState.loading());

  final GetDocumentUseCase _getDocument;
  final DownloadDocumentUseCase _downloadDocument;
  final GetSignaturesUseCase _getSignatures;
  final DocumentSharer _sharer;
  final int _documentId;

  Future<void> load() async {
    emit(const DocumentPreviewState.loading());
    final Result<LegalDocument> result = await _getDocument(_documentId);
    if (isClosed) return;

    final LegalDocument? document = result.value;
    if (document == null) {
      emit(DocumentPreviewState.failure(_failureOf(result)));
      return;
    }

    // Signatures can only exist once the document has been rendered, so a draft
    // skips the call. A failure here leaves the list empty rather than taking the
    // page away: the document itself loaded, and it is the thing worth reading.
    final List<DocumentSignature> signatures = document.status.isGenerated
        ? (await _getSignatures(_documentId)).value ??
              const <DocumentSignature>[]
        : const <DocumentSignature>[];
    if (isClosed) return;

    emit(
      DocumentPreviewState.ready(document: document, signatures: signatures),
    );
  }

  /// Fetches one rendered format and hands it to the platform, which is where the
  /// user picks saving it, printing it or opening it in a reader.
  Future<void> share(DocumentFormat format) async {
    final DocumentPreviewReady? ready = state.readyOrNull;
    if (ready == null || ready.busyFormat != null) return;

    emit(ready.copyWith(busyFormat: format));
    final Result<Uint8List> result = await _downloadDocument(
      documentId: _documentId,
      format: format,
    );
    if (isClosed) return;

    final Uint8List? bytes = result.value;
    if (bytes == null) {
      emit(_withFailure(ready, _failureOf(result)));
      return;
    }

    try {
      await _sharer.share(
        bytes,
        fileName: ready.document.fileNameFor(format),
        mimeType: format.mimeType,
      );
    } on Object catch (error) {
      if (isClosed) return;
      emit(_withFailure(ready, Failure.from(error)));
      return;
    }

    if (isClosed) return;
    emit(
      DocumentPreviewState.ready(
        document: ready.document,
        signatures: ready.signatures,
      ),
    );
  }

  /// Rebuilt rather than copied: `copyWith` cannot put a nullable field back to
  /// null, and clearing [DocumentPreviewReady.busyFormat] is the whole point — so
  /// everything else has to be passed again.
  DocumentPreviewState _withFailure(
    DocumentPreviewReady ready,
    Failure failure,
  ) => DocumentPreviewState.ready(
    document: ready.document,
    signatures: ready.signatures,
    failure: failure,
    errorTick: ready.errorTick + 1,
  );

  Failure _failureOf<T>(Result<T> result) =>
      result.failure ?? const UnknownFailure();
}
