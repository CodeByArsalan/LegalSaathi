import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/config/app_config.dart';
import 'cubit/ai_chat_cubit.dart';
import 'data/datasources/ai_remote_data_source.dart';
import 'data/datasources/ai_remote_data_source_dio.dart';
import 'data/datasources/ai_remote_data_source_mock.dart';
import 'data/repositories/ai_repository_impl.dart';
import 'domain/repositories/ai_repository.dart';
import 'domain/usecases/ask_legal_question.dart';
import 'domain/usecases/get_quick_prompts.dart';

void configureAiAssistant(GetIt getIt) {
  getIt
    ..registerLazySingleton<AiRemoteDataSource>(
      () => AppConfig.useMockApi
          ? AiRemoteDataSourceMock()
          : AiRemoteDataSourceDio(getIt<Dio>()),
    )
    ..registerLazySingleton<AiRepository>(() => AiRepositoryImpl(getIt()))
    ..registerLazySingleton<AskLegalQuestionUseCase>(
      () => AskLegalQuestionUseCase(getIt()),
    )
    ..registerLazySingleton<GetQuickPromptsUseCase>(
      () => GetQuickPromptsUseCase(getIt()),
    )
    ..registerFactory<AiChatCubit>(
      () => AiChatCubit(ask: getIt(), quickPrompts: getIt()),
    );
}
