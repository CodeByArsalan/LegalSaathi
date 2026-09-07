import '../../../core/errors/result.dart';
import '../entities/chat_message.dart';
import '../entities/quick_prompt.dart';

abstract class AiRepository {
  /// [languageCode] decides which language the assistant answers in, so a user
  /// browsing in Urdu gets Urdu guidance for an English question.
  ///
  /// [history] is the transcript so far, excluding [question]. The server keeps
  /// no conversation, so it travels as context on every call; see
  /// `AiContextJson`.
  Future<Result<ChatMessage>> ask({
    required String question,
    required String languageCode,
    required List<ChatMessage> history,
  });

  /// Starter questions for an empty conversation, in both languages.
  Future<Result<List<QuickPrompt>>> quickPrompts();
}
