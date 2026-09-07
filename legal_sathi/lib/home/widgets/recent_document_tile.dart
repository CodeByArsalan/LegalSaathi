import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';
import '../../../documents/domain/entities/document_status.dart';
import '../../../documents/domain/entities/legal_document.dart';
import '../../../documents/widgets/document_status_chip.dart';

/// Compact dashboard row for a saved document. The fuller `DocumentCard`
/// belongs to the Documents tab, so home keeps its own lighter density.
class RecentDocumentTile extends StatelessWidget {
  const RecentDocumentTile({
    required this.document,
    required this.onTap,
    super.key,
  });

  final LegalDocument document;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String languageCode = context.locale.languageCode;
    final Color color = DocumentStatusChip.colorOf(document.status);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          children: <Widget>[
            Icon(Icons.circle, size: 8, color: color),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    document.displayName(languageCode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    Formatters.date(document.createdAt),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              tr(document.status.l10nKey),
              style: context.textTheme.labelSmall?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
