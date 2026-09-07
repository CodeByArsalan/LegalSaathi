import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

enum ChatRole {
  user,
  assistant;

  static ChatRole parse(String? value) =>
      value?.toLowerCase() == 'user' ? ChatRole.user : ChatRole.assistant;
}

/// One turn in the legal-assistant conversation. `text` is already in the
/// language the user is reading the app in.
@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required ChatRole role,
    required String text,
    required DateTime createdAt,
  }) = _ChatMessage;
}
