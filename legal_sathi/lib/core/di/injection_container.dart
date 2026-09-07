import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../ai_assistant/di.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/di.dart';
import '../../documents/di.dart';
import '../../home/di.dart';
import '../../payments/di.dart';
import '../../profile/di.dart';
import '../../signature/di.dart';
import '../../splash/di.dart';
import '../../templates/di.dart';
import '../mock/mock_session_store.dart';
import '../network/dio_client.dart';
import '../router/app_router.dart';
import '../services/prefs_service.dart';
import '../services/secure_storage_service.dart';

/// Composition root. Core services first, then each feature's own `di.dart`,
/// then the router — which needs the session cubit to already exist.
final class InjectionContainer {
  InjectionContainer._();

  static final GetIt sl = GetIt.instance;

  static Future<void> init() async {
    final PrefsService prefs = await PrefsService.create();
    final SecureStorageService secureStorage = SecureStorageService(
      const FlutterSecureStorage(),
    );
    // Warms the in-memory token mirror so interceptors read synchronously.
    await secureStorage.restore();

    sl
      ..registerLazySingleton<MockSessionStore>(MockSessionStore.new)
      ..registerSingleton<PrefsService>(prefs)
      ..registerSingleton<SecureStorageService>(secureStorage)
      ..registerSingleton<Dio>(
        DioClient.create(
          storage: secureStorage,
          onSessionExpired: () => sl<AuthCubit>().expireSession(),
        ),
      );

    configureAuth(sl);
    configureSplash(sl);
    configureTemplates(sl);
    configureDocuments(sl);
    configureHome(sl);
    configureProfile(sl);
    configureAiAssistant(sl);
    configureSignature(sl);
    configurePayments(sl);

    sl.registerSingleton<GoRouter>(AppRouter.create(sl<AuthCubit>()));
  }
}
