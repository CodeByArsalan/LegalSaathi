import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_user.dart';

part 'auth_session.freezed.dart';

/// A successful login/register result: the JWT pair plus the account it
/// belongs to. Persisted through `SecureStorageService`.
@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required AppUser user,
    required String accessToken,
    required String refreshToken,
  }) = _AuthSession;
}
