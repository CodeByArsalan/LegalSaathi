import 'package:flutter/material.dart';

/// Legal-blue palette from `Mobile App Development.md` §1.3.
abstract final class AppColors {
  static const Color primary = Color(0xFF1E40AF);
  static const Color primaryDark = Color(0xFF1E3A8A);
  static const Color primaryPressed = Color(0xFF1C398F);
  static const Color secondary = Color(0xFF0F766E);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFEA580C);
  static const Color error = Color(0xFFDC2626);
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF3F4F6);
  static const Color text = Color(0xFF1F2937);
  static const Color textLight = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);

  // Tinted backgrounds for badges, chips and status pills.
  static const Color primarySoft = Color(0xFFEFF6FF);
  static const Color successSoft = Color(0xFFF0FDF4);
  static const Color warningSoft = Color(0xFFFFF7ED);
  static const Color errorSoft = Color(0xFFFEF2F2);

  static const Color overlay = Color(0x66000000);
}
