import '../../../core/errors/result.dart';
import '../entities/chat_message.dart';
import '../repositories/ai_repository.dart';

class AskLegalQuestionUseCase {
  const AskLegalQuestionUseCase(this._repository);

  final AiRepository _repository;

  Future<Result<ChatMessage>> call({
    required String question,
    required String languageCode,
    required List<ChatMessage> history,
  }) => _repository.ask(
    question: question,
    languageCode: languageCode,
    history: history,
  );
}
