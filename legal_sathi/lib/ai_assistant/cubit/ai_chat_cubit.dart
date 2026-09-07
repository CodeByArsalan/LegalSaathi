import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../domain/entities/chat_message.dart';
import '../domain/entities/quick_prompt.dart';
import '../domain/usecases/ask_legal_question.dart';
import '../domain/usecases/get_quick_prompts.dart';
import 'ai_chat_state.dart';

/// Holds the conversation. The server keeps none — every call is a single
/// prompt — so the transcript lives here and the earlier turns travel back as
/// context with the newest question.
class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit({
    required AskLegalQuestionUseCase ask,
    required GetQuickPromptsUseCase quickPrompts,
  }) : _ask = ask,
       _quickPrompts = quickPrompts,
       super(const AiChatState());

  final AskLegalQuestionUseCase _ask;
  final GetQuickPromptsUseCase _quickPrompts;

  /// Reads the starter questions once. A failure leaves the list empty and the
  /// screen falls back to its own bundled suggestions: prompts are a convenience
  /// and no reason to hold the page back.
  Future<void> loadQuickPrompts() async {
    if (state.quickPrompts.isNotEmpty) return;

    final List<QuickPrompt> prompts =
        (await _quickPrompts()).value ?? const <QuickPrompt>[];
    if (isClosed || prompts.isEmpty) return;

    emit(state.copyWith(quickPrompts: prompts));
  }

  Future<void> send(String question, {required String languageCode}) async {
    final String trimmed = question.trim();
    if (trimmed.isEmpty || state.isWaitingForAnswer) return;

    // Snapshot before the new user turn is appended: the question itself
    // travels separately, and the replayed transcript gives the model its
    // multi-turn context.
    final List<ChatMessage> history = List<ChatMessage>.of(state.messages);

    emit(
      state.copyWith(
        isWaitingForAnswer: true,
        failure: null,
        messages: <ChatMessage>[
          ...state.messages,
          ChatMessage(
            id: 'msg_${DateTime.now().microsecondsSinceEpoch}',
            role: ChatRole.user,
            text: trimmed,
            createdAt: DateTime.now(),
          ),
        ],
      ),
    );

    final Result<ChatMessage> result = await _ask(
      question: trimmed,
      languageCode: languageCode,
      history: history,
    );
    if (isClosed) return;

    emit(
      result.fold<AiChatState>(
        onSuccess: (ChatMessage answer) => state.copyWith(
          isWaitingForAnswer: false,
          messages: <ChatMessage>[...state.messages, answer],
        ),
        onFailure: (Failure failure) =>
            state.copyWith(isWaitingForAnswer: false, failure: failure),
      ),
    );
  }

  /// Nothing is persisted, so clearing is a plain state reset. The starter
  /// prompts survive it: they describe the assistant, not the conversation.
  void clear() => emit(AiChatState(quickPrompts: state.quickPrompts));
}
