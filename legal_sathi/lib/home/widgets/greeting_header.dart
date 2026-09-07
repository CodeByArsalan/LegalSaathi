import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/language/language_switcher.dart';

/// Personalised greeting with the language switch, shown at the top of home.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tr(
                    'home.greeting',
                    namedArgs: <String, String>{'name': name},
                  ),
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  tr('home.subtitle'),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          const LanguageSwitcher(showLabels: false),
        ],
      ),
    );
  }
}
