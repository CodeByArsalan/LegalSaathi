import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../domain/entities/template_tier.dart';

/// Pricing tier, as the catalogue author set it. Replaces the old difficulty
/// badge: what a template costs and who it is for says more about the effort
/// involved than a guess at how hard the form is.
class TierBadge extends StatelessWidget {
  const TierBadge({required this.tier, super.key});

  final TemplateTier tier;

  static (Color, Color) _colorsOf(TemplateTier tier) => switch (tier) {
    TemplateTier.free => (AppColors.success, AppColors.successSoft),
    TemplateTier.standard => (AppColors.primary, AppColors.primarySoft),
    TemplateTier.premium => (AppColors.warning, AppColors.warningSoft),
    TemplateTier.corporate => (AppColors.secondary, AppColors.surfaceMuted),
  };

  static IconData _iconOf(TemplateTier tier) => switch (tier) {
    TemplateTier.free => Icons.card_giftcard_rounded,
    TemplateTier.standard => Icons.description_rounded,
    TemplateTier.premium => Icons.workspace_premium_rounded,
    TemplateTier.corporate => Icons.apartment_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final (Color foreground, Color background) = _colorsOf(tier);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.chip,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(_iconOf(tier), size: 13, color: foreground),
          const SizedBox(width: 4),
          Text(
            tr(tier.l10nKey),
            style: context.textTheme.labelSmall?.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}
