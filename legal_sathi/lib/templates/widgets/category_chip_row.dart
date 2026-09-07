import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../domain/entities/template_category.dart';

/// Horizontal category filter, headed by an "All" chip.
class CategoryChipRow extends StatelessWidget {
  const CategoryChipRow({
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelected,
    super.key,
  });

  final List<TemplateCategory> categories;
  final int? selectedCategoryId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    final String languageCode = context.locale.languageCode;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          _CategoryChip(
            label: tr('templates.all'),
            selected: selectedCategoryId == null,
            onSelected: () => onSelected(null),
          ),
          for (final TemplateCategory category in categories)
            _CategoryChip(
              label: category.name(languageCode),
              count: category.templateCount,
              selected: selectedCategoryId == category.id,
              onSelected: () => onSelected(category.id),
            ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.count,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: ChoiceChip(
        label: Text(count == null || count == 0 ? label : '$label ($count)'),
        selected: selected,
        onSelected: (_) => onSelected(),
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary,
        labelStyle: context.textTheme.labelMedium?.copyWith(
          color: selected ? Colors.white : AppColors.text,
        ),
        showCheckmark: false,
      ),
    );
  }
}
