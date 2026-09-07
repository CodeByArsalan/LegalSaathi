import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../services/secure_storage_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/token_refresh_interceptor.dart';

/// The single Dio instance every remote data source shares, carrying auth,
/// token-refresh and logging interceptors. Mock data sources bypass it.
abstract final class DioClient {
  static Dio create({
    required SecureStorageService storage,
    required Future<void> Function() onSessionExpired,
  }) {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        responseType: ResponseType.json,
        headers: const <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll(<Interceptor>[
      AuthInterceptor(storage),
      TokenRefreshInterceptor(
        dio: dio,
        storage: storage,
        onSessionExpired: onSessionExpired,
      ),
      AppLoggingInterceptor(),
    ]);

    return dio;
  }
}
