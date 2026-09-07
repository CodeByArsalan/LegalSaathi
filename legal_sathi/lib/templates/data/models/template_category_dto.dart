import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/template_category.dart';

part 'template_category_dto.freezed.dart';
part 'template_category_dto.g.dart';

/// Wire shape of `GET /Templates/categories`.
@freezed
abstract class TemplateCategoryDto with _$TemplateCategoryDto {
  const factory TemplateCategoryDto({
    required int categoryId,
    required String nameEn,
    required String nameUr,
    required String icon,
    @Default('') String descriptionEn,
    @Default('') String descriptionUr,
    @Default(0) int templateCount,
  }) = _TemplateCategoryDto;

  factory TemplateCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$TemplateCategoryDtoFromJson(json);
}

extension TemplateCategoryDtoMapper on TemplateCategoryDto {
  TemplateCategory toEntity() => TemplateCategory(
    id: categoryId,
    nameEn: nameEn,
    nameUr: nameUr,
    descriptionEn: descriptionEn,
    descriptionUr: descriptionUr,
    icon: icon,
    templateCount: templateCount,
  );
}
