import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/constants/asset_paths.dart';
import 'core/di/injection_container.dart';
import 'core/services/prefs_service.dart';
import 'core/utils/logger.dart';

const List<Locale> _supportedLocales = <Locale>[
  Locale('en', 'US'),
  Locale('ur', 'PK'),
];

/// Starts the app: localization + date symbols, dependency graph, then run.
/// Storage and preferences are resolved before the first frame so widget build
/// methods never await.
Future<void> bootstrap() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    AppLog.error(
      'Uncaught Flutter error',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  try {
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
    await InjectionContainer.init();
  } on Object catch (error, stackTrace) {
    // Before runApp there is no widget tree to report to, so a thrown error
    // would leave the native launch screen frozen on screen. Render instead.
    AppLog.error('Startup failed', error: error, stackTrace: stackTrace);
    runApp(_StartupFailure(error: error, stackTrace: stackTrace));
    return;
  }

  runApp(
    EasyLocalization(
      supportedLocales: _supportedLocales,
      path: AssetPaths.translationsDir,
      fallbackLocale: const Locale('en', 'US'),
      startLocale: _startLocale(),
      child: const LegalSathiApp(),
    ),
  );
}

/// The persisted choice wins over the device locale, so a user who switched to
/// Urdu keeps Urdu on the next launch.
Locale _startLocale() {
  final String? code = InjectionContainer.sl<PrefsService>().localeCode;
  return _supportedLocales.firstWhere(
    (Locale locale) => locale.languageCode == code,
    orElse: () => _supportedLocales.first,
  );
}

/// Last-resort screen for a failed bootstrap. Deliberately depends on nothing
/// that could itself have failed: no localization, theme or service locator.
class _StartupFailure extends StatelessWidget {
  const _StartupFailure({required this.error, required this.stackTrace});

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Legal Sathi failed to start',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 14),
                Text('$error'),
                const SizedBox(height: 14),
                Text(
                  '$stackTrace',
                  style: const TextStyle(fontSize: 11, height: 1.35),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
