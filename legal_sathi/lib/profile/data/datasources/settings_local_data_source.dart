import '../../../core/services/prefs_service.dart';
import '../../domain/entities/app_settings.dart';

/// Device-local settings live in shared preferences, not the API.
class SettingsLocalDataSource {
  SettingsLocalDataSource(this._prefs);

  final PrefsService _prefs;

  AppSettings read() => AppSettings(
    localeCode: _prefs.localeCode ?? 'en',
    notificationsEnabled: _prefs.notificationsEnabled,
  );

  Future<void> write(AppSettings settings) async {
    await _prefs.setLocaleCode(settings.localeCode);
    await _prefs.setNotificationsEnabled(settings.notificationsEnabled);
  }
}
