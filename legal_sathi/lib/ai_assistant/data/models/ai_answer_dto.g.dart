// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_answer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiAnswerDto _$AiAnswerDtoFromJson(Map<String, dynamic> json) => _AiAnswerDto(
  answer: json['answer'] as String? ?? '',
  totalTokens: (json['totalTokens'] as num?)?.toInt() ?? 0,
  model: json['model'] as String? ?? '',
  queryId: (json['queryId'] as num?)?.toInt(),
);

Map<String, dynamic> _$AiAnswerDtoToJson(_AiAnswerDto instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'totalTokens': instance.totalTokens,
      'model': instance.model,
      'queryId': instance.queryId,
    };
