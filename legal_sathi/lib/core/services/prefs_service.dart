import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

/// Synchronous reads after one async [create] at bootstrap, so widget build
/// methods never await storage.
final class PrefsService {
  PrefsService(this._prefs);

  final SharedPreferences _prefs;

  static Future<PrefsService> create() async =>
      PrefsService(await SharedPreferences.getInstance());

  String? get localeCode => _prefs.getString(AppConstants.localeCodeKey);

  Future<void> setLocaleCode(String code) =>
      _prefs.setString(AppConstants.localeCodeKey, code);

  bool get notificationsEnabled =>
      _prefs.getBool(AppConstants.notificationsEnabledKey) ?? true;

  Future<void> setNotificationsEnabled(bool enabled) =>
      _prefs.setBool(AppConstants.notificationsEnabledKey, enabled);

  Future<void> clearSettings() => _prefs.clear();
}
