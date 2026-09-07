import '../../../core/errors/result.dart';
import '../entities/quick_prompt.dart';
import '../repositories/ai_repository.dart';

class GetQuickPromptsUseCase {
  const GetQuickPromptsUseCase(this._repository);

  final AiRepository _repository;

  Future<Result<List<QuickPrompt>>> call() => _repository.quickPrompts();
}
