import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/layout/app_card.dart';

/// One labelled group of rows — "Settings", "Support", "Legal".
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.xl,
            bottom: AppSpacing.sm,
          ),
          child: Text(
            title,
            style: context.textTheme.labelMedium?.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(children: children),
        ),
      ],
    );
  }
}

/// Standard row inside a [SettingsSection]: icon, title, optional subtitle and
/// a trailing widget or chevron.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.danger = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final Color color = danger ? AppColors.error : AppColors.text;

    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 22,
        color: danger ? AppColors.error : AppColors.primary,
      ),
      title: Text(
        title,
        style: context.textTheme.titleSmall?.copyWith(color: color),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textLight,
              ),
            ),
      trailing:
          trailing ??
          (onTap == null
              ? const SizedBox.shrink()
              : const Icon(Icons.chevron_right_rounded)),
      dense: true,
      minLeadingWidth: 0,
    );
  }
}
