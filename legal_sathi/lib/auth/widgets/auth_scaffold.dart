import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/language/language_switcher.dart';
import '../../../core/widgets/layout/app_card.dart';
import '../../../core/widgets/layout/app_logo.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/layout/max_width_body.dart';

/// Shared frame for login / register / verify: brand, headline, one card,
/// language switcher in the corner.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.title,
    required this.subtitle,
    required this.children,
    this.footnote,
    super.key,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final Widget? footnote;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.gutter,
            vertical: AppSpacing.xl,
          ),
          child: MaxWidthBody(
            maxWidth: 460,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: LanguageSwitcher(showLabels: false),
                ),
                const SizedBox(height: AppSpacing.xl),
                const AppLogo(),
                const SizedBox(height: AppSpacing.xxxl),
                Text(title, style: context.textTheme.headlineSmall),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  subtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppCard(child: Column(children: children)),
                if (footnote != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.lg),
                  footnote!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
