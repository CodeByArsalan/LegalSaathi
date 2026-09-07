import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/layout/app_logo.dart';
import '../../../core/widgets/layout/app_scaffold.dart';

/// Landing screen after a successful gateway charge.
class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({
    required this.transactionId,
    required this.amount,
    super.key,
  });

  final String transactionId;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.gutter),
          child: Column(
            children: <Widget>[
              const Spacer(),
              const AppLogo(compact: false, showTagline: false),
              const SizedBox(height: AppSpacing.xxxl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: const BoxDecoration(
                  color: AppColors.successSoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 40,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                tr('payments.success_title'),
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                tr('payments.success_body'),
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _ReceiptRow(
                label: tr('payments.reference'),
                value: transactionId,
              ),
              _ReceiptRow(
                label: tr('payments.total'),
                value: Formatters.rupees(amount),
              ),
              const Spacer(),
              PrimaryButton(
                label: tr('payments.view_documents'),
                icon: Icons.folder_open_rounded,
                onPressed: () => context.go(RoutePaths.documents),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textLight,
            ),
          ),
          Text(value, style: context.textTheme.labelMedium),
        ],
      ),
    );
  }
}
