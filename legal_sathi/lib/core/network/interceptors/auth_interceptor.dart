import 'package:dio/dio.dart';

import '../../services/secure_storage_service.dart';
import '../request_extras.dart';

/// Attaches the bearer token to every call except the auth endpoints that
/// opt out through [RequestExtras.skipAuth].
final class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);

  final SecureStorageService _storage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storage.accessToken;
    final bool skip = options.extra[RequestExtras.skipAuth] == true;
    if (!skip && token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
