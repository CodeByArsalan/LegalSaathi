import 'package:flutter/widgets.dart';

/// Spacing scale that replaces per-widget magic numbers and screenutil.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const double buttonHeight = 52;
  static const double iconTileSize = 44;
  static const double listThumbnailSize = 56;

  /// Keeps line length readable on tablets instead of stretching edge to edge.
  static const double maxContentWidth = 720;

  /// Screen gutters: tighter on small phones, wider on large screens.
  static double gutter(double screenWidth) {
    if (screenWidth < 360) return md;
    if (screenWidth < 600) return lg;
    return xl;
  }

  static EdgeInsets screenPadding(double screenWidth) =>
      EdgeInsets.symmetric(horizontal: gutter(screenWidth), vertical: md);
}
