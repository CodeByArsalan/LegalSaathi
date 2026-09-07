import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/legal_template.dart';
import '../../domain/entities/template_tier.dart';
import 'template_field_dto.dart';

part 'legal_template_dto.freezed.dart';
part 'legal_template_dto.g.dart';

/// Wire shape of both template payloads. The list is a summary of the detail:
/// it adds the category name and omits the content, the laws and the fields.
/// Members only one of the two endpoints sends are therefore defaulted rather
/// than required.
@freezed
abstract class LegalTemplateDto with _$LegalTemplateDto {
  const factory LegalTemplateDto({
    required int templateId,
    required String slug,
    required int categoryId,
    required String titleEn,
    required String titleUr,
    required bool requiresStampPaper,
    @JsonKey(fromJson: readAmount) required double basePrice,
    @JsonKey(fromJson: readAmount) required double estimatedStampDuty,
    @Default('Standard') String tier,
    @Default('') String descriptionEn,
    @Default('') String descriptionUr,
    @Default('') String categoryNameEn,
    @Default('') String categoryNameUr,
    String? contentTemplateEn,
    String? contentTemplateUr,
    String? applicableLaws,
    @Default(<TemplateFieldDto>[]) List<TemplateFieldDto> formFields,
  }) = _LegalTemplateDto;

  factory LegalTemplateDto.fromJson(Map<String, dynamic> json) =>
      _$LegalTemplateDtoFromJson(json);
}

extension LegalTemplateDtoMapper on LegalTemplateDto {
  LegalTemplate toEntity() => LegalTemplate(
    id: templateId,
    slug: slug,
    categoryId: categoryId,
    titleEn: titleEn,
    titleUr: titleUr,
    descriptionEn: descriptionEn,
    descriptionUr: descriptionUr,
    basePrice: basePrice,
    tier: TemplateTier.parse(tier),
    requiresStampPaper: requiresStampPaper,
    estimatedStampDuty: estimatedStampDuty,
    categoryNameEn: categoryNameEn.isEmpty ? null : categoryNameEn,
    categoryNameUr: categoryNameUr.isEmpty ? null : categoryNameUr,
    contentTemplateEn: contentTemplateEn,
    contentTemplateUr: contentTemplateUr,
    applicableLaws: applicableLaws,
    fields: formFields
        .map((TemplateFieldDto field) => field.toEntity())
        .toList(growable: false),
  );
}

/// Money arrives as a JSON number, and a whole amount may be written without a
/// decimal point — `as double` throws on an `int`, so read it as a `num`.
double readAmount(Object? value) => (value as num?)?.toDouble() ?? 0;
