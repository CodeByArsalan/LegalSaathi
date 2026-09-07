/// The languages `POST /Documents/{id}/generate` accepts for the rendered file.
enum DocumentLanguage {
  english('en'),
  urdu('ur'),

  /// Both columns of the template's stored wording, which is the API's own
  /// default and what the seeded templates are written for.
  bilingual('bilingual');

  const DocumentLanguage(this.code);

  /// The wire value.
  final String code;
}
