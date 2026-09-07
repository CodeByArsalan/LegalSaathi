import 'package:get_it/get_it.dart';

import '../../auth/cubit/auth_cubit.dart';
import '../../core/services/prefs_service.dart';
import 'cubit/edit_profile_cubit.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/settings_cubit.dart';
import 'data/datasources/settings_local_data_source.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'domain/repositories/settings_repository.dart';
import 'domain/usecases/load_settings.dart';
import 'domain/usecases/save_settings.dart';

/// No remote source of its own: the counts come from the documents feature and
/// the identity fields are the auth feature's `PUT /Auth/profile`, so this only
/// wires cubits to what already exists.
void configureProfile(GetIt getIt) {
  getIt
    ..registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSource(getIt<PrefsService>()),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<LoadSettingsUseCase>(
      () => LoadSettingsUseCase(getIt()),
    )
    ..registerLazySingleton<SaveSettingsUseCase>(
      () => SaveSettingsUseCase(getIt()),
    )
    ..registerFactory<ProfileCubit>(() => ProfileCubit(getIt()))
    ..registerFactory<EditProfileCubit>(
      () => EditProfileCubit(updateProfile: getIt(), auth: getIt<AuthCubit>()),
    )
    ..registerFactory<SettingsCubit>(
      () => SettingsCubit(loadSettings: getIt(), saveSettings: getIt()),
    );
}
