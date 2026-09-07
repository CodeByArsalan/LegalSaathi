import 'package:freezed_annotation/freezed_annotation.dart';

import 'field_type.dart';

part 'template_field.freezed.dart';

/// One guided question in the document builder.
///
/// The server groups questions into wizard pages itself via [stepNumber], so
/// the app never chunks them by count.
@freezed
abstract class TemplateField with _$TemplateField {
  const factory TemplateField({
    required int id,
    required String fieldKey,
    required FieldType fieldType,
    required String labelEn,
    required String labelUr,
    required bool isRequired,
    required int stepNumber,
    required int sortOrder,
    @Default(<String>[]) List<String> options,
    String? placeholderEn,
    String? placeholderUr,
    String? helpTextEn,
    String? helpTextUr,

    /// A server-supplied pattern the answer must match, in addition to whatever
    /// the field type implies. Null for most fields.
    String? validationRegex,
  }) = _TemplateField;
}

/// Bilingual accessors. Language is passed in rather than read from a build
/// context, which keeps the domain layer framework-free.
extension TemplateFieldX on TemplateField {
  String label(String languageCode) => languageCode == 'ur' ? labelUr : labelEn;

  String? placeholder(String languageCode) =>
      languageCode == 'ur' ? placeholderUr : placeholderEn;

  String? help(String languageCode) =>
      languageCode == 'ur' ? helpTextUr : helpTextEn;

  /// The key for the reason this answer is unacceptable, or null when it is.
  ///
  /// One rule serves both the cubit, which decides whether a step may advance,
  /// and the field widget, which shows the reason under the input — so the two
  /// cannot drift apart. A `validationRegex` that will not compile is ignored
  /// rather than treated as a failure: a broken pattern on the server should not
  /// make the field unanswerable.
  String? errorKeyFor(String value) {
    final String trimmed = value.trim();
    if (trimmed.isEmpty) return isRequired ? 'validation.required' : null;

    final String? pattern = validationRegex;
    if (pattern == null || pattern.isEmpty) return null;
    final RegExp? regex = _compile(pattern);
    if (regex == null || regex.hasMatch(trimmed)) return null;
    return 'validation.invalid_format';
  }
}

RegExp? _compile(String pattern) {
  try {
    return RegExp(pattern);
  } on FormatException {
    return null;
  }
}
