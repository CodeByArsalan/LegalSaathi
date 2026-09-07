import 'dart:typed_data';

import '../../../core/errors/result.dart';
import '../entities/document_format.dart';
import '../repositories/document_repository.dart';

class DownloadDocumentUseCase {
  const DownloadDocumentUseCase(this._repository);

  final DocumentRepository _repository;

  Future<Result<Uint8List>> call({
    required int documentId,
    required DocumentFormat format,
  }) => _repository.download(documentId: documentId, format: format);
}
