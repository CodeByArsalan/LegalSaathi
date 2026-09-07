import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';
import '../domain/entities/legal_template.dart';
import 'tier_badge.dart';

/// Tier, stamp duty and question count — shown on cards and the detail header.
///
/// The stamp duty and the question count are both conditional: duty only
/// applies to some templates, and the catalogue's list endpoint returns
/// summaries with no fields at all, so a card cannot know how many questions
/// the form asks.
class TemplateMetaRow extends StatelessWidget {
  const TemplateMetaRow({required this.template, super.key});

  final LegalTemplate template;

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = context.textTheme.labelSmall?.copyWith(
      color: AppColors.textLight,
    );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 4,
      children: <Widget>[
        TierBadge(tier: template.tier),
        if (template.requiresStampPaper)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.local_atm_rounded,
                size: 14,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                tr(
                  'templates.stamp_duty',
                  namedArgs: <String, String>{
                    'amount': Formatters.rupees(template.estimatedStampDuty),
                  },
                ),
                style: style,
              ),
            ],
          ),
        if (template.fields.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.help_outline_rounded,
                size: 14,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                tr(
                  'templates.fields_count',
                  namedArgs: <String, String>{
                    'count': '${template.fieldCount}',
                  },
                ),
                style: style,
              ),
            ],
          ),
      ],
    );
  }
}
