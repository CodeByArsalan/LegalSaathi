// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_template_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LegalTemplateDto _$LegalTemplateDtoFromJson(Map<String, dynamic> json) =>
    _LegalTemplateDto(
      templateId: (json['templateId'] as num).toInt(),
      slug: json['slug'] as String,
      categoryId: (json['categoryId'] as num).toInt(),
      titleEn: json['titleEn'] as String,
      titleUr: json['titleUr'] as String,
      requiresStampPaper: json['requiresStampPaper'] as bool,
      basePrice: readAmount(json['basePrice']),
      estimatedStampDuty: readAmount(json['estimatedStampDuty']),
      tier: json['tier'] as String? ?? 'Standard',
      descriptionEn: json['descriptionEn'] as String? ?? '',
      descriptionUr: json['descriptionUr'] as String? ?? '',
      categoryNameEn: json['categoryNameEn'] as String? ?? '',
      categoryNameUr: json['categoryNameUr'] as String? ?? '',
      contentTemplateEn: json['contentTemplateEn'] as String?,
      contentTemplateUr: json['contentTemplateUr'] as String?,
      applicableLaws: json['applicableLaws'] as String?,
      formFields:
          (json['formFields'] as List<dynamic>?)
              ?.map((e) => TemplateFieldDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TemplateFieldDto>[],
    );

Map<String, dynamic> _$LegalTemplateDtoToJson(_LegalTemplateDto instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'slug': instance.slug,
      'categoryId': instance.categoryId,
      'titleEn': instance.titleEn,
      'titleUr': instance.titleUr,
      'requiresStampPaper': instance.requiresStampPaper,
      'basePrice': instance.basePrice,
      'estimatedStampDuty': instance.estimatedStampDuty,
      'tier': instance.tier,
      'descriptionEn': instance.descriptionEn,
      'descriptionUr': instance.descriptionUr,
      'categoryNameEn': instance.categoryNameEn,
      'categoryNameUr': instance.categoryNameUr,
      'contentTemplateEn': instance.contentTemplateEn,
      'contentTemplateUr': instance.contentTemplateUr,
      'applicableLaws': instance.applicableLaws,
      'formFields': instance.formFields,
    };
