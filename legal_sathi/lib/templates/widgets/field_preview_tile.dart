import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../domain/entities/field_type.dart';
import '../domain/entities/template_field.dart';

/// Preview of one guided question, shown on the template detail screen so the
/// user knows what information to gather before starting.
class FieldPreviewTile extends StatelessWidget {
  const FieldPreviewTile({
    required this.field,
    required this.position,
    required this.languageCode,
    super.key,
  });

  final TemplateField field;

  /// Display number in the ordered question list. Taken from the caller rather
  /// than from `sortOrder`, which is a per-step sort key and need not start at
  /// one or run consecutively.
  final int position;
  final String languageCode;

  static IconData iconFor(FieldType type) => switch (type) {
    FieldType.text => Icons.text_fields_rounded,
    FieldType.textarea => Icons.notes_rounded,
    FieldType.number => Icons.pin_rounded,
    FieldType.date => Icons.calendar_today_rounded,
    FieldType.dropdown => Icons.expand_more_rounded,
    FieldType.email => Icons.alternate_email_rounded,
    FieldType.phone => Icons.phone_rounded,
    FieldType.cnic => Icons.credit_card_rounded,
    FieldType.radio => Icons.radio_button_checked_rounded,
    FieldType.checkbox => Icons.check_box_rounded,
    FieldType.currencyPkr => Icons.payments_rounded,
    FieldType.address => Icons.location_on_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 26,
            child: Text(
              '$position',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textLight,
              ),
            ),
          ),
          Icon(iconFor(field.fieldType), size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  field.label(languageCode),
                  style: context.textTheme.bodyMedium,
                ),
                if (field.help(languageCode) != null)
                  Text(
                    field.help(languageCode)!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
              ],
            ),
          ),
          if (field.isRequired)
            Text(
              tr('common.required_field'),
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.error,
              ),
            ),
        ],
      ),
    );
  }
}
