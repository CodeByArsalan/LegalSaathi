import '../../../core/errors/app_exception.dart';
import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/quick_prompt.dart';
import '../../domain/repositories/ai_repository.dart';
import '../datasources/ai_remote_data_source.dart';
import '../models/ai_answer_dto.dart';
import '../models/ai_context_json.dart';
import '../models/quick_prompt_dto.dart';

class AiRepositoryImpl implements AiRepository {
  AiRepositoryImpl(this._remote);

  final AiRemoteDataSource _remote;

  @override
  Future<Result<ChatMessage>> ask({
    required String question,
    required String languageCode,
    required List<ChatMessage> history,
  }) async {
    try {
      final AiAnswerDto answer = await _remote.ask(
        prompt: question,
        languageCode: languageCode,
        contextJson: AiContextJson.pack(history),
      );

      // An empty answer comes back as a success envelope, so it has to be
      // refused here: a blank bubble reads as the app having nothing to say.
      if (answer.answer.trim().isEmpty) {
        throw const AppException(
          'The assistant returned an empty answer.',
          kind: AppExceptionKind.server,
        );
      }

      // The message is minted here rather than parsed: `AiAskResponse` carries
      // the answer text and nothing about the turn it belongs to.
      return Success<ChatMessage>(
        ChatMessage(
          id: 'answer_${DateTime.now().microsecondsSinceEpoch}',
          role: ChatRole.assistant,
          text: answer.answer,
          createdAt: DateTime.now(),
        ),
      );
    } on Object catch (error) {
      return FailureResult<ChatMessage>(Failure.from(error));
    }
  }

  @override
  Future<Result<List<QuickPrompt>>> quickPrompts() async {
    try {
      return Success<List<QuickPrompt>>(
        (await _remote.quickPrompts())
            .map((QuickPromptDto dto) => dto.toEntity())
            .toList(growable: false),
      );
    } on Object catch (error) {
      return FailureResult<List<QuickPrompt>>(Failure.from(error));
    }
  }
}
