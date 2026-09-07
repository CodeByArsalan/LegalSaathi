import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/chat_message.dart';
import '../domain/entities/quick_prompt.dart';

part 'ai_chat_state.freezed.dart';

@freezed
abstract class AiChatState with _$AiChatState {
  /// [quickPrompts] are the server's starter questions, offered while the
  /// transcript is empty. They stay put when the conversation is cleared.
  const factory AiChatState({
    @Default(<ChatMessage>[]) List<ChatMessage> messages,
    @Default(<QuickPrompt>[]) List<QuickPrompt> quickPrompts,
    @Default(false) bool isWaitingForAnswer,
    Failure? failure,
  }) = _AiChatState;
}
