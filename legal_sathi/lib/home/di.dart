import 'package:get_it/get_it.dart';

import '../../documents/domain/repositories/document_repository.dart';
import '../../templates/domain/repositories/template_repository.dart';
import 'cubit/home_cubit.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/get_home_feed.dart';

void configureHome(GetIt getIt) {
  getIt
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        templates: getIt<TemplateRepository>(),
        documents: getIt<DocumentRepository>(),
      ),
    )
    ..registerLazySingleton<GetHomeFeedUseCase>(
      () => GetHomeFeedUseCase(getIt()),
    )
    ..registerFactory<HomeCubit>(() => HomeCubit(getIt()));
}
