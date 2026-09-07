// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemplateCategoryDto _$TemplateCategoryDtoFromJson(Map<String, dynamic> json) =>
    _TemplateCategoryDto(
      categoryId: (json['categoryId'] as num).toInt(),
      nameEn: json['nameEn'] as String,
      nameUr: json['nameUr'] as String,
      icon: json['icon'] as String,
      descriptionEn: json['descriptionEn'] as String? ?? '',
      descriptionUr: json['descriptionUr'] as String? ?? '',
      templateCount: (json['templateCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TemplateCategoryDtoToJson(
  _TemplateCategoryDto instance,
) => <String, dynamic>{
  'categoryId': instance.categoryId,
  'nameEn': instance.nameEn,
  'nameUr': instance.nameUr,
  'icon': instance.icon,
  'descriptionEn': instance.descriptionEn,
  'descriptionUr': instance.descriptionUr,
  'templateCount': instance.templateCount,
};
