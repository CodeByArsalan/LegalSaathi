import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';

/// Free vs premium pill. Prices are always PKR.
class PriceTag extends StatelessWidget {
  const PriceTag({required this.price, this.isFree = false, super.key});

  final double price;
  final bool isFree;

  @override
  Widget build(BuildContext context) {
    final bool free = isFree || price <= 0;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: free ? AppColors.successSoft : AppColors.primarySoft,
        borderRadius: AppRadius.chip,
      ),
      child: Text(
        free ? tr('common.free') : Formatters.rupees(price),
        style: context.textTheme.labelSmall?.copyWith(
          color: free ? AppColors.success : AppColors.primary,
        ),
      ),
    );
  }
}
