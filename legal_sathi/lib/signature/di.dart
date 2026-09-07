import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/config/app_config.dart';
import '../../core/mock/mock_session_store.dart';
import 'cubit/signature_cubit.dart';
import 'data/datasources/signature_remote_data_source.dart';
import 'data/datasources/signature_remote_data_source_dio.dart';
import 'data/datasources/signature_remote_data_source_mock.dart';
import 'data/repositories/signature_repository_impl.dart';
import 'domain/repositories/signature_repository.dart';
import 'domain/usecases/get_signatures.dart';
import 'domain/usecases/request_signing_otp.dart';
import 'domain/usecases/sign_document.dart';

void configureSignature(GetIt getIt) {
  getIt
    ..registerLazySingleton<SignatureRemoteDataSource>(
      () => AppConfig.useMockApi
          ? SignatureRemoteDataSourceMock(getIt<MockSessionStore>())
          : SignatureRemoteDataSourceDio(getIt<Dio>()),
    )
    ..registerLazySingleton<SignatureRepository>(
      () => SignatureRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<RequestSigningOtpUseCase>(
      () => RequestSigningOtpUseCase(getIt()),
    )
    ..registerLazySingleton<SignDocumentUseCase>(
      () => SignDocumentUseCase(getIt()),
    )
    ..registerLazySingleton<GetSignaturesUseCase>(
      () => GetSignaturesUseCase(getIt()),
    )
    ..registerFactoryParam<SignatureCubit, int, void>(
      (int documentId, _) => SignatureCubit(
        requestOtp: getIt(),
        signDocument: getIt(),
        documentId: documentId,
      ),
    );
}
