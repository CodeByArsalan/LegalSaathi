import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/extensions/context_x.dart';

/// Read-only date input that opens the Material date picker.
class AppDateField extends StatelessWidget {
  const AppDateField({
    required this.value,
    required this.onPicked,
    this.label,
    this.hint,
    this.firstDate,
    this.lastDate,
    this.validator,
    super.key,
  });

  final DateTime? value;
  final ValueChanged<DateTime> onPicked;
  final String? label;
  final String? hint;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(String?)? validator;

  Future<void> _pick(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(now.year - 60),
      lastDate: lastDate ?? DateTime(now.year + 10),
      locale: context.locale,
    );
    if (picked != null) onPicked(picked);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      showCursor: false,
      onTap: () => _pick(context),
      validator: validator,
      style: context.textTheme.bodyLarge,
      controller: TextEditingController(
        text: value == null ? '' : DateFormat('dd MMM yyyy').format(value!),
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint ?? tr('common.select_date'),
        prefixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
        suffixIcon: const Icon(Icons.expand_more),
      ),
    );
  }
}
