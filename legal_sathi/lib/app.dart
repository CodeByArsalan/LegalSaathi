import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'auth/cubit/auth_cubit.dart';
import 'core/config/app_config.dart';
import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';

/// Root widget: owns the theme, the locale and the session provider that every
/// screen — and the router guard — reads from.
class LegalSathiApp extends StatelessWidget {
  const LegalSathiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: InjectionContainer.sl<AuthCubit>(),
      child: MaterialApp.router(
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(isUrdu: context.locale.languageCode == 'ur'),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: InjectionContainer.sl<GoRouter>(),
      ),
    );
  }
}
