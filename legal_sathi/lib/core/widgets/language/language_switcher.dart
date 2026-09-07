import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../di/injection_container.dart';
import '../../services/prefs_service.dart';

/// English / Urdu toggle. easy_localization owns the runtime locale; the code
/// is persisted so `bootstrap` can restore it as `startLocale`.
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({this.onChanged, this.showLabels = true, super.key});

  final ValueChanged<String>? onChanged;
  final bool showLabels;

  static const List<String> supportedCodes = <String>['en', 'ur'];

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      selected: <String>{context.locale.languageCode},
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      segments: <ButtonSegment<String>>[
        ButtonSegment<String>(
          value: 'en',
          label: showLabels ? Text(tr('common.english')) : null,
          icon: showLabels
              ? null
              : const Text('EN', style: TextStyle(fontSize: 12)),
        ),
        ButtonSegment<String>(
          value: 'ur',
          label: showLabels ? Text(tr('common.urdu')) : null,
          icon: showLabels
              ? null
              : const Text('اردو', style: TextStyle(fontSize: 12)),
        ),
      ],
      onSelectionChanged: (Set<String> selection) async {
        final String code = selection.first;
        // Translation assets are keyed by full locale (en-US, ur-PK), so a bare
        // Locale(code) would resolve to a missing en.json / ur.json.
        final Locale locale = context.supportedLocales.firstWhere(
          (Locale supported) => supported.languageCode == code,
          orElse: () => Locale(code),
        );
        await context.setLocale(locale);
        await InjectionContainer.sl<PrefsService>().setLocaleCode(code);
        onChanged?.call(code);
      },
    );
  }
}
