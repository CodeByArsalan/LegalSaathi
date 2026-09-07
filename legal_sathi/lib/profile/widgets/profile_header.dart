import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/layout/app_card.dart';

/// Name, email and joined-on, above the account stats.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.fullName,
    required this.email,
    required this.memberSince,
    super.key,
  });

  final String fullName;
  final String email;

  /// Null until `GET /Auth/me` has been read; the line is omitted rather than
  /// guessed at.
  final DateTime? memberSince;

  @override
  Widget build(BuildContext context) {
    final DateTime? joined = memberSince;
    return AppCard(
      child: Row(
        children: <Widget>[
          Container(
            height: 56,
            width: 56,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Text(
              _initials(fullName),
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(fullName, style: context.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  email,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
                if (joined != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    tr(
                      'profile.member_since',
                      namedArgs: <String, String>{
                        'date': Formatters.date(joined),
                      },
                    ),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _initials(String name) {
    final List<String> parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    final String first = parts.first[0];
    final String? last = parts.length > 1 ? parts.last[0] : null;
    return '$first${last ?? ''}'.toUpperCase();
  }
}

/// Three-up counter row: documents, signed, completed.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    required this.documentsCount,
    required this.signedCount,
    required this.completedCount,
    super.key,
  });

  final int documentsCount;
  final int signedCount;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _Stat(
            value: documentsCount,
            label: tr('profile.documents_count'),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _Stat(value: signedCount, label: tr('profile.signed_count')),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _Stat(
            value: completedCount,
            label: tr('profile.completed_count'),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
        horizontal: AppSpacing.sm,
      ),
      child: Column(
        children: <Widget>[
          Text('$value', style: context.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
