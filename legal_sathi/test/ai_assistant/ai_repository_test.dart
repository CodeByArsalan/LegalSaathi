import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/ai_assistant/data/datasources/ai_remote_data_source.dart';
import 'package:legal_sathi/ai_assistant/data/datasources/ai_remote_data_source_mock.dart';
import 'package:legal_sathi/ai_assistant/data/models/ai_answer_dto.dart';
import 'package:legal_sathi/ai_assistant/data/models/quick_prompt_dto.dart';
import 'package:legal_sathi/ai_assistant/data/repositories/ai_repository_impl.dart';
import 'package:legal_sathi/ai_assistant/domain/entities/chat_message.dart';
import 'package:legal_sathi/ai_assistant/domain/entities/quick_prompt.dart';
import 'package:legal_sathi/ai_assistant/domain/repositories/ai_repository.dart';
import 'package:legal_sathi/core/errors/app_exception.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';

/// The repository's two pieces of judgement: it mints the assistant turn from a
/// payload that carries only answer text, and it refuses an answer the server
/// sent back empty.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ChatMessage turn(ChatRole role, String text) => ChatMessage(
    id: '$role-$text',
    role: role,
    text: text,
    createdAt: DateTime.utc(2026, 9, 7),
  );

  group('against the bundled answers', () {
    late AiRepository repository;

    setUp(() => repository = AiRepositoryImpl(AiRemoteDataSourceMock()));

    test('a question comes back as an assistant turn', () async {
      final Result<ChatMessage> result = await repository.ask(
        question: 'What is an affidavit?',
        languageCode: 'en',
        history: const <ChatMessage>[],
      );

      final ChatMessage message = result.value!;
      expect(result.failure, isNull);
      expect(message.role, ChatRole.assistant);
      expect(message.text, contains('Affidavit'));
      // Nothing is stored client-side, so the turn is minted here.
      expect(message.id, startsWith('answer_'));
      expect(message.createdAt, isNotNull);
    });

    test('the answer follows the app language, not the question', () async {
      final Result<ChatMessage> urdu = await repository.ask(
        question: 'What is an affidavit?',
        languageCode: 'ur',
        history: const <ChatMessage>[],
      );

      expect(urdu.value!.text, contains('حلف نامہ'));
    });

    test('starter questions arrive as entities', () async {
      final Result<List<QuickPrompt>> result = await repository.quickPrompts();

      expect(result.failure, isNull);
      expect(result.value, hasLength(5));
      expect(result.value!.first.titleIn('en'), 'Rent Agreement Rights');
    });
  });

  group('against a recording data source', () {
    test('the transcript travels as contextJson', () async {
      final _Recording recording = _Recording(
        answer: const AiAnswerDto(answer: 'Because the law says so.'),
      );

      await AiRepositoryImpl(recording).ask(
        question: 'And the witnesses?',
        languageCode: 'en',
        history: <ChatMessage>[
          turn(ChatRole.user, 'What is an affidavit?'),
          turn(ChatRole.assistant, 'A sworn statement.'),
        ],
      );

      expect(recording.lastPrompt, 'And the witnesses?');
      expect(recording.lastContextJson, contains('What is an affidavit?'));
      expect(recording.lastContextJson, contains('"role":"assistant"'));
    });

    test('an opening question sends no context', () async {
      final _Recording recording = _Recording(
        answer: const AiAnswerDto(answer: 'Ask away.'),
      );

      await AiRepositoryImpl(recording).ask(
        question: 'Hello',
        languageCode: 'en',
        history: const <ChatMessage>[],
      );

      expect(recording.lastContextJson, isNull);
    });

    test('an empty answer is a failure, not a blank bubble', () async {
      final AiRepository repository = AiRepositoryImpl(
        _Recording(answer: const AiAnswerDto(answer: '   ')),
      );

      final Result<ChatMessage> result = await repository.ask(
        question: 'Hello',
        languageCode: 'en',
        history: const <ChatMessage>[],
      );

      expect(result.value, isNull);
      expect(result.failure, isA<ServerFailure>());
    });

    test(
      'a refused question reaches the user as a validation failure',
      () async {
        final AiRepository repository = AiRepositoryImpl(
          _Recording(throwOnAsk: true),
        );

        final Result<ChatMessage> result = await repository.ask(
          question: '   ',
          languageCode: 'en',
          history: const <ChatMessage>[],
        );

        expect(result.failure, isA<ValidationFailure>());
      },
    );
  });
}

/// Answers every question with the same payload and writes down what it was
/// asked, so the context packing can be seen from the repository's side.
final class _Recording implements AiRemoteDataSource {
  _Recording({this.answer = const AiAnswerDto(), this.throwOnAsk = false});

  final AiAnswerDto answer;
  final bool throwOnAsk;

  String? lastPrompt;
  String? lastContextJson;

  @override
  Future<AiAnswerDto> ask({
    required String prompt,
    required String languageCode,
    String? contextJson,
  }) async {
    lastPrompt = prompt;
    lastContextJson = contextJson;
    if (throwOnAsk) {
      // What both the mock and the server raise for a blank prompt.
      throw const AppException(
        'Please enter a legal query or question.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
      );
    }
    return answer;
  }

  @override
  Future<List<QuickPromptDto>> quickPrompts() => throw UnimplementedError();
}
