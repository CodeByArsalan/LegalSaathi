import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/result.dart';
import '../domain/entities/app_user.dart';
import '../domain/entities/auth_session.dart';
import '../domain/usecases/get_current_user.dart';
import '../domain/usecases/logout.dart';
import '../domain/usecases/restore_session.dart';
import 'auth_state.dart';

/// Single source of truth for "who is signed in". Registered as a singleton so
/// the router, every other Cubit and the interceptors share one session.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required RestoreSessionUseCase restoreSession,
    required GetCurrentUserUseCase getCurrentUser,
    required LogoutUseCase logout,
  }) : _restoreSession = restoreSession,
       _getCurrentUser = getCurrentUser,
       _logout = logout,
       super(const AuthState.unknown());

  final RestoreSessionUseCase _restoreSession;
  final GetCurrentUserUseCase _getCurrentUser;
  final LogoutUseCase _logout;

  AppUser? get currentUser => state.user;

  /// Called by the splash screen: show the cached session immediately so the
  /// shell is not held behind a round trip, then reconcile it with
  /// `GET /Auth/me`, which is the only source of `emailVerified` and `createdAt`
  /// and the only way to learn the account was deactivated server-side.
  Future<void> start() async {
    final AuthSession? cached = (await _restoreSession()).value;
    if (isClosed) return;

    if (cached == null) {
      emit(const AuthState.unauthenticated());
      return;
    }
    emit(AuthState.authenticated(cached.user));

    final Result<AppUser> fresh = await _getCurrentUser();
    if (isClosed || !fresh.isSuccess) return;

    // A failed reconcile is deliberately not a sign-out. Dead tokens are the
    // refresh interceptor's job — it clears storage and the router drops to
    // /login on its own — while an offline start must keep the cached session.
    emit(AuthState.authenticated(fresh.value!));
  }

  void signIn(AuthSession session) {
    if (isClosed) return;
    emit(AuthState.authenticated(session.user));
  }

  /// Replaces the signed-in account's identity after a profile edit. The session
  /// itself is untouched: `PUT /Auth/profile` reissues no tokens.
  void applyUser(AppUser user) {
    if (isClosed) return;
    emit(AuthState.authenticated(user));
  }

  Future<void> signOut() async {
    await _logout();
    if (isClosed) return;
    emit(const AuthState.unauthenticated());
  }

  /// Used by the token refresh interceptor when the refresh token is dead.
  Future<void> expireSession() => signOut();
}
