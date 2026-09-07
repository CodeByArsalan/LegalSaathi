import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../utils/extensions/context_x.dart';

/// Zero-data panel (no documents yet, no search results, empty cart…).
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.action,
    super.key,
  });

  final String title;
  final String? message;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium,
            ),
            if (message != null) ...<Widget>[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ],
            if (action != null) ...<Widget>[
              const SizedBox(height: AppSpacing.xl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
