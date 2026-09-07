import 'package:flutter/material.dart';

/// Type scale. Urdu renders through a Nastaliq family which sits much smaller
/// on the baseline, so it needs a larger size and looser line height.
abstract final class AppTypography {
  static const String? englishFontFamily = null;
  static const String urduFontFamily = 'NotoNastaliqUrdu';

  static const double _urduScale = 1.22;
  static const double _urduLineHeight = 2.1;
  static const double _latinLineHeight = 1.35;

  static TextTheme build({required bool isUrdu}) {
    final double scale = isUrdu ? _urduScale : 1;
    final double lineHeight = isUrdu ? _urduLineHeight : _latinLineHeight;
    final String? fontFamily = isUrdu ? urduFontFamily : englishFontFamily;

    TextStyle style(
      double size,
      FontWeight weight, {
      double? spacing,
      double? height,
    }) {
      return TextStyle(
        fontSize: size * scale,
        fontWeight: weight,
        fontFamily: fontFamily,
        letterSpacing: isUrdu ? 0 : spacing,
        height: height ?? lineHeight,
      );
    }

    return TextTheme(
      displaySmall: style(30, FontWeight.w700, height: 1.2),
      headlineMedium: style(24, FontWeight.w700, height: 1.25),
      headlineSmall: style(20, FontWeight.w700),
      titleLarge: style(18, FontWeight.w600),
      titleMedium: style(16, FontWeight.w600),
      titleSmall: style(14, FontWeight.w600),
      bodyLarge: style(16, FontWeight.w400),
      bodyMedium: style(15, FontWeight.w400),
      bodySmall: style(13, FontWeight.w400, height: 1.45),
      labelLarge: style(15, FontWeight.w600, spacing: 0.2),
      labelMedium: style(13, FontWeight.w600, spacing: 0.4),
      labelSmall: style(11, FontWeight.w600, spacing: 0.6),
    );
  }
}
