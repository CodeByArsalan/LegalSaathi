import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/app_settings.dart';
import '../domain/usecases/load_settings.dart';
import '../domain/usecases/save_settings.dart';
import 'settings_state.dart';

/// Device preferences. The locale itself is switched by easy_localization in
/// `LanguageSwitcher`; this cubit re-reads what was persisted so the screen
/// always reflects storage.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required LoadSettingsUseCase loadSettings,
    required SaveSettingsUseCase saveSettings,
  }) : _loadSettings = loadSettings,
       _saveSettings = saveSettings,
       super(const SettingsState(isLoading: true));

  final LoadSettingsUseCase _loadSettings;
  final SaveSettingsUseCase _saveSettings;

  void load() {
    final result = _loadSettings();
    if (isClosed) return;

    emit(
      result.fold<SettingsState>(
        onSuccess: (AppSettings settings) => SettingsState(settings: settings),
        onFailure: (Failure failure) =>
            SettingsState(isLoading: false, failure: failure),
      ),
    );
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final AppSettings next = state.settings.copyWith(
      notificationsEnabled: enabled,
    );
    emit(state.copyWith(settings: next));

    final result = await _saveSettings(next);
    if (isClosed) return;

    result.fold<void>(
      onSuccess: (_) => emit(state.copyWith(failure: null)),
      onFailure: (Failure failure) => emit(state.copyWith(failure: failure)),
    );
  }

  /// Called after the language switcher persisted a new locale code.
  void localeChanged(String code) =>
      emit(state.copyWith(settings: state.settings.copyWith(localeCode: code)));
}
