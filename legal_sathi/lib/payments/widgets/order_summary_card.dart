import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';

/// Amount recap above the method list.
class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    required this.documentLabel,
    required this.amount,
    super.key,
  });

  final String documentLabel;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(documentLabel, style: context.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            Formatters.freeOrPrice(amount),
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textLight,
            ),
          ),
          const Divider(height: AppSpacing.xl),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  tr('payments.total'),
                  style: context.textTheme.titleSmall,
                ),
              ),
              Text(
                Formatters.freeOrPrice(amount),
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
