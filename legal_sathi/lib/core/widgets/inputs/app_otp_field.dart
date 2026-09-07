import 'package:flutter/material.dart';
import '../../utils/extensions/context_x.dart';

/// Numeric one-line OTP entry (email verification, OTP signing).
class AppOtpField extends StatelessWidget {
  const AppOtpField({
    required this.controller,
    this.length = 6,
    this.label,
    this.validator,
    this.onCompleted,
    this.enabled = true,
    super.key,
  });

  final TextEditingController controller;
  final int length;
  final String? label;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onCompleted;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: length,
      textAlign: TextAlign.center,
      enabled: enabled,
      validator: validator,
      onChanged: (String value) {
        if (value.length == length) onCompleted?.call(value);
      },
      style: context.textTheme.titleLarge?.copyWith(letterSpacing: 8),
      decoration: InputDecoration(
        labelText: label,
        counterText: '',
        hintText: '•' * length,
      ),
    );
  }
}
