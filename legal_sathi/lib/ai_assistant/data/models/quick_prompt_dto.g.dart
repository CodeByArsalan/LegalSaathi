// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_prompt_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuickPromptDto _$QuickPromptDtoFromJson(Map<String, dynamic> json) =>
    _QuickPromptDto(
      id: json['id'] as String,
      titleEng: json['titleEng'] as String? ?? '',
      titleUrdu: json['titleUrdu'] as String? ?? '',
      promptEng: json['promptEng'] as String? ?? '',
      promptUrdu: json['promptUrdu'] as String? ?? '',
      category: json['category'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );

Map<String, dynamic> _$QuickPromptDtoToJson(_QuickPromptDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleEng': instance.titleEng,
      'titleUrdu': instance.titleUrdu,
      'promptEng': instance.promptEng,
      'promptUrdu': instance.promptUrdu,
      'category': instance.category,
      'icon': instance.icon,
    };
