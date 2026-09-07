import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../domain/entities/chat_message.dart';
import 'markdown_text.dart';

/// Assistant bubbles read as a tinted panel, user bubbles as the primary face.
class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, super.key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bool fromAssistant = message.role == ChatRole.assistant;
    final TextStyle? bodyStyle = context.textTheme.bodyMedium;

    return Align(
      alignment: fromAssistant
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      child: Container(
        constraints: BoxConstraints(maxWidth: context.screenWidth * 0.82),
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: fromAssistant ? AppColors.surface : AppColors.primary,
          borderRadius: BorderRadiusDirectional.only(
            topStart: const Radius.circular(AppRadius.lg),
            topEnd: const Radius.circular(AppRadius.lg),
            bottomStart: Radius.circular(
              fromAssistant ? AppRadius.sm : AppRadius.lg,
            ),
            bottomEnd: Radius.circular(
              fromAssistant ? AppRadius.lg : AppRadius.sm,
            ),
          ),
          border: fromAssistant ? Border.all(color: AppColors.border) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (fromAssistant) ...<Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.balance_rounded,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    tr('app.name'),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            MarkdownText(
              text: message.text,
              style: fromAssistant
                  ? bodyStyle
                  : bodyStyle?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
