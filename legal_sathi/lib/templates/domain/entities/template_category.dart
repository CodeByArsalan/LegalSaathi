import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_category.freezed.dart';

@freezed
abstract class TemplateCategory with _$TemplateCategory {
  const factory TemplateCategory({
    required int id,
    required String nameEn,
    required String nameUr,
    required String descriptionEn,
    required String descriptionUr,
    required String icon,
    @Default(0) int templateCount,
  }) = _TemplateCategory;
}

extension TemplateCategoryX on TemplateCategory {
  String name(String languageCode) => languageCode == 'ur' ? nameUr : nameEn;

  String description(String languageCode) =>
      languageCode == 'ur' ? descriptionUr : descriptionEn;
}
