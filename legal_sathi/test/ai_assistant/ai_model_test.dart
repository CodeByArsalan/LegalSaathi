import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/ai_assistant/data/models/ai_answer_dto.dart';
import 'package:legal_sathi/ai_assistant/data/models/ai_context_json.dart';
import 'package:legal_sathi/ai_assistant/data/models/quick_prompt_dto.dart';
import 'package:legal_sathi/ai_assistant/domain/entities/chat_message.dart';
import 'package:legal_sathi/ai_assistant/domain/entities/quick_prompt.dart';
import 'package:legal_sathi/ai_assistant/widgets/markdown_text.dart';
import 'package:legal_sathi/core/network/api_envelope.dart';
import 'package:legal_sathi/core/utils/app_icons.dart';

import '../support/fixtures.dart';

/// What the assistant's two endpoints actually send, and the two translations
/// that stand between it and the screen: the transcript packed into
/// `contextJson`, and the markdown answer broken into spans.
void main() {
  group('POST /Ai/ask payload', () {
    test('carries the answer and the call it came from', () {
      final AiAnswerDto dto = ApiEnvelope.unwrapObject<AiAnswerDto>(
        fixtureResponse('ai_ask', statusCode: 200),
        AiAnswerDto.fromJson,
      );

      expect(dto.answer, contains('Qanun'));
      expect(dto.totalTokens, 111);
      expect(dto.model, 'openai/gpt-oss-120b');
      expect(dto.queryId, 5);
    });

    test('an answer the server could not store has no query id', () {
      final AiAnswerDto dto = AiAnswerDto.fromJson(<String, dynamic>{
        'answer': 'Some answer.',
        'totalTokens': 40,
        'model': 'groq/compound',
        'queryId': null,
      });

      expect(dto.queryId, isNull);
    });

    test('a payload with nothing in it parses rather than throwing', () {
      final AiAnswerDto dto = AiAnswerDto.fromJson(const <String, dynamic>{});

      // The repository refuses an answer this empty, so the shape has to survive
      // long enough to be refused.
      expect(dto.answer, isEmpty);
      expect(dto.totalTokens, isZero);
      expect(dto.model, isEmpty);
      expect(dto.queryId, isNull);
    });
  });

  group('GET /Ai/quick-prompts payload', () {
    List<QuickPrompt> prompts() => ApiEnvelope.unwrapList<QuickPromptDto>(
      fixtureResponse('ai_quick_prompts', statusCode: 200),
      QuickPromptDto.fromJson,
    ).map((QuickPromptDto dto) => dto.toEntity()).toList(growable: false);

    test('is the five starter questions the server hard-codes', () {
      expect(prompts().map((QuickPrompt p) => p.id), <String>[
        'rent-rights',
        'affidavit-validity',
        'digital-signatures',
        'nda-clauses',
        'witness-rules',
      ]);
    });

    test('the server spells the languages out, and both are kept', () {
      final QuickPrompt first = prompts().first;

      expect(first.titleIn('en'), 'Rent Agreement Rights');
      expect(first.titleIn('ur'), 'کرایہ داری کے حقوق اور قوانین');
      expect(first.promptIn('en'), contains('tenant and landlord rights'));
      expect(first.promptIn('ur'), contains('کرایہ دار'));
    });

    test('ur-PK reads the Urdu strings, as the server would', () {
      final QuickPrompt first = prompts().first;

      expect(first.titleIn('ur-PK'), first.titleUr);
      expect(first.titleIn('en-US'), first.titleEn);
    });

    test('every icon name the server sends resolves', () {
      // A name that fell through would render the generic document icon on all
      // five chips, which is the sort of mistake only a fixture catches.
      for (final QuickPrompt prompt in prompts()) {
        expect(
          AppIcons.byName(prompt.icon),
          isNot(Icons.description_outlined),
          reason: prompt.icon,
        );
      }
    });
  });

  group('AiContextJson', () {
    ChatMessage turn(ChatRole role, String text) => ChatMessage(
      id: '$role-$text',
      role: role,
      text: text,
      createdAt: DateTime.utc(2026, 9, 7),
    );

    test('an opening question sends no context at all', () {
      expect(AiContextJson.pack(const <ChatMessage>[]), isNull);
    });

    test(
      'the transcript is labelled, because the server calls it a document',
      () {
        final String packed = AiContextJson.pack(<ChatMessage>[
          turn(ChatRole.user, 'What is an affidavit?'),
          turn(ChatRole.assistant, 'A sworn statement.'),
        ])!;

        final Map<String, dynamic> decoded =
            jsonDecode(packed) as Map<String, dynamic>;
        expect(decoded.keys, <String>['conversation']);

        final List<dynamic> rows = decoded['conversation'] as List<dynamic>;
        expect(rows, <Map<String, String>>[
          <String, String>{'role': 'user', 'text': 'What is an affidavit?'},
          <String, String>{'role': 'assistant', 'text': 'A sworn statement.'},
        ]);
      },
    );

    test('a long transcript keeps only the newest turns', () {
      final List<ChatMessage> history = <ChatMessage>[
        for (int index = 0; index < 10; index++)
          turn(
            index.isEven ? ChatRole.user : ChatRole.assistant,
            'turn $index',
          ),
      ];

      final List<dynamic> rows =
          (jsonDecode(AiContextJson.pack(history)!)
                  as Map<String, dynamic>)['conversation']
              as List<dynamic>;

      expect(rows, hasLength(AiContextJson.maxMessages));
      // The tail is what a follow-up refers back to; the opening is not.
      expect((rows.last as Map<String, dynamic>)['text'], 'turn 9');
      expect((rows.first as Map<String, dynamic>)['text'], 'turn 4');
    });
  });

  group('markdownSpans', () {
    List<TextSpan> spans(String text) =>
        markdownSpans(text).cast<TextSpan>().toList(growable: false);

    test('plain text is one span', () {
      final List<TextSpan> result = spans('No markup here.');

      expect(result, hasLength(1));
      expect(result.single.text, 'No markup here.');
    });

    test('**bold** becomes a heavier span and loses its markers', () {
      final List<TextSpan> result = spans('**Key point:** read it twice.');

      expect(result.map((TextSpan s) => s.text), <String>[
        'Key point:',
        ' read it twice.',
      ]);
      expect(result.first.style?.fontWeight, FontWeight.w700);
      expect(result.last.style?.fontWeight, isNull);
    });

    test('*italic* is told apart from bold', () {
      final List<TextSpan> result = spans('an *aside* only');

      expect(result.map((TextSpan s) => s.text), <String>[
        'an ',
        'aside',
        ' only',
      ]);
      expect(result[1].style?.fontStyle, FontStyle.italic);
      expect(result[1].style?.fontWeight, isNull);
    });

    test('a heading is bold once its # markers are gone', () {
      final List<TextSpan> result = spans('## Your rights');

      expect(result.single.text, 'Your rights');
      expect(result.single.style?.fontWeight, FontWeight.w700);
    });

    test('lines survive as separate spans', () {
      final List<TextSpan> result = spans('**One**\ntwo');

      expect(result.map((TextSpan s) => s.text), <String>['One', '\n', 'two']);
    });

    test('underscores are left alone, so identifiers survive', () {
      // The server's answers quote field names from the templates it fills in.
      expect(
        spans('the DeponentName_value field').single.text,
        'the DeponentName_value field',
      );
    });
  });
}
