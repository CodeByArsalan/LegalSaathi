import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/config/app_config.dart';
import '../../core/services/secure_storage_service.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/login_cubit.dart';
import 'cubit/register_cubit.dart';
import 'cubit/verify_email_cubit.dart';
import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/datasources/auth_remote_data_source_dio.dart';
import 'data/datasources/auth_remote_data_source_mock.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/get_current_user.dart';
import 'domain/usecases/login.dart';
import 'domain/usecases/logout.dart';
import 'domain/usecases/register.dart';
import 'domain/usecases/resend_verification_code.dart';
import 'domain/usecases/restore_session.dart';
import 'domain/usecases/update_profile.dart';
import 'domain/usecases/verify_email.dart';

/// Session cubit is a singleton: the router and every other Cubit must observe
/// the same instance.
void configureAuth(GetIt getIt) {
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AppConfig.useMockApi
          ? AuthRemoteDataSourceMock()
          : AuthRemoteDataSourceDio(getIt<Dio>()),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(getIt<SecureStorageService>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remote: getIt(), local: getIt()),
    )
    ..registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()))
    ..registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(getIt()))
    ..registerLazySingleton<VerifyEmailUseCase>(
      () => VerifyEmailUseCase(getIt()),
    )
    ..registerLazySingleton<ResendVerificationCodeUseCase>(
      () => ResendVerificationCodeUseCase(getIt()),
    )
    ..registerLazySingleton<RestoreSessionUseCase>(
      () => RestoreSessionUseCase(getIt()),
    )
    ..registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(getIt()),
    )
    ..registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(getIt()))
    ..registerSingleton<AuthCubit>(
      AuthCubit(
        restoreSession: getIt(),
        getCurrentUser: getIt(),
        logout: getIt(),
      ),
    )
    ..registerFactory<LoginCubit>(
      () => LoginCubit(login: getIt(), auth: getIt<AuthCubit>()),
    )
    // No AuthCubit here: registering signs nobody in, so the cubit has no
    // session to hand over and the view navigates to verification instead.
    ..registerFactory<RegisterCubit>(() => RegisterCubit(register: getIt()))
    ..registerFactoryParam<VerifyEmailCubit, String, void>(
      (String email, _) => VerifyEmailCubit(
        email: email,
        verifyEmail: getIt(),
        resendCode: getIt(),
        auth: getIt<AuthCubit>(),
      ),
    );
}
