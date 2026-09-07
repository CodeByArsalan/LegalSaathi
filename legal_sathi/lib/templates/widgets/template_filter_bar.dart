import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';

/// Search box + result count above the template list.
class TemplateFilterBar extends StatelessWidget {
  const TemplateFilterBar({
    required this.controller,
    required this.onChanged,
    required this.resultCount,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int resultCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (BuildContext context, TextEditingValue value, _) {
            return TextField(
              controller: controller,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              style: context.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: tr('templates.search_hint'),
                prefixIcon: const Icon(Icons.search_rounded, size: 20),
                suffixIcon: value.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close_rounded, size: 18),
                        tooltip: tr('common.close'),
                        onPressed: () {
                          controller.clear();
                          onChanged('');
                        },
                      ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          tr(
            'templates.results',
            namedArgs: <String, String>{'count': '$resultCount'},
          ),
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }
}
