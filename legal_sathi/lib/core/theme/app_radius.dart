import 'package:flutter/painting.dart';

abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double pill = 999;

  static final BorderRadius card = BorderRadius.circular(md);
  static final BorderRadius field = BorderRadius.circular(md);
  static final BorderRadius button = BorderRadius.circular(md);
  static final BorderRadius chip = BorderRadius.circular(pill);
  static final BorderRadius sheet = BorderRadius.vertical(
    top: Radius.circular(lg + 8),
  );
}
