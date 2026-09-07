import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/field_type.dart';
import '../../domain/entities/template_field.dart';

part 'template_field_dto.freezed.dart';
part 'template_field_dto.g.dart';

/// Wire shape of `FormFieldDto`. Names match the JSON exactly; the entity is
/// where `fieldId` becomes `id` and `optionsJson` becomes a list.
@freezed
abstract class TemplateFieldDto with _$TemplateFieldDto {
  const factory TemplateFieldDto({
    required int fieldId,
    required String fieldKey,
    required String fieldType,
    required String labelEn,
    required String labelUr,
    required bool isRequired,
    required int stepNumber,
    required int sortOrder,
    @Default('') String placeholderEn,
    @Default('') String placeholderUr,
    @Default('') String helpTextEn,
    @Default('') String helpTextUr,
    String? validationRegex,
    String? optionsJson,
  }) = _TemplateFieldDto;

  factory TemplateFieldDto.fromJson(Map<String, dynamic> json) =>
      _$TemplateFieldDtoFromJson(json);
}

extension TemplateFieldDtoMapper on TemplateFieldDto {
  TemplateField toEntity() => TemplateField(
    id: fieldId,
    fieldKey: fieldKey,
    fieldType: FieldType.parse(fieldType),
    labelEn: labelEn,
    labelUr: labelUr,
    isRequired: isRequired,
    stepNumber: stepNumber,
    sortOrder: sortOrder,
    options: parseOptions(optionsJson),
    placeholderEn: placeholderEn.isEmpty ? null : placeholderEn,
    placeholderUr: placeholderUr.isEmpty ? null : placeholderUr,
    helpTextEn: helpTextEn.isEmpty ? null : helpTextEn,
    helpTextUr: helpTextUr.isEmpty ? null : helpTextUr,
    validationRegex: validationRegex,
  );
}

/// `optionsJson` is a pass-through column: the API neither writes nor reads it,
/// and every field in the seeded catalogue leaves it null. Accept the shapes a
/// choice list could plausibly be stored as — a JSON array of strings, a JSON
/// array of labelled objects, or a bare comma-separated list — and yield nothing
/// rather than crash the builder on a shape nobody anticipated.
List<String> parseOptions(String? raw) {
  final String trimmed = raw?.trim() ?? '';
  if (trimmed.isEmpty) return const <String>[];

  try {
    final Object? decoded = jsonDecode(trimmed);
    if (decoded is List) {
      return decoded
          .map(_labelOf)
          .where((String option) => option.isNotEmpty)
          .toList(growable: false);
    }
  } on FormatException catch (_) {
    // Not JSON, so read it as a plain comma-separated list below.
  }

  return trimmed
      .split(',')
      .map((String option) => option.trim())
      .where((String option) => option.isNotEmpty)
      .toList(growable: false);
}

String _labelOf(Object? item) => switch (item) {
  final String value => value,
  final Map<String, dynamic> map =>
    (map['labelEn'] ?? map['label'] ?? map['value'] ?? map['en'] ?? '')
        .toString(),
  _ => item?.toString() ?? '',
};
