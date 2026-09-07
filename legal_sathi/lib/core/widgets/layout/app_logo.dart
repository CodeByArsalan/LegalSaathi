import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../utils/extensions/context_x.dart';

/// App wordmark: scales badge plus the bilingual name. Used by splash, auth
/// and the profile header.
class AppLogo extends StatelessWidget {
  const AppLogo({this.compact = false, this.showTagline = true, super.key});

  final bool compact;
  final bool showTagline;

  @override
  Widget build(BuildContext context) {
    final double badgeSize = compact ? 38 : 62;

    final Widget badge = Container(
      height: badgeSize,
      width: badgeSize,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(badgeSize / 3.6),
      ),
      child: Icon(
        Icons.balance_rounded,
        color: AppColors.surface,
        size: badgeSize * 0.55,
      ),
    );

    final Widget label = Column(
      crossAxisAlignment: compact
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          tr('app.name'),
          style: compact
              ? context.textTheme.titleMedium
              : context.textTheme.headlineMedium,
        ),
        if (showTagline) ...<Widget>[
          const SizedBox(height: AppSpacing.xs),
          Text(
            tr('app.tagline'),
            textAlign: compact ? TextAlign.start : TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ],
      ],
    );

    if (compact) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          badge,
          const SizedBox(width: AppSpacing.md),
          Flexible(child: label),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        badge,
        const SizedBox(height: AppSpacing.lg),
        label,
      ],
    );
  }
}
