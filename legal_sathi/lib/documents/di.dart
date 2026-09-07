import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/config/app_config.dart';
import 'cubit/document_builder_cubit.dart';
import 'cubit/document_preview_cubit.dart';
import 'cubit/my_documents_cubit.dart';
import 'data/datasources/document_remote_data_source.dart';
import 'data/datasources/document_remote_data_source_dio.dart';
import 'data/datasources/document_remote_data_source_mock.dart';
import 'data/repositories/document_repository_impl.dart';
import 'data/sharing/document_sharer.dart';
import 'data/sharing/document_sharer_share_plus.dart';
import 'domain/repositories/document_repository.dart';
import 'domain/usecases/create_document.dart';
import 'domain/usecases/download_document.dart';
import 'domain/usecases/generate_document.dart';
import 'domain/usecases/get_document.dart';
import 'domain/usecases/get_user_documents.dart';
import 'domain/usecases/save_answers.dart';

void configureDocuments(GetIt getIt) {
  // MockSessionStore is a core singleton: documents, signature and payments
  // all write created rows into the same run-scoped store.
  getIt
    ..registerLazySingleton<DocumentRemoteDataSource>(
      () => AppConfig.useMockApi
          ? DocumentRemoteDataSourceMock(getIt())
          : DocumentRemoteDataSourceDio(getIt<Dio>()),
    )
    ..registerLazySingleton<DocumentSharer>(SharePlusDocumentSharer.new)
    ..registerLazySingleton<DocumentRepository>(
      () => DocumentRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<GetUserDocumentsUseCase>(
      () => GetUserDocumentsUseCase(getIt()),
    )
    ..registerLazySingleton<GetDocumentUseCase>(
      () => GetDocumentUseCase(getIt()),
    )
    ..registerLazySingleton<CreateDocumentUseCase>(
      () => CreateDocumentUseCase(getIt()),
    )
    ..registerLazySingleton<SaveAnswersUseCase>(
      () => SaveAnswersUseCase(getIt()),
    )
    ..registerLazySingleton<GenerateDocumentUseCase>(
      () => GenerateDocumentUseCase(getIt()),
    )
    ..registerLazySingleton<DownloadDocumentUseCase>(
      () => DownloadDocumentUseCase(getIt()),
    )
    // The builder is keyed by slug, the preview by the numeric document id.
    ..registerFactoryParam<DocumentBuilderCubit, String, void>(
      (String slug, _) => DocumentBuilderCubit(
        getTemplateDetail: getIt(),
        createDocument: getIt(),
        saveAnswers: getIt(),
        generateDocument: getIt(),
        slug: slug,
      ),
    )
    ..registerFactoryParam<DocumentPreviewCubit, int, void>(
      (int documentId, _) => DocumentPreviewCubit(
        getDocument: getIt(),
        downloadDocument: getIt(),
        getSignatures: getIt(),
        sharer: getIt(),
        documentId: documentId,
      ),
    )
    ..registerFactory<MyDocumentsCubit>(
      () => MyDocumentsCubit(getDocuments: getIt()),
    );
}
