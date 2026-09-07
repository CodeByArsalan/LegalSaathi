import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/layout/app_card.dart';
import '../domain/entities/legal_template.dart';
import 'price_tag.dart';
import 'template_meta_row.dart';

/// List item for a document template — also used by the home feed.
class TemplateCard extends StatelessWidget {
  const TemplateCard({required this.template, required this.onTap, super.key});

  final LegalTemplate template;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String languageCode = context.languageCode;
    final String? categoryName = template.categoryName(languageCode);

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
                      template.title(languageCode),
                      style: context.textTheme.titleSmall,
                    ),
                    if (categoryName != null) ...<Widget>[
                      const SizedBox(height: 2),
                      Text(
                        categoryName,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      template.description(languageCode),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              PriceTag(price: template.basePrice, isFree: template.isFree),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TemplateMetaRow(template: template),
        ],
      ),
    );
  }
}
