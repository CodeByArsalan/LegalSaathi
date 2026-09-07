import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// Caps readable line length on tablets and centres the column.
class MaxWidthBody extends StatelessWidget {
  const MaxWidthBody({
    required this.child,
    this.maxWidth = AppSpacing.maxContentWidth,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
