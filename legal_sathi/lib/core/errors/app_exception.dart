/// The only error type data sources throw. Repositories convert it into a
/// [Failure] via `Failure.from`, so Cubits never see raw exceptions.
final class AppException implements Exception {
  const AppException(
    this.message, {
    this.kind = AppExceptionKind.unknown,
    this.statusCode,
    this.code,
    this.fieldErrors = const <String, String>{},
  });

  final String message;
  final AppExceptionKind kind;
  final int? statusCode;

  /// Machine-readable discriminator. The API's failure envelope puts the human
  /// text in `errors[0]` and a code in `message` — `"EmailNotVerified"` is the
  /// one the app branches on — so the two have to travel separately.
  final String? code;

  final Map<String, String> fieldErrors;

  @override
  String toString() =>
      'AppException(${kind.name}, status: $statusCode, code: $code): $message';
}

enum AppExceptionKind {
  network,
  timeout,
  unauthorized,
  invalidCredentials,
  forbidden,
  notFound,
  validation,
  server,
  cache,
  unknown,
}
