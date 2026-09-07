import '../../../core/errors/result.dart';
import '../entities/legal_document.dart';
import '../repositories/document_repository.dart';

class GetUserDocumentsUseCase {
  const GetUserDocumentsUseCase(this._repository);

  final DocumentRepository _repository;

  Future<Result<List<LegalDocument>>> call() => _repository.getUserDocuments();
}
