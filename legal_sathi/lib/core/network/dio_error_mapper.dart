import 'package:dio/dio.dart';

import '../errors/app_exception.dart';
import 'api_envelope.dart';

/// Turns a [DioException] into an [AppException] that repositories can map to a
/// `Failure`.
///
/// This API reports business failures as **HTTP 400** carrying the
/// `ApiResponse` envelope, and ASP.NET's own model binding answers with
/// `ProblemDetails` instead — [ApiEnvelope] reads both shapes. A 401 arrives
/// with an empty body, so it is classified purely from the status.
abstract final class DioErrorMapper {
  const DioErrorMapper._();

  static AppException from(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const AppException(
        'Request timed out.',
        kind: AppExceptionKind.timeout,
      ),
      DioExceptionType.connectionError => const AppException(
        'No internet connection.',
        kind: AppExceptionKind.network,
      ),
      DioExceptionType.badResponse => _fromResponse(error.response),
      DioExceptionType.cancel => const AppException(
        'Request cancelled.',
        kind: AppExceptionKind.unknown,
      ),
      DioExceptionType.badCertificate => const AppException(
        'Untrusted server certificate.',
        kind: AppExceptionKind.network,
      ),
      _ => AppException(
        error.message ?? 'Unexpected network error.',
        kind: AppExceptionKind.unknown,
      ),
    };
  }

  static AppException _fromResponse(Response<dynamic>? response) {
    final int? status = response?.statusCode;
    final Map<String, dynamic> body = ApiEnvelope.asMap(response?.data);
    final String message =
        ApiEnvelope.messageOf(body) ??
        _problemDetailsMessage(body) ??
        _fallback(status);

    return AppException(
      message,
      kind: _kindOf(status),
      statusCode: status,
      code: ApiEnvelope.codeOf(body),
      fieldErrors: ApiEnvelope.fieldErrorsOf(body),
    );
  }

  static AppExceptionKind _kindOf(int? status) => status == null
      ? AppExceptionKind.network
      : ApiEnvelope.kindForStatus(status);

  /// `ProblemDetails` has no envelope, so fall back to its own `detail`/`title`.
  static String? _problemDetailsMessage(Map<String, dynamic> body) {
    for (final String key in <String>['detail', 'title']) {
      final Object? value = body[key];
      if (value is String && value.trim().isNotEmpty) return value.trim();
    }
    return null;
  }

  static String _fallback(int? status) => switch (status) {
    401 => 'Session expired.',
    null => 'Request failed.',
    _ => 'Server error ($status).',
  };
}
