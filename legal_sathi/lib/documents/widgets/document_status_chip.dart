import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../domain/entities/document_status.dart';

/// The document's place in the API's seven-state lifecycle.
class DocumentStatusChip extends StatelessWidget {
  const DocumentStatusChip({required this.status, super.key});

  final DocumentStatus status;

  /// One mapping for every surface that colours a status, so the dashboard dot
  /// and this chip cannot disagree.
  static Color colorOf(DocumentStatus status) => switch (status) {
    DocumentStatus.draft => AppColors.textLight,
    DocumentStatus.completed => AppColors.primary,
    DocumentStatus.pendingSignature => AppColors.warning,
    DocumentStatus.signed => AppColors.success,
    DocumentStatus.underLawyerReview => AppColors.secondary,
    DocumentStatus.lawyerApproved => AppColors.success,
    DocumentStatus.archived => AppColors.textLight,
  };

  @override
  Widget build(BuildContext context) {
    final Color color = colorOf(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: AppRadius.chip,
      ),
      child: Text(
        tr(status.l10nKey),
        style: context.textTheme.labelSmall?.copyWith(color: color),
      ),
    );
  }
}
