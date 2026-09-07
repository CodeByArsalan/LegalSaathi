import '../../../core/constants/asset_paths.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/mock/mock_data_source.dart';
import '../models/ai_answer_dto.dart';
import '../models/quick_prompt_dto.dart';
import 'ai_remote_data_source.dart';

/// Keyword-matched guidance from `assets/mock/ai_answers.json`, standing in for
/// `POST /Ai/ask`. Answers follow the app language rather than the language the
/// question was typed in, which is what the server does too.
class AiRemoteDataSourceMock extends MockDataSource
    implements AiRemoteDataSource {
  /// Named so a demo answer reports a model the way a live one does, without
  /// claiming to be one of the real ones.
  static const String _model = 'LegalSaathi-Mock';

  @override
  Future<AiAnswerDto> ask({
    required String prompt,
    required String languageCode,
    String? contextJson,
  }) async {
    final String question = prompt.trim();
    if (question.isEmpty) {
      throw const AppException(
        'Please enter a legal query or question.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
      );
    }

    final List<Map<String, dynamic>> rows = await loadRows(
      AssetPaths.mockAiAnswers,
    );
    final String needle = question.toLowerCase();

    Map<String, dynamic>? match;
    for (final Map<String, dynamic> row in rows) {
      if (row['id'] == 'fallback') continue;
      final List<dynamic> keywords = row['keywords'] as List<dynamic>? ?? [];
      final bool hit = keywords.any(
        (dynamic keyword) =>
            needle.contains('$keyword'.toLowerCase()) ||
            '$keyword'.toLowerCase().contains(needle),
      );
      if (hit) {
        match = row;
        break;
      }
    }

    final Map<String, dynamic> answer =
        match ??
        rows.firstWhere(
          (Map<String, dynamic> row) => row['id'] == 'fallback',
          orElse: () => throw const AppException(
            'No assistant answers seeded.',
            kind: AppExceptionKind.server,
          ),
        );

    final String text = languageCode.startsWith('ur')
        ? '${answer['answerUr']}'
        : '${answer['answerEn']}';

    return withLatency(
      AiAnswerDto(
        answer: text,
        // The server reports the same 1 token ≈ 4 characters estimate; nothing
        // renders it, but a demo answer that claims zero tokens reads as broken.
        totalTokens: (question.length + text.length) ~/ 4,
        model: _model,
        // Nothing was stored, so there is no query to point at.
        queryId: null,
      ),
    );
  }

  @override
  Future<List<QuickPromptDto>> quickPrompts() async {
    final List<QuickPromptDto> prompts = (await loadRows(
      AssetPaths.mockAiQuickPrompts,
    )).map(QuickPromptDto.fromJson).toList(growable: false);
    return withLatency(prompts);
  }
}
