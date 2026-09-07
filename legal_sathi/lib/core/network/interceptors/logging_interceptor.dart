import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../utils/logger.dart';

/// Pretty request/response logging in debug builds; release builds keep a
/// one-line error trace so failures remain diagnosable without payload dumps.
final class AppLoggingInterceptor extends Interceptor {
  AppLoggingInterceptor()
    : _debugLogger = PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 110,
      );

  final PrettyDioLogger _debugLogger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      _debugLogger.onRequest(options, handler);
      return;
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // A binary download has no body worth printing: the logger would render
    // every byte of the PDF as a decimal list.
    if (kDebugMode &&
        response.requestOptions.responseType != ResponseType.bytes) {
      _debugLogger.onResponse(response, handler);
      return;
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      _debugLogger.onError(err, handler);
      return;
    }
    AppLog.error(
      '${err.requestOptions.method} ${err.requestOptions.path} failed: ${err.message}',
      error: err,
      tag: 'API',
    );
    handler.next(err);
  }
}
