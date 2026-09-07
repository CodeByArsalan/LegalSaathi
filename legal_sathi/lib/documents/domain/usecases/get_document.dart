import '../../../core/errors/result.dart';
import '../entities/legal_document.dart';
import '../repositories/document_repository.dart';

class GetDocumentUseCase {
  const GetDocumentUseCase(this._repository);

  final DocumentRepository _repository;

  Future<Result<LegalDocument>> call(int documentId) =>
      _repository.getDocument(documentId);
}
