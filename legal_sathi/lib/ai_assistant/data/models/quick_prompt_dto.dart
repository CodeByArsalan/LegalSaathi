import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/quick_prompt.dart';

part 'quick_prompt_dto.freezed.dart';
part 'quick_prompt_dto.g.dart';

/// Wire shape of `QuickPromptDto`. The server spells the languages out in the
/// field names (`titleEng`, `titleUrdu`), so both are read rather than one
/// guessed at from the request.
@freezed
abstract class QuickPromptDto with _$QuickPromptDto {
  const factory QuickPromptDto({
    required String id,
    @Default('') String titleEng,
    @Default('') String titleUrdu,
    @Default('') String promptEng,
    @Default('') String promptUrdu,
    @Default('') String category,
    @Default('') String icon,
  }) = _QuickPromptDto;

  factory QuickPromptDto.fromJson(Map<String, dynamic> json) =>
      _$QuickPromptDtoFromJson(json);
}

extension QuickPromptDtoMapper on QuickPromptDto {
  QuickPrompt toEntity() => QuickPrompt(
    id: id,
    titleEn: titleEng,
    titleUr: titleUrdu,
    promptEn: promptEng,
    promptUr: promptUrdu,
    category: category,
    icon: icon,
  );
}
