import '../../../core/errors/result.dart';
import '../entities/legal_document.dart';
import '../repositories/document_repository.dart';

class SaveAnswersUseCase {
  const SaveAnswersUseCase(this._repository);

  final DocumentRepository _repository;

  Future<Result<LegalDocument>> call({
    required int documentId,
    required Map<String, String> answers,
  }) => _repository.saveAnswers(documentId: documentId, answers: answers);
}
