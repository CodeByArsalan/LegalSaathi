import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../../../core/widgets/language/language_switcher.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/layout/max_width_body.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../widgets/settings_section.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<SettingsCubit>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final SettingsCubit cubit = context.read<SettingsCubit>();

    return AppScaffold(
      title: tr('profile.settings'),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listenWhen: (SettingsState previous, SettingsState current) =>
            current.failure != null && previous.failure != current.failure,
        listener: (BuildContext context, SettingsState state) {
          final failure = state.failure;
          if (failure != null) AppSnackBar.failure(context, failure);
        },
        builder: (BuildContext context, SettingsState state) {
          return SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: context.gutter),
              children: <Widget>[
                MaxWidthBody(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SettingsSection(
                        title: tr('profile.language'),
                        children: <Widget>[
                          SettingsTile(
                            icon: Icons.translate_rounded,
                            title: tr('profile.language'),
                            subtitle: tr('profile.language_body'),
                            trailing: const SizedBox(
                              width: 132,
                              child: FittedBox(child: LanguageSwitcher()),
                            ),
                          ),
                        ],
                      ),
                      SettingsSection(
                        title: tr('profile.notifications'),
                        children: <Widget>[
                          SettingsTile(
                            icon: Icons.notifications_none_rounded,
                            title: tr('profile.notifications'),
                            subtitle: tr('profile.notifications_body'),
                            trailing: Switch(
                              value: state.settings.notificationsEnabled,
                              onChanged: cubit.setNotificationsEnabled,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Center(
                        child: Text(
                          tr(
                            'profile.version',
                            namedArgs: <String, String>{
                              'number': '1.0.0',
                              'env': AppConfig.env,
                            },
                          ),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
