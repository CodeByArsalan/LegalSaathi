import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../domain/entities/payment.dart';

/// Selectable payment rail row.
class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    required this.method,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  static IconData iconFor(PaymentMethod method) => switch (method) {
    PaymentMethod.jazzcash => Icons.phone_android_rounded,
    PaymentMethod.easypaisa => Icons.account_balance_wallet_rounded,
    PaymentMethod.card => Icons.credit_card_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.card,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: selected ? AppColors.primarySoft : AppColors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              iconFor(method),
              color: selected ? AppColors.primary : AppColors.textLight,
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Text(
                tr(method.l10nKey),
                style: context.textTheme.titleSmall,
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected ? AppColors.primary : AppColors.border,
            ),
          ],
        ),
      ),
    );
  }
}
