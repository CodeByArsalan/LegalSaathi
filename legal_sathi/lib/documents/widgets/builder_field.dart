import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/extensions/context_x.dart';
import '../../core/widgets/inputs/app_dropdown_field.dart';
import '../../core/widgets/inputs/app_text_field.dart';
import '../../templates/domain/entities/field_type.dart';
import '../../templates/domain/entities/template_field.dart';

/// Renders one guided question.
///
/// The stored answer is always a plain string, whatever the widget: dates as ISO
/// `yyyy-MM-dd`, option fields as the option text itself, and a checkbox group as
/// its picks comma-joined — the answer map is `String`-valued, so a multi-select
/// has to be flattened into one.
class BuilderField extends StatefulWidget {
  const BuilderField({
    required this.field,
    required this.value,
    required this.onChanged,
    this.errorText,
    super.key,
  });

  final TemplateField field;
  final String value;
  final ValueChanged<String> onChanged;

  /// Why this answer was rejected, already translated. Null until the user has
  /// tried to move on, so a field is not marked wrong before it is touched.
  final String? errorText;

  @override
  State<BuilderField> createState() => _BuilderFieldState();
}

class _BuilderFieldState extends State<BuilderField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value,
  );

  @override
  void didUpdateWidget(covariant BuilderField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Text inputs carry their error inside the decoration, which also reddens the
  /// outline; the rest show it on the line below instead.
  bool get _errorInsideInput => switch (widget.field.fieldType) {
    FieldType.dropdown ||
    FieldType.date ||
    FieldType.radio ||
    FieldType.checkbox => false,
    _ => true,
  };

  @override
  Widget build(BuildContext context) {
    final TemplateField field = widget.field;
    final String languageCode = context.languageCode;

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          switch (field.fieldType) {
            FieldType.dropdown => _buildDropdown(context),
            FieldType.date => _buildDate(context),
            FieldType.radio => _buildChoices(context, multi: false),
            FieldType.checkbox => _buildChoices(context, multi: true),
            _ => _buildText(field, languageCode),
          },
          if (widget.errorText case final String error?
              when !_errorInsideInput) ...<Widget>[
            const SizedBox(height: AppSpacing.xs),
            Text(
              error,
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.error,
              ),
            ),
          ],
          if (field.help(languageCode) case final String help?) ...<Widget>[
            const SizedBox(height: AppSpacing.xs),
            Text(help, style: context.textTheme.labelSmall),
          ],
        ],
      ),
    );
  }

  Widget _buildText(TemplateField field, String languageCode) {
    return AppTextField(
      controller: _controller,
      label: _label(field, languageCode),
      hint:
          field.placeholder(languageCode) ?? tr('documents.answer_placeholder'),
      keyboardType: _keyboardType(field.fieldType),
      inputFormatters: field.fieldType == FieldType.number
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      maxLines: field.fieldType.acceptsMultiline ? 4 : 1,
      prefixIcon: field.fieldType == FieldType.currencyPkr
          ? Icons.payments_rounded
          : null,
      errorText: widget.errorText,
      onChanged: widget.onChanged,
    );
  }

  Widget _buildDropdown(BuildContext context) {
    final TemplateField field = widget.field;
    final String languageCode = context.languageCode;

    return AppDropdownField<String>(
      items: field.options,
      value: field.options.contains(widget.value) ? widget.value : null,
      itemLabel: (String option) => option,
      label: _label(field, languageCode),
      hint: tr('documents.select_option'),
      onChanged: (String? value) {
        if (value != null) widget.onChanged(value);
      },
    );
  }

  Widget _buildChoices(BuildContext context, {required bool multi}) {
    final TemplateField field = widget.field;
    final String languageCode = context.languageCode;
    final Set<String> selected = multi
        ? widget.value
              .split(',')
              .map((String option) => option.trim())
              .where((String option) => option.isNotEmpty)
              .toSet()
        : <String>{widget.value};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_label(field, languageCode), style: context.textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: <Widget>[
            for (final String option in field.options)
              multi
                  ? FilterChip(
                      label: Text(option),
                      selected: selected.contains(option),
                      onSelected: (bool isSelected) =>
                          _toggleOption(option, isSelected),
                    )
                  : ChoiceChip(
                      label: Text(option),
                      selected: selected.contains(option),
                      onSelected: (_) => widget.onChanged(option),
                    ),
          ],
        ),
      ],
    );
  }

  /// Re-joins the picks in the order the options are listed, so the stored answer
  /// does not depend on the order they were tapped in.
  void _toggleOption(String option, bool isSelected) {
    final Set<String> current = widget.value
        .split(',')
        .map((String value) => value.trim())
        .where((String value) => value.isNotEmpty)
        .toSet();
    if (isSelected) {
      current.add(option);
    } else {
      current.remove(option);
    }
    widget.onChanged(widget.field.options.where(current.contains).join(','));
  }

  Widget _buildDate(BuildContext context) {
    final TemplateField field = widget.field;
    final String languageCode = context.languageCode;
    final DateTime? parsed = DateTime.tryParse(widget.value);

    return InkWell(
      onTap: () => _pickDate(context, parsed),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: _label(field, languageCode),
          suffixIcon: const Icon(Icons.calendar_today_rounded, size: 20),
        ),
        child: Text(
          parsed == null
              ? field.placeholder(languageCode) ??
                    tr('documents.answer_placeholder')
              : DateFormat.yMMMd(context.locale.toString()).format(parsed),
          style: context.textTheme.bodyLarge,
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context, DateTime? current) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: current ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 50),
    );
    if (picked != null) {
      widget.onChanged(
        '${picked.year.toString().padLeft(4, '0')}-'
        '${picked.month.toString().padLeft(2, '0')}-'
        '${picked.day.toString().padLeft(2, '0')}',
      );
    }
  }

  String _label(TemplateField field, String languageCode) {
    final String label = field.label(languageCode);
    return field.isRequired ? '$label *' : label;
  }

  TextInputType? _keyboardType(FieldType type) => switch (type) {
    FieldType.number || FieldType.currencyPkr => TextInputType.number,
    FieldType.email => TextInputType.emailAddress,
    FieldType.phone => TextInputType.phone,
    FieldType.cnic => TextInputType.number,
    FieldType.address => TextInputType.streetAddress,
    _ => null,
  };
}
