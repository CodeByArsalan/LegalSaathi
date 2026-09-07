import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/layout/app_card.dart';
import '../domain/entities/legal_document.dart';
import 'document_status_chip.dart';

/// A saved document in the Documents tab.
///
/// A list row is a summary from `GET /Documents`: it carries no answers and no
/// file locations, so all it can show is the name, the lifecycle stage, when it
/// was started and whether it was paid for.
class DocumentCard extends StatelessWidget {
  const DocumentCard({required this.document, required this.onTap, super.key});

  final LegalDocument document;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String languageCode = context.languageCode;

    // Only worth a second line when the user named this copy themselves;
    // otherwise the title *is* the template's and repeating it says nothing.
    final bool hasOwnTitle = document.title.trim().isNotEmpty;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      document.displayName(languageCode),
                      style: context.textTheme.titleSmall,
                    ),
                    if (hasOwnTitle) ...<Widget>[
                      const SizedBox(height: 2),
                      Text(
                        document.templateTitle(languageCode),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              DocumentStatusChip(status: document.status),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: <Widget>[
              const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                Formatters.date(document.createdAt),
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.textLight,
                ),
              ),
              if (document.isPaid) ...<Widget>[
                const SizedBox(width: AppSpacing.md),
                const Icon(
                  Icons.verified_rounded,
                  size: 14,
                  color: AppColors.textLight,
                ),
                const SizedBox(width: 4),
                Text(
                  tr('documents.paid'),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
