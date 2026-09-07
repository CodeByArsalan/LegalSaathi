import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_spacing.dart';
import '../../utils/extensions/context_x.dart';

/// Labelled text input with an optional password visibility toggle.
class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.enabled = true,
    this.autofillHints = const <String>[],
    this.maxLength,
    this.inputFormatters,
    this.errorText,
    super.key,
  });

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final bool isPassword;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final bool enabled;
  final List<String> autofillHints;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  /// An error decided outside this widget and shown as-is, for inputs that are
  /// not inside a [Form] and so have nothing to run [validator] against.
  final String? errorText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscured,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints.isEmpty ? null : widget.autofillHints,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        errorText: widget.errorText,
        counterText: '',
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: AppSpacing.lg,
                  end: AppSpacing.md,
                ),
                child: Icon(widget.prefixIcon, size: 20),
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() => _obscured = !_obscured),
                icon: Icon(
                  _obscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                ),
                tooltip: tr(
                  _obscured ? 'common.show_password' : 'common.hide_password',
                ),
              )
            : null,
      ),
    );
  }
}
