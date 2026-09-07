import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/ai_assistant/cubit/ai_chat_cubit.dart';
import 'package:legal_sathi/ai_assistant/domain/entities/chat_message.dart';
import 'package:legal_sathi/ai_assistant/domain/entities/quick_prompt.dart';
import 'package:legal_sathi/ai_assistant/domain/repositories/ai_repository.dart';
import 'package:legal_sathi/ai_assistant/domain/usecases/ask_legal_question.dart';
import 'package:legal_sathi/ai_assistant/domain/usecases/get_quick_prompts.dart';
import 'package:legal_sathi/core/errors/app_exception.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';

class _FakeAiRepository implements AiRepository {
  _FakeAiRepository(this._next);

  Result<ChatMessage> _next;
  int askCalls = 0;
  int quickPromptCalls = 0;
  String? lastQuestion;
  String? lastLanguageCode;
  List<ChatMessage>? lastHistory;

  /// Empty by default, so a test that does not care about the starter questions
  /// still sees the cubit's fallback path.
  Result<List<QuickPrompt>> promptsResult = Success<List<QuickPrompt>>(
    const <QuickPrompt>[],
  );

  void answerWith(Result<ChatMessage> result) => _next = result;

  @override
  Future<Result<ChatMessage>> ask({
    required String question,
    required String languageCode,
    required List<ChatMessage> history,
  }) async {
    askCalls++;
    lastQuestion = question;
    lastLanguageCode = languageCode;
    lastHistory = history;
    return _next;
  }

  @override
  Future<Result<List<QuickPrompt>>> quickPrompts() async {
    quickPromptCalls++;
    return promptsResult;
  }
}

QuickPrompt prompt(String id) => QuickPrompt(
  id: id,
  titleEn: 'Title $id',
  titleUr: 'عنوان $id',
  promptEn: 'Ask $id',
  promptUr: 'پوچھیں $id',
  category: 'tenancy',
  icon: 'Home',
);

Result<ChatMessage> success(String text) => Success<ChatMessage>(
  ChatMessage(
    id: 'answer_$text',
    role: ChatRole.assistant,
    text: text,
    createdAt: DateTime(2026, 1, 1),
  ),
);

/// The chat cubit against a fake repository: transcript growth, the history
/// replay that replaced the server-side conversation, the starter questions,
/// and the failure/clear paths.
void main() {
  late _FakeAiRepository repository;
  late AiChatCubit cubit;

  setUp(() {
    repository = _FakeAiRepository(success('answer'));
    cubit = AiChatCubit(
      ask: AskLegalQuestionUseCase(repository),
      quickPrompts: GetQuickPromptsUseCase(repository),
    );
  });

  test('send appends the user turn and the assistant answer', () async {
    await cubit.send('What is a rent agreement?', languageCode: 'en');

    expect(repository.lastQuestion, 'What is a rent agreement?');
    expect(repository.lastLanguageCode, 'en');
    expect(cubit.state.messages, hasLength(2));
    expect(cubit.state.messages.first.role, ChatRole.user);
    expect(cubit.state.messages.last.text, 'answer');
    expect(cubit.state.isWaitingForAnswer, isFalse);
    expect(cubit.state.failure, isNull);
  });

  test(
    'send replays the earlier transcript, excluding the new question',
    () async {
      await cubit.send('first', languageCode: 'en');
      repository.answerWith(success('second answer'));
      await cubit.send('second', languageCode: 'ur');

      final List<ChatMessage> history = repository.lastHistory!;
      expect(history.map((ChatMessage m) => m.text), <String>[
        'first',
        'answer',
      ]);
      expect(history.first.role, ChatRole.user);
      expect(history.last.role, ChatRole.assistant);
      expect(repository.lastLanguageCode, 'ur');
    },
  );

  test('first question goes out with empty history', () async {
    await cubit.send('hello', languageCode: 'en');
    expect(repository.lastHistory, isEmpty);
  });

  test('failure sets the failure and stops waiting', () async {
    repository.answerWith(
      FailureResult<ChatMessage>(
        Failure.from(const AppException('boom', kind: AppExceptionKind.server)),
      ),
    );

    await cubit.send('hello', languageCode: 'en');

    expect(cubit.state.isWaitingForAnswer, isFalse);
    expect(cubit.state.failure, isNotNull);
    // The user turn stays visible even though the answer failed.
    expect(cubit.state.messages, hasLength(1));
  });

  test('blank questions never reach the repository', () async {
    await cubit.send('   ', languageCode: 'en');
    expect(repository.askCalls, isZero);
    expect(cubit.state.messages, isEmpty);
  });

  test('clear resets the transcript but keeps the starter prompts', () async {
    repository.promptsResult = Success<List<QuickPrompt>>(<QuickPrompt>[
      prompt('a'),
    ]);
    await cubit.loadQuickPrompts();
    await cubit.send('hello', languageCode: 'en');
    expect(cubit.state.messages, hasLength(2));

    cubit.clear();

    expect(cubit.state.messages, isEmpty);
    expect(cubit.state.isWaitingForAnswer, isFalse);
    expect(cubit.state.quickPrompts, hasLength(1));
  });

  test('loadQuickPrompts fills the state from the API', () async {
    repository.promptsResult = Success<List<QuickPrompt>>(<QuickPrompt>[
      prompt('rent-rights'),
      prompt('nda-clauses'),
    ]);

    await cubit.loadQuickPrompts();

    expect(cubit.state.quickPrompts.map((QuickPrompt p) => p.id), <String>[
      'rent-rights',
      'nda-clauses',
    ]);
  });

  test('loadQuickPrompts reads once, however often it is called', () async {
    repository.promptsResult = Success<List<QuickPrompt>>(<QuickPrompt>[
      prompt('a'),
    ]);

    await cubit.loadQuickPrompts();
    await cubit.loadQuickPrompts();

    expect(repository.quickPromptCalls, 1);
  });

  test(
    'a failed prompt read leaves the list empty rather than failing',
    () async {
      repository.promptsResult = FailureResult<List<QuickPrompt>>(
        Failure.from(const AppException('boom', kind: AppExceptionKind.server)),
      );

      await cubit.loadQuickPrompts();

      expect(cubit.state.quickPrompts, isEmpty);
      expect(cubit.state.failure, isNull);
    },
  );
}
