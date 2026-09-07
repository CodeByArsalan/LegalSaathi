import 'dart:async';

import 'package:dio/dio.dart';

import '../../constants/api_endpoints.dart';
import '../../services/secure_storage_service.dart';
import '../api_envelope.dart';
import '../request_extras.dart';

/// Refreshes an expired access token once per request and replays the original
/// call. Concurrent 401s share a single refresh through [_inFlight]; if the
/// refresh itself fails the session is cleared and [onSessionExpired] tells
/// `AuthCubit` to drop to the logged-out state.
final class TokenRefreshInterceptor extends Interceptor {
  TokenRefreshInterceptor({
    required Dio dio,
    required SecureStorageService storage,
    required Future<void> Function() onSessionExpired,
  }) : _dio = dio,
       _storage = storage,
       _onSessionExpired = onSessionExpired;

  final Dio _dio;
  final SecureStorageService _storage;
  final Future<void> Function() _onSessionExpired;

  Completer<String?>? _inFlight;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final bool refreshable =
        err.response?.statusCode == 401 &&
        requestOptions.extra[RequestExtras.skipAuth] != true &&
        requestOptions.extra[RequestExtras.retried] != true;

    if (!refreshable) {
      handler.next(err);
      return;
    }

    final token = await _singleFlightRefresh();
    if (token == null) {
      await _onSessionExpired();
      handler.next(err);
      return;
    }

    requestOptions.headers['Authorization'] = 'Bearer $token';
    requestOptions.extra[RequestExtras.retried] = true;

    try {
      handler.resolve(await _dio.fetch<dynamic>(requestOptions));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<String?> _singleFlightRefresh() {
    final pending = _inFlight;
    if (pending != null) return pending.future;

    final completer = Completer<String?>();
    _inFlight = completer;
    unawaited(
      _performRefresh()
          .then(completer.complete)
          .catchError((Object _) => completer.complete(null))
          .whenComplete(() => _inFlight = null),
    );
    return completer.future;
  }

  Future<String?> _performRefresh() async {
    final String? currentRefreshToken = _storage.refreshToken;
    if (currentRefreshToken == null || currentRefreshToken.isEmpty) return null;

    // Deliberately sends *only* the refresh token. Supplying the access token
    // too makes the server resolve the user by id without hydrating its stored
    // refresh token, and it then rejects the exchange as invalid.
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.refreshToken,
      data: <String, String>{'refreshToken': currentRefreshToken},
      options: Options(extra: <String, Object>{RequestExtras.skipAuth: true}),
    );

    final Map<String, dynamic> data =
        ApiEnvelope.unwrapObject<Map<String, dynamic>>(
          response,
          (Map<String, dynamic> json) => json,
        );

    final String? accessToken = data['accessToken'] as String?;
    final String? refreshToken = data['refreshToken'] as String?;
    if (accessToken == null ||
        accessToken.isEmpty ||
        refreshToken == null ||
        refreshToken.isEmpty) {
      return null;
    }

    await _storage.saveTokenPair(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    return accessToken;
  }
}
