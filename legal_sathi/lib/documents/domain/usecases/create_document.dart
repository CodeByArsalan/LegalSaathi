import '../../../core/errors/result.dart';
import '../entities/legal_document.dart';
import '../repositories/document_repository.dart';

class CreateDocumentUseCase {
  const CreateDocumentUseCase(this._repository);

  final DocumentRepository _repository;

  Future<Result<LegalDocument>> call({
    required int templateId,
    String? title,
    Map<String, String>? answers,
  }) => _repository.createDocument(
    templateId: templateId,
    title: title,
    answers: answers,
  );
}
