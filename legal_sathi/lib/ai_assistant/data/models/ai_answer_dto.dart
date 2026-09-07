import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_answer_dto.freezed.dart';
part 'ai_answer_dto.g.dart';

/// Wire shape of `AiAskResponse`, the payload of `POST /Ai/ask`.
///
/// `answer` is markdown — the server's own fallback engine and the models it
/// relays to both answer in `**bold**` headings and numbered lists — so it is
/// rendered through `MarkdownText` rather than shown literally.
///
/// `totalTokens` and `model` describe the call instead of the answer, and
/// `queryId` is null when the server could not persist the exchange. All three
/// are read because they arrive, and none is rendered.
@freezed
abstract class AiAnswerDto with _$AiAnswerDto {
  const factory AiAnswerDto({
    @Default('') String answer,
    @Default(0) int totalTokens,
    @Default('') String model,
    int? queryId,
  }) = _AiAnswerDto;

  factory AiAnswerDto.fromJson(Map<String, dynamic> json) =>
      _$AiAnswerDtoFromJson(json);
}
