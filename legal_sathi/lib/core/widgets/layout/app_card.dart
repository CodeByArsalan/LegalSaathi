import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

/// Bordered surface card — the default container for list items, form groups
/// and detail panels.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
    this.onTap,
    this.borderColor,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.surface,
      borderRadius: AppRadius.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.card,
            border: Border.all(color: borderColor ?? AppColors.border),
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
