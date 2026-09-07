import 'package:dio/dio.dart';

import '../errors/app_exception.dart';

/// Every JSON endpoint wraps its payload in the API's `ApiResponse<T>`:
/// `{success, statusCode, message, data, errors[], timestamp}`.
///
/// Two quirks have to be handled to read it correctly:
///
/// * On failure `message` is usually the generic `"Operation failed."` and the
///   text worth showing lives in `errors`. But `message` doubles as a machine
///   code for some failures (`"EmailNotVerified"`), so a non-generic `message`
///   is carried separately as [AppException.code] while `errors` becomes the
///   displayed message.
/// * On success `data` may legitimately be `null` — refreshing with no active
///   session returns `success: true, data: null` — which is a server-shaped
///   answer, not a parse crash, so it maps to [AppExceptionKind.server].
///
/// Most business failures arrive as HTTP 400 and are therefore handled by
/// `DioErrorMapper` before this runs; this covers the 2xx path and the rare
/// 200-that-is-actually-a-failure.
abstract final class ApiEnvelope {
  const ApiEnvelope._();

  /// The filler the server sends when it has nothing better to say. Never show
  /// it to a person.
  static const String genericMessage = 'Operation failed.';

  static T unwrapObject<T>(
    Response<dynamic> response,
    T Function(Map<String, dynamic> data) parse,
  ) {
    final Object? data = _dataOrThrow(response);
    if (data is! Map) {
      throw _unexpectedShape(data);
    }
    return parse(Map<String, dynamic>.from(data));
  }

  static List<T> unwrapList<T>(
    Response<dynamic> response,
    T Function(Map<String, dynamic> item) parse,
  ) {
    final Object? data = _dataOrThrow(response);
    if (data is! List) {
      throw _unexpectedShape(data);
    }
    return data
        .whereType<Map<dynamic, dynamic>>()
        .map(
          (Map<dynamic, dynamic> item) =>
              parse(Map<String, dynamic>.from(item)),
        )
        .toList(growable: false);
  }

  static Map<String, dynamic> asMap(Object? data) =>
      data is Map ? Map<String, dynamic>.from(data) : const <String, dynamic>{};

  /// The human-readable text of a failure envelope, or `null` when the body is
  /// not a recognisable envelope at all.
  static String? messageOf(Map<String, dynamic> body) {
    final List<String> errors = errorsOf(body);
    if (errors.isNotEmpty) return errors.join('; ');

    final Object? message = body['message'];
    if (message is String &&
        message.trim().isNotEmpty &&
        message.trim() != genericMessage) {
      return message.trim();
    }
    return null;
  }

  /// `message` when the server used it as a discriminator rather than as filler.
  static String? codeOf(Map<String, dynamic> body) {
    if (body['success'] != false) return null;
    final Object? message = body['message'];
    if (message is! String) return null;
    final String trimmed = message.trim();
    if (trimmed.isEmpty || trimmed == genericMessage) return null;
    return trimmed;
  }

  /// Failure text, tolerating both the envelope's `errors: string[]` and the
  /// `ProblemDetails` shape ASP.NET emits for model-binding failures, where
  /// `errors` is a `{field: [messages]}` map.
  static List<String> errorsOf(Map<String, dynamic> body) {
    return switch (body['errors']) {
      final List<dynamic> list =>
        list
            .map((Object? error) => error?.toString() ?? '')
            .where((String error) => error.trim().isNotEmpty)
            .toList(growable: false),
      final Map<dynamic, dynamic> map =>
        map.entries
            .map(
              (MapEntry<dynamic, dynamic> entry) => switch (entry.value) {
                final List<dynamic> values => values.join(', '),
                final Object? value => value?.toString() ?? '',
              },
            )
            .where((String error) => error.trim().isNotEmpty)
            .toList(growable: false),
      _ => const <String>[],
    };
  }

  /// `{field: message}` for inline form errors, empty when the body carries
  /// none. Only `ProblemDetails` provides field names; the envelope's flat
  /// `errors` array does not.
  static Map<String, String> fieldErrorsOf(Map<String, dynamic> body) {
    final Object? errors = body['errors'];
    if (errors is! Map) return const <String, String>{};
    return errors.map(
      (dynamic key, dynamic value) => MapEntry<String, String>(
        key.toString(),
        value is List ? value.join(', ') : value.toString(),
      ),
    );
  }

  /// Asserts the envelope reports success, ignoring `data`. Needed for the
  /// endpoints the API answers with its non-generic envelope (`revoke-token`,
  /// `resend-verification`), which carry no payload at all.
  static void ensureSuccess(Response<dynamic> response) {
    final Map<String, dynamic> body = asMap(response.data);
    if (body['success'] == false) {
      throw AppException(
        messageOf(body) ?? 'Request failed.',
        kind: kindForStatus(response.statusCode),
        statusCode: response.statusCode,
        code: codeOf(body),
        fieldErrors: fieldErrorsOf(body),
      );
    }
  }

  static Object? _dataOrThrow(Response<dynamic> response) {
    ensureSuccess(response);

    final Object? data = asMap(response.data)['data'];
    if (data == null) {
      throw AppException(
        'The server returned no data.',
        kind: AppExceptionKind.server,
        statusCode: response.statusCode,
      );
    }
    return data;
  }

  static AppException _unexpectedShape(Object? data) => AppException(
    'Unexpected response shape (${data.runtimeType}).',
    kind: AppExceptionKind.server,
  );

  /// Maps an HTTP status onto the failure kind both the envelope and
  /// `DioErrorMapper` classify by. `null` means the response carried no status.
  static AppExceptionKind kindForStatus(int? status) => switch (status) {
    null => AppExceptionKind.unknown,
    400 || 422 => AppExceptionKind.validation,
    401 => AppExceptionKind.unauthorized,
    403 => AppExceptionKind.forbidden,
    404 => AppExceptionKind.notFound,
    >= 500 => AppExceptionKind.server,
    _ => AppExceptionKind.unknown,
  };
}
