import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';

/// "New to Legal Sathi? Create an account" style switch between auth screens.
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    required this.question,
    required this.actionLabel,
    required this.onTap,
    super.key,
  });

  final String question;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: '$question ',
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.textLight,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: actionLabel,
              style: context.textTheme.labelLarge?.copyWith(
                color: AppColors.primary,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Small legal/terms note under the primary auth action.
class AuthTermsNote extends StatelessWidget {
  const AuthTermsNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Text(
        '${tr('auth.terms_prefix')} ${tr('auth.terms_link')}',
        textAlign: TextAlign.center,
        style: context.textTheme.bodySmall?.copyWith(
          color: AppColors.textLight,
        ),
      ),
    );
  }
}
