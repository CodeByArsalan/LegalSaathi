import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/buttons/outline_button_widget.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/layout/max_width_body.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../domain/entities/profile_stats.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_section.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProfileCubit>().load();
    });
  }

  Future<void> _confirmSignOut() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(tr('auth.sign_out')),
        content: Text(tr('auth.sign_out_confirm')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(tr('common.cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              tr('auth.sign_out'),
              style: context.textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    await context.read<AuthCubit>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    // Watched, not read: saving an edit replaces the session's copy of the
    // account, and the header below has to show the new name without a restart.
    final AuthCubit auth = context.watch<AuthCubit>();

    return AppScaffold(
      title: tr('profile.title'),
      showBackButton: false,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: context.gutter),
          children: <Widget>[
            MaxWidthBody(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: AppSpacing.md),
                  ProfileHeader(
                    fullName: auth.currentUser?.fullName ?? '',
                    email: auth.currentUser?.email ?? '',
                    memberSince: auth.currentUser?.createdAt,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (BuildContext context, ProfileState state) {
                      final ProfileStats? stats = state.stats;
                      return ProfileStatsRow(
                        documentsCount: stats?.documents ?? 0,
                        signedCount: stats?.signed ?? 0,
                        completedCount: stats?.completed ?? 0,
                      );
                    },
                  ),
                  SettingsSection(
                    title: tr('profile.settings'),
                    children: <Widget>[
                      SettingsTile(
                        icon: Icons.tune_rounded,
                        title: tr('profile.settings'),
                        subtitle: tr('profile.language_body'),
                        onTap: () => context.push(RoutePaths.settings),
                      ),
                      SettingsTile(
                        icon: Icons.person_outline_rounded,
                        title: tr('profile.edit_profile'),
                        subtitle: tr('profile.edit_profile_body'),
                        onTap: () => context.push(RoutePaths.editProfile),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: tr('nav.ai_assistant'),
                    children: <Widget>[
                      SettingsTile(
                        icon: Icons.auto_awesome_rounded,
                        title: tr('ai.title'),
                        subtitle: tr('ai.subtitle'),
                        onTap: () => context.push(RoutePaths.aiAssistant),
                      ),
                      SettingsTile(
                        icon: Icons.help_outline_rounded,
                        title: tr('profile.help_center'),
                        onTap: () =>
                            AppSnackBar.show(context, tr('common.coming_soon')),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: tr('app.name'),
                    children: <Widget>[
                      SettingsTile(
                        icon: Icons.description_outlined,
                        title: tr('profile.terms'),
                        onTap: () =>
                            AppSnackBar.show(context, tr('common.coming_soon')),
                      ),
                      SettingsTile(
                        icon: Icons.privacy_tip_outlined,
                        title: tr('profile.privacy'),
                        onTap: () =>
                            AppSnackBar.show(context, tr('common.coming_soon')),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  OutlineButtonWidget(
                    label: tr('auth.sign_out'),
                    icon: Icons.logout_rounded,
                    onPressed: _confirmSignOut,
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
