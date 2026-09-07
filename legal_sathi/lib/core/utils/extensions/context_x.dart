import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// Shorthand accessors so views never repeat `Theme.of(context)` /
/// `MediaQuery.sizeOf(context)`, and so RTL-aware spacing stays consistent.
extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Language code of the active locale, so a widget can choose a bilingual
  /// entity field without importing easy_localization itself.
  String get languageCode => locale.languageCode;
  bool get isUrdu => locale.languageCode == 'ur';
  bool get isRtl => Directionality.of(this) == ui.TextDirection.rtl;

  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isCompactScreen => screenWidth < 360;
  bool get isTablet => screenWidth >= 600;
  double get gutter => AppSpacing.gutter(screenWidth);
  EdgeInsets get screenPadding => AppSpacing.screenPadding(screenWidth);
}
