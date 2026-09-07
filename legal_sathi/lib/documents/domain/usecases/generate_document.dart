import '../../../core/errors/result.dart';
import '../entities/document_generation.dart';
import '../entities/document_language.dart';
import '../repositories/document_repository.dart';

class GenerateDocumentUseCase {
  const GenerateDocumentUseCase(this._repository);

  final DocumentRepository _repository;

  Future<Result<DocumentGeneration>> call({
    required int documentId,
    DocumentLanguage language = DocumentLanguage.bilingual,
  }) =>
      _repository.generateDocument(documentId: documentId, language: language);
}
