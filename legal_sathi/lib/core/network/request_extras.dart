/// Keys that data sources put into `RequestOptions.extra` to steer the
/// interceptors registered in [DioClient].
abstract final class RequestExtras {
  /// Set on auth endpoints (login, refresh) that must not carry a bearer token
  /// and must not trigger the refresh flow.
  static const String skipAuth = 'skip_auth';

  /// Guards against a retried request re-entering the refresh flow.
  static const String retried = 'retried';
}
