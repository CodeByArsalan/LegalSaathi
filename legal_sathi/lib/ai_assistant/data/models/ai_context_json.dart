import 'dart:convert';

import '../../domain/entities/chat_message.dart';

/// Packs the transcript into the `contextJson` string `POST /Ai/ask` accepts.
///
/// The server keeps no conversation — every call is a single prompt — so without
/// this a follow-up like "and what about the witnesses?" arrives with nothing to
/// follow up on. The server prepends the string to the prompt under the label
/// `Document Context:`, which is why the turns are wrapped in a `conversation`
/// key: the label is the server's, the payload has to say what it actually is.
abstract final class AiContextJson {
  const AiContextJson._();

  /// How many transcript messages travel back — three turns. Enough to follow a
  /// thread, small enough not to crowd out the question.
  static const int maxMessages = 6;

  /// `null` when nothing precedes this question, so an opening turn sends no
  /// context at all.
  static String? pack(List<ChatMessage> history) {
    if (history.isEmpty) return null;

    final List<ChatMessage> trimmed = history.length > maxMessages
        ? history.sublist(history.length - maxMessages)
        : history;

    return jsonEncode(<String, Object>{
      'conversation': <Map<String, String>>[
        for (final ChatMessage message in trimmed)
          <String, String>{
            'role': message.role == ChatRole.user ? 'user' : 'assistant',
            'text': message.text,
          },
      ],
    });
  }
}
