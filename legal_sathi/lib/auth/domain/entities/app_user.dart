import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// The signed-in account. Shaped by what the API actually returns:
/// `AuthResponse` on login/verification carries everything except
/// `emailVerified` and `createdAt`, which only `GET /Auth/me` supplies — so
/// those arrive later, when the session is reconciled on startup.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required int id,
    required String email,
    required String fullName,
    required String phoneNumber,

    /// Always true for a session that exists: the API refuses to log an
    /// unverified account in. It is kept because `/Auth/me` reports it and the
    /// profile screen shows it.
    required bool emailVerified,
    @Default('EndUser') String role,
    String? cnic,
    DateTime? createdAt,
  }) = _AppUser;
}
