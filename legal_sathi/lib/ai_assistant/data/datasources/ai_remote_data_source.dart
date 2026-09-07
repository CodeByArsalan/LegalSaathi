import '../models/ai_answer_dto.dart';
import '../models/quick_prompt_dto.dart';

/// `POST /Ai/ask` and `GET /Ai/quick-prompts`. Implementations throw
/// `AppException`.
///
/// Both routes are `[AllowAnonymous]` on the server, so the assistant works
/// before sign-in. A bearer token that happens to be attached is not refused —
/// it is what links the stored query to the account.
abstract class AiRemoteDataSource {
  /// Answers [prompt] in [languageCode], which decides the answer's language
  /// independently of the language the question was typed in.
  ///
  /// [contextJson] carries the earlier turns; see `AiContextJson`.
  Future<AiAnswerDto> ask({
    required String prompt,
    required String languageCode,
    String? contextJson,
  });

  Future<List<QuickPromptDto>> quickPrompts();
}
