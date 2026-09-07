// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_field_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemplateFieldDto _$TemplateFieldDtoFromJson(Map<String, dynamic> json) =>
    _TemplateFieldDto(
      fieldId: (json['fieldId'] as num).toInt(),
      fieldKey: json['fieldKey'] as String,
      fieldType: json['fieldType'] as String,
      labelEn: json['labelEn'] as String,
      labelUr: json['labelUr'] as String,
      isRequired: json['isRequired'] as bool,
      stepNumber: (json['stepNumber'] as num).toInt(),
      sortOrder: (json['sortOrder'] as num).toInt(),
      placeholderEn: json['placeholderEn'] as String? ?? '',
      placeholderUr: json['placeholderUr'] as String? ?? '',
      helpTextEn: json['helpTextEn'] as String? ?? '',
      helpTextUr: json['helpTextUr'] as String? ?? '',
      validationRegex: json['validationRegex'] as String?,
      optionsJson: json['optionsJson'] as String?,
    );

Map<String, dynamic> _$TemplateFieldDtoToJson(_TemplateFieldDto instance) =>
    <String, dynamic>{
      'fieldId': instance.fieldId,
      'fieldKey': instance.fieldKey,
      'fieldType': instance.fieldType,
      'labelEn': instance.labelEn,
      'labelUr': instance.labelUr,
      'isRequired': instance.isRequired,
      'stepNumber': instance.stepNumber,
      'sortOrder': instance.sortOrder,
      'placeholderEn': instance.placeholderEn,
      'placeholderUr': instance.placeholderUr,
      'helpTextEn': instance.helpTextEn,
      'helpTextUr': instance.helpTextUr,
      'validationRegex': instance.validationRegex,
      'optionsJson': instance.optionsJson,
    };
