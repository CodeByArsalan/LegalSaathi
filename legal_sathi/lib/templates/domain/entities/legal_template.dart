import 'package:freezed_annotation/freezed_annotation.dart';

import 'template_field.dart';
import 'template_tier.dart';

part 'legal_template.freezed.dart';

/// A document template and, once fetched in full, the questions it asks.
///
/// One shape serves both endpoints because the server's list payload is a
/// summary of its detail payload: `GET /Templates` returns the bilingual title,
/// description, category name, price and stamp duty but no fields, while
/// `GET /Templates/{slug}` drops the category name and adds the content, the
/// applicable laws and `formFields`. The members neither endpoint always sends
/// are therefore nullable, and the detail-only ones stay null on a list row.
@freezed
abstract class LegalTemplate with _$LegalTemplate {
  const factory LegalTemplate({
    required int id,

    /// The only key the detail endpoint accepts.
    required String slug,
    required int categoryId,
    required String titleEn,
    required String titleUr,
    required String descriptionEn,
    required String descriptionUr,
    required double basePrice,
    required TemplateTier tier,
    required bool requiresStampPaper,
    required double estimatedStampDuty,
    String? categoryNameEn,
    String? categoryNameUr,
    String? contentTemplateEn,
    String? contentTemplateUr,

    /// A comma-separated list of statutes, exactly as the server stores it.
    String? applicableLaws,
    @Default(<TemplateField>[]) List<TemplateField> fields,
  }) = _LegalTemplate;
}

extension LegalTemplateX on LegalTemplate {
  String title(String languageCode) => languageCode == 'ur' ? titleUr : titleEn;

  String description(String languageCode) =>
      languageCode == 'ur' ? descriptionUr : descriptionEn;

  String? categoryName(String languageCode) =>
      languageCode == 'ur' ? categoryNameUr : categoryNameEn;

  String? contentTemplate(String languageCode) =>
      languageCode == 'ur' ? contentTemplateUr : contentTemplateEn;

  /// There is no separate free flag on the wire: a template is free when its
  /// tier says so or when it carries no price.
  bool get isFree => tier == TemplateTier.free || basePrice <= 0;

  /// The statutes this wording relies on, split out of the server's
  /// comma-separated string. Empty until the detail payload has been read.
  List<String> get laws => (applicableLaws ?? '')
      .split(',')
      .map((String law) => law.trim())
      .where((String law) => law.isNotEmpty)
      .toList(growable: false);

  /// Ordered as the builder will ask them: server-chosen page first, then the
  /// position within that page.
  List<TemplateField> get orderedFields =>
      List<TemplateField>.from(fields)
        ..sort((TemplateField a, TemplateField b) {
          final int byStep = a.stepNumber.compareTo(b.stepNumber);
          return byStep != 0 ? byStep : a.sortOrder.compareTo(b.sortOrder);
        });

  /// The wizard's pages, taken from `stepNumber` rather than chunked by count.
  /// A template whose fields all claim step 1 yields a single page.
  List<List<TemplateField>> get steps {
    final Map<int, List<TemplateField>> grouped = <int, List<TemplateField>>{};
    for (final TemplateField field in orderedFields) {
      grouped.putIfAbsent(field.stepNumber, () => <TemplateField>[]).add(field);
    }
    final List<int> numbers = grouped.keys.toList()..sort();
    return numbers
        .map((int number) => grouped[number]!)
        .toList(growable: false);
  }

  int get fieldCount => fields.length;

  int get stepCount => steps.length;
}
