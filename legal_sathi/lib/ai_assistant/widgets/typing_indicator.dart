import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';

/// Spinner shown while the assistant composes an answer.
class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
