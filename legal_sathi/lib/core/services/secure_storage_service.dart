import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';
import '../utils/logger.dart';

/// Holds the JWT pair and cached user. Values are mirrored in memory during
/// [restore] because Dio's `onRequest` cannot await a platform read.
final class SecureStorageService {
  SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  String? _accessToken;
  String? _refreshToken;
  String? _userJson;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get userJson => _userJson;
  bool get hasSession => _accessToken != null && _accessToken!.isNotEmpty;

  Future<void> restore() async {
    try {
      _accessToken = await _read(AppConstants.accessTokenKey);
      _refreshToken = await _read(AppConstants.refreshTokenKey);
      _userJson = await _read(AppConstants.userJsonKey);
    } on Object catch (error) {
      // An unreadable cache means "not signed in on this device" — it must
      // never cost the user the whole app.
      AppLog.warn('Secure storage unavailable, starting signed out: $error');
    }
  }

  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userJson,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _userJson = userJson;
    await Future.wait(<Future<void>>[
      _storage.write(key: AppConstants.accessTokenKey, value: accessToken),
      _storage.write(key: AppConstants.refreshTokenKey, value: refreshToken),
      _storage.write(key: AppConstants.userJsonKey, value: userJson),
    ]);
  }

  /// Persists a rotated JWT pair. The server invalidates the refresh token it
  /// just replaced, so storing only the access token would sign the user out on
  /// their very next request. The cached user is left as-is.
  Future<void> saveTokenPair({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    await Future.wait(<Future<void>>[
      _storage.write(key: AppConstants.accessTokenKey, value: accessToken),
      _storage.write(key: AppConstants.refreshTokenKey, value: refreshToken),
    ]);
  }

  Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;
    _userJson = null;
    await _storage.deleteAll();
  }

  Future<String?> _read(String key) => _storage.read(key: key);
}
