import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../errors/failure.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../utils/extensions/context_x.dart';
import '../buttons/primary_button.dart';

/// Standard failure panel for a whole screen or a list region.
class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.failure,
    this.onRetry,
    this.compact = false,
    super.key,
  });

  final Failure failure;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final String title = tr(failure.l10nKey);
    final String? detail = failure.message;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        margin: EdgeInsets.all(compact ? 0 : AppSpacing.xl),
        padding: EdgeInsets.all(compact ? AppSpacing.lg : AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              _iconFor(failure),
              size: compact ? 28 : 40,
              color: AppColors.error,
            ),
            SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleSmall,
            ),
            if (detail != null && detail.isNotEmpty) ...<Widget>[
              const SizedBox(height: AppSpacing.sm),
              Text(
                detail,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ],
            if (onRetry != null) ...<Widget>[
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: tr('common.retry'),
                icon: Icons.refresh_rounded,
                expanded: false,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }

  static IconData _iconFor(Failure failure) => switch (failure) {
    NetworkFailure() || TimeoutFailure() => Icons.wifi_off_rounded,
    SessionExpiredFailure() => Icons.lock_clock,
    NotFoundFailure() => Icons.search_off_rounded,
    ValidationFailure() => Icons.error_outline_rounded,
    _ => Icons.report_gmailerrorred_rounded,
  };
}
