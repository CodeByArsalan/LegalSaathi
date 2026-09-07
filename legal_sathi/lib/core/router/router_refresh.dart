import 'dart:async';

import 'package:flutter/foundation.dart';

/// Bridges a Cubit stream to a [Listenable] so GoRouter re-runs its redirect
/// whenever the session changes.
final class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
