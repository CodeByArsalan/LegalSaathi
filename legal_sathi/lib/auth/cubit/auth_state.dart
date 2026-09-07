import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/app_user.dart';

part 'auth_state.freezed.dart';

/// App-wide session state. The router redirects from this, so it must have an
/// explicit "still reading storage" member.
@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.unknown() = AuthUnknown;

  const factory AuthState.authenticated(AppUser user) = AuthAuthenticated;

  const factory AuthState.unauthenticated() = AuthUnauthenticated;
}

extension AuthStateX on AuthState {
  AppUser? get user =>
      maybeWhen(authenticated: (AppUser value) => value, orElse: () => null);

  bool get isAuthenticated => user != null;
}
