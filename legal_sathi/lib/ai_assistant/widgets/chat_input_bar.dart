import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../domain/entities/quick_prompt.dart';

/// Composer row pinned above the keyboard.
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    required this.controller,
    required this.onSend,
    this.enabled = true,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        context.gutter,
        AppSpacing.sm,
        context.gutter,
        AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (BuildContext context, TextEditingValue value, _) {
                return TextField(
                  controller: controller,
                  enabled: enabled,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  style: context.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: tr('ai.placeholder'),
                    filled: true,
                    fillColor: AppColors.surfaceMuted,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          FilledButton(
            onPressed: enabled ? onSend : null,
            style: FilledButton.styleFrom(
              minimumSize: const Size(52, 52),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: AppRadius.field),
            ),
            child: const Icon(Icons.send_rounded, size: 20),
          ),
        ],
      ),
    );
  }
}

/// Starter prompts shown above the composer on an empty conversation.
///
/// The server's own quick prompts are preferred, and they arrive in both
/// languages, so the chips follow a locale change without another round trip.
/// When they did not arrive the three bundled questions stand in, because an
/// empty row above the composer looks broken rather than patient.
class SuggestedQuestions extends StatelessWidget {
  const SuggestedQuestions({
    required this.prompts,
    required this.languageCode,
    required this.onSelected,
    super.key,
  });

  final List<QuickPrompt> prompts;

  /// `context.locale.languageCode`: it picks which of the server's two strings a
  /// chip shows, and which question it asks.
  final String languageCode;

  final ValueChanged<String> onSelected;

  static const List<String> _bundledKeys = <String>[
    'ai.suggestion_1',
    'ai.suggestion_2',
    'ai.suggestion_3',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('ai.suggested'),
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: <Widget>[
            for (final _Suggestion suggestion in _suggestions)
              ActionChip(
                avatar: suggestion.icon == null
                    ? null
                    : Icon(suggestion.icon, size: 16, color: AppColors.primary),
                label: Text(
                  suggestion.label,
                  style: context.textTheme.labelMedium,
                ),
                backgroundColor: AppColors.primarySoft,
                side: BorderSide.none,
                onPressed: suggestion.onPressed,
              ),
          ],
        ),
      ],
    );
  }

  List<_Suggestion> get _suggestions => prompts.isEmpty
      ? _bundledKeys
            .map<_Suggestion>(
              (String key) => (
                label: tr(key),
                icon: null,
                onPressed: () => onSelected(tr(key)),
              ),
            )
            .toList(growable: false)
      : prompts
            .map<_Suggestion>(
              (QuickPrompt prompt) => (
                label: prompt.titleIn(languageCode),
                icon: AppIcons.byName(prompt.icon),
                onPressed: () => onSelected(prompt.promptIn(languageCode)),
              ),
            )
            .toList(growable: false);
}

typedef _Suggestion = ({String label, IconData? icon, VoidCallback onPressed});
