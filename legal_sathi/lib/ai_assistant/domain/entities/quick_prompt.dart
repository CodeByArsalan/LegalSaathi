import 'package:freezed_annotation/freezed_annotation.dart';

part 'quick_prompt.freezed.dart';

/// A starter question from `GET /Ai/quick-prompts`.
///
/// Both languages travel together rather than the one asked for, so a chip
/// follows a locale change without another round trip.
@freezed
abstract class QuickPrompt with _$QuickPrompt {
  const factory QuickPrompt({
    required String id,
    required String titleEn,
    required String titleUr,
    required String promptEn,
    required String promptUr,
    required String category,
    required String icon,
  }) = _QuickPrompt;
}

extension QuickPromptX on QuickPrompt {
  /// `ur` reads the Urdu strings and anything else the English ones — the same
  /// rule the server applies to `languageCode`.
  String titleIn(String languageCode) =>
      languageCode.startsWith('ur') ? titleUr : titleEn;

  /// The question to send, not the label to show: an Urdu reader who taps a chip
  /// asks it in Urdu, which is what makes the answer come back in Urdu.
  String promptIn(String languageCode) =>
      languageCode.startsWith('ur') ? promptUr : promptEn;
}
