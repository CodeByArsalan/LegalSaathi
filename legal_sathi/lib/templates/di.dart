import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/config/app_config.dart';
import 'cubit/template_detail_cubit.dart';
import 'cubit/template_list_cubit.dart';
import 'data/datasources/template_remote_data_source.dart';
import 'data/datasources/template_remote_data_source_dio.dart';
import 'data/datasources/template_remote_data_source_mock.dart';
import 'data/repositories/template_repository_impl.dart';
import 'domain/repositories/template_repository.dart';
import 'domain/usecases/get_template_categories.dart';
import 'domain/usecases/get_template_detail.dart';
import 'domain/usecases/get_templates.dart';

void configureTemplates(GetIt getIt) {
  getIt
    ..registerLazySingleton<TemplateRemoteDataSource>(
      () => AppConfig.useMockApi
          ? TemplateRemoteDataSourceMock()
          : TemplateRemoteDataSourceDio(getIt<Dio>()),
    )
    ..registerLazySingleton<TemplateRepository>(
      () => TemplateRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<GetTemplatesUseCase>(
      () => GetTemplatesUseCase(getIt()),
    )
    ..registerLazySingleton<GetTemplateCategoriesUseCase>(
      () => GetTemplateCategoriesUseCase(getIt()),
    )
    ..registerLazySingleton<GetTemplateDetailUseCase>(
      () => GetTemplateDetailUseCase(getIt()),
    )
    ..registerFactory<TemplateListCubit>(
      () => TemplateListCubit(getTemplates: getIt(), getCategories: getIt()),
    )
    ..registerFactory<TemplateDetailCubit>(() => TemplateDetailCubit(getIt()));
}
