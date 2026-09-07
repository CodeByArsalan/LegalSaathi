import 'dart:convert';

import '../../../core/services/secure_storage_service.dart';
import '../../../core/utils/logger.dart';
import '../../domain/entities/auth_session.dart';
import '../models/user_dto.dart';

/// Cached token pair + user, readable offline for session restore.
class AuthLocalDataSource {
  AuthLocalDataSource(this._storage);

  final SecureStorageService _storage;

  Future<void> cacheSession(AuthSession session) => _storage.saveSession(
    accessToken: session.accessToken,
    refreshToken: session.refreshToken,
    userJson: jsonEncode(UserDtoMapper.fromEntity(session.user).toJson()),
  );

  /// `null` when there is no session — including when the cached one cannot be
  /// read. A payload this build no longer understands (one an older build wrote,
  /// say) must sign the user out rather than trap them behind a splash screen,
  /// so the cache is dropped and startup continues.
  Future<AuthSession?> readSession() async {
    if (!_storage.hasSession) return null;

    final String? rawUser = _storage.userJson;
    final String? accessToken = _storage.accessToken;
    if (rawUser == null || accessToken == null) return null;

    try {
      final UserDto user = UserDto.fromJson(
        jsonDecode(rawUser) as Map<String, dynamic>,
      );
      return AuthSession(
        user: user.toEntity(),
        accessToken: accessToken,
        refreshToken: _storage.refreshToken ?? '',
      );
    } on Object catch (error) {
      AppLog.warn('Discarding an unreadable cached session: $error');
      await clear();
      return null;
    }
  }

  Future<void> clear() => _storage.clear();
}
