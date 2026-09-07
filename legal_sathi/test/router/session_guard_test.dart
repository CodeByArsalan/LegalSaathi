import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/auth/cubit/auth_state.dart';
import 'package:legal_sathi/auth/domain/entities/app_user.dart';
import 'package:legal_sathi/core/router/app_router.dart';
import 'package:legal_sathi/core/router/route_paths.dart';

/// The session guard is the only place navigation decisions live, and `/splash`
/// being a resting destination is what parked a signed-out cold start on the
/// brand screen forever. Pure function, so no widget tree or plugins needed.
void main() {
  final AppUser user = AppUser(
    id: 1001,
    email: 'demo@legalsathi.pk',
    fullName: 'Ayesha Khan',
    phoneNumber: '03001234567',
    // No unverified variant to build: the API issues tokens only to a verified
    // account, so every authenticated state is verified by construction.
    emailVerified: true,
    createdAt: DateTime(2026, 1, 12),
  );

  String? go(AuthState session, String location) =>
      AppRouter.sessionRedirect(session, location);

  group('while the session is unknown', () {
    const unknown = AuthState.unknown();

    test('the splash holds and nothing else is reachable', () {
      expect(go(unknown, RoutePaths.splash), isNull);
      expect(go(unknown, RoutePaths.home), RoutePaths.splash);
      expect(go(unknown, RoutePaths.payment), RoutePaths.splash);
    });
  });

  group('signed out', () {
    const signedOut = AuthState.unauthenticated();

    test('the splash is left for login, not parked on', () {
      expect(go(signedOut, RoutePaths.splash), RoutePaths.login);
    });

    test('login, register and verification stay put', () {
      expect(go(signedOut, RoutePaths.login), isNull);
      expect(go(signedOut, RoutePaths.register), isNull);
      // Verification is what creates the session, so it must be reachable
      // without one — both after registering and from a refused login.
      expect(go(signedOut, RoutePaths.verifyEmail), isNull);
    });

    test('everything else funnels to login', () {
      expect(go(signedOut, RoutePaths.home), RoutePaths.login);
      expect(go(signedOut, RoutePaths.documents), RoutePaths.login);
    });
  });

  group('signed in', () {
    final signedIn = AuthState.authenticated(user);

    test('the splash resolves to home', () {
      expect(go(signedIn, RoutePaths.splash), RoutePaths.home);
    });

    test('session-free screens resolve to home', () {
      expect(go(signedIn, RoutePaths.login), RoutePaths.home);
      expect(go(signedIn, RoutePaths.register), RoutePaths.home);
      expect(go(signedIn, RoutePaths.verifyEmail), RoutePaths.home);
    });

    test('app screens stay put', () {
      expect(go(signedIn, RoutePaths.home), isNull);
      expect(go(signedIn, RoutePaths.documents), isNull);
      expect(go(signedIn, RoutePaths.settings), isNull);
    });
  });
}
