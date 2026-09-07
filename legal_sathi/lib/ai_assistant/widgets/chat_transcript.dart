import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../domain/entities/chat_message.dart';
import 'chat_bubble.dart';
import 'typing_indicator.dart';

/// Scrollable transcript: greeting turn, message bubbles, then a typing
/// indicator while an answer is in flight.
class ChatTranscript extends StatelessWidget {
  const ChatTranscript({
    required this.messages,
    required this.isWaitingForAnswer,
    this.scrollController,
    super.key,
  });

  final List<ChatMessage> messages;
  final bool isWaitingForAnswer;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final List<ChatMessage> transcript = <ChatMessage>[
      ChatMessage(
        id: 'greeting',
        role: ChatRole.assistant,
        text: tr('ai.greeting'),
        createdAt: DateTime.now(),
      ),
      ...messages,
    ];

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(
        context.gutter,
        AppSpacing.md,
        context.gutter,
        AppSpacing.lg,
      ),
      itemCount: transcript.length + (isWaitingForAnswer ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index >= transcript.length) return const TypingIndicator();
        return ChatBubble(message: transcript[index]);
      },
    );
  }
}
