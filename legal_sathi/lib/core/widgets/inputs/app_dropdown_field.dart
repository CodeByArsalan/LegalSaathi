import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../utils/extensions/context_x.dart';

/// Dropdown used by the document builder and template filters.
class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    required this.items,
    required this.value,
    required this.itemLabel,
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.enabled = true,
    super.key,
  });

  final List<T> items;
  final T? value;
  final String Function(T item) itemLabel;
  final String? label;
  final String? hint;
  final String? Function(T?)? validator;
  final ValueChanged<T?>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items
          .map(
            (T item) => DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item), overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(growable: false),
      onChanged: enabled ? onChanged : null,
      validator: validator,
      isExpanded: true,
      borderRadius: AppRadius.card,
      dropdownColor: AppColors.surface,
      style: context.textTheme.bodyLarge,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
