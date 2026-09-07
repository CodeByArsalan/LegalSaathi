import 'package:dio/dio.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_envelope.dart';
import '../models/ai_answer_dto.dart';
import '../models/quick_prompt_dto.dart';
import 'ai_remote_data_source.dart';

final class AiRemoteDataSourceDio implements AiRemoteDataSource {
  AiRemoteDataSourceDio(this._dio);

  final Dio _dio;

  /// One call gets a longer leash than the shared client's 30 seconds: the
  /// server relays the question to an external model and walks four of them
  /// before falling back to its own answers, so a slow answer is a normal one.
  static final Options _patient = Options(
    receiveTimeout: const Duration(seconds: 90),
  );

  @override
  Future<AiAnswerDto> ask({
    required String prompt,
    required String languageCode,
    String? contextJson,
  }) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.aiAsk,
      data: <String, Object>{
        'prompt': prompt,
        'languageCode': languageCode,
        'contextJson': ?contextJson,
      },
      options: _patient,
    );
    return ApiEnvelope.unwrapObject<AiAnswerDto>(
      response,
      AiAnswerDto.fromJson,
    );
  }

  @override
  Future<List<QuickPromptDto>> quickPrompts() async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      ApiEndpoints.aiQuickPrompts,
    );
    return ApiEnvelope.unwrapList<QuickPromptDto>(
      response,
      QuickPromptDto.fromJson,
    );
  }
}
