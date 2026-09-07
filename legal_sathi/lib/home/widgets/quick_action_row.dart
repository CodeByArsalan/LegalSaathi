import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';

/// Two shortcuts that cover most first visits: ask the assistant, or start
/// from a template.
class QuickActionRow extends StatelessWidget {
  const QuickActionRow({
    required this.onAskAssistant,
    required this.onStartDocument,
    super.key,
  });

  final VoidCallback onAskAssistant;
  final VoidCallback onStartDocument;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _Action(
                icon: Icons.auto_awesome_rounded,
                label: tr('home.ask_ai'),
                color: AppColors.secondary,
                background: AppColors.successSoft,
                onTap: onAskAssistant,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _Action(
                icon: Icons.add_circle_outline_rounded,
                label: tr('home.start_new'),
                color: AppColors.primary,
                background: AppColors.primarySoft,
                onTap: onStartDocument,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: <Widget>[
            const Icon(
              Icons.verified_user_outlined,
              size: 15,
              color: AppColors.secondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                tr('home.trust_note'),
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.card,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: background,
                borderRadius: AppRadius.field,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
