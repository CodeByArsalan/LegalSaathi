import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';
import 'package:legal_sathi/core/network/api_envelope.dart';
import 'package:legal_sathi/templates/data/datasources/template_remote_data_source_mock.dart';
import 'package:legal_sathi/templates/data/models/legal_template_dto.dart';
import 'package:legal_sathi/templates/data/models/template_category_dto.dart';
import 'package:legal_sathi/templates/data/models/template_field_dto.dart';
import 'package:legal_sathi/templates/data/repositories/template_repository_impl.dart';
import 'package:legal_sathi/templates/domain/entities/field_type.dart';
import 'package:legal_sathi/templates/domain/entities/legal_template.dart';
import 'package:legal_sathi/templates/domain/entities/template_category.dart';
import 'package:legal_sathi/templates/domain/entities/template_field.dart';
import 'package:legal_sathi/templates/domain/entities/template_tier.dart';
import 'package:legal_sathi/templates/domain/repositories/template_repository.dart';

import '../support/fixtures.dart';

/// The catalogue through the domain interface, plus the wire shapes as the live
/// API actually sends them.
///
/// The offline data source and the Dio one share [LegalTemplateDto], so the
/// asset-backed tests below cover the same mapping the network path runs. The
/// fixture group pins that mapping to captured responses rather than to an
/// assumption about them.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TemplateRepository repository;

  setUp(() {
    repository = TemplateRepositoryImpl(TemplateRemoteDataSourceMock());
  });

  Future<List<LegalTemplate>> catalogue({
    int? categoryId,
    String? search,
  }) async {
    final Result<List<LegalTemplate>> result = await repository.getTemplates(
      categoryId: categoryId,
      search: search,
    );
    expect(result, isA<Success<List<LegalTemplate>>>());
    return result.value!;
  }

  group('catalogue', () {
    test(
      'lists every template with the pricing the server puts on it',
      () async {
        final List<LegalTemplate> all = await catalogue();

        expect(all, hasLength(7));
        expect(
          all.map((LegalTemplate template) => template.slug),
          contains('general-affidavit'),
        );

        final LegalTemplate free = all.firstWhere(
          (LegalTemplate template) => template.slug == 'general-affidavit',
        );
        expect(free.tier, TemplateTier.free);
        expect(free.basePrice, 0);
        expect(free.isFree, isTrue);

        final LegalTemplate premium = all.firstWhere(
          (LegalTemplate template) => template.slug == 'employment-contract',
        );
        expect(premium.tier, TemplateTier.premium);
        expect(premium.basePrice, 499);
        expect(premium.isFree, isFalse);
      },
    );

    test('the category filter narrows to that group', () async {
      final List<LegalTemplate> business = await catalogue(categoryId: 3);

      expect(business, hasLength(4));
      expect(
        business.every((LegalTemplate template) => template.categoryId == 3),
        isTrue,
      );
    });

    test('search matches Urdu wording as well as English', () async {
      expect(
        (await catalogue(search: 'affidavit')).single.slug,
        'general-affidavit',
      );
      expect(
        (await catalogue(search: 'کرایہ نامہ')).single.slug,
        'residential-rent-agreement',
      );
    });

    test('no match yields an empty list, not a failure', () async {
      final Result<List<LegalTemplate>> result = await repository.getTemplates(
        search: 'zzz-no-such-document',
      );

      expect(result.isSuccess, isTrue);
      expect(result.value, isEmpty);
    });
  });

  group('detail', () {
    test('carries the questionnaire, the laws and the stamp duty', () async {
      final Result<LegalTemplate> result = await repository.getTemplateBySlug(
        'residential-rent-agreement',
      );
      final LegalTemplate template = result.value!;

      expect(template.title('en'), isNot(template.title('ur')));
      expect(template.fieldCount, 9);
      expect(template.orderedFields.first.sortOrder, 1);

      // The pages are the server's, taken from `stepNumber`.
      expect(template.stepCount, 2);
      expect(template.steps.first, hasLength(5));
      expect(template.steps.last, hasLength(4));
      expect(
        template.steps.first.every(
          (TemplateField field) => field.stepNumber == 1,
        ),
        isTrue,
      );

      expect(template.requiresStampPaper, isTrue);
      expect(template.estimatedStampDuty, greaterThan(0));
      expect(template.laws, isNotEmpty);
      expect(template.contentTemplate('en'), isNotNull);
    });

    test(
      'an unknown slug is the server refusal, not a not-found state',
      () async {
        final Result<LegalTemplate> result = await repository.getTemplateBySlug(
          'not-a-template',
        );

        // The route advertises a 404 but answers 400 with the reason in `errors`,
        // so the message is what the user sees.
        expect(result.failure, isA<ValidationFailure>());
        expect(
          result.failure!.message,
          contains("Template with slug 'not-a-template' not found."),
        );
      },
    );
  });

  group('categories', () {
    test('read the icon name the backend sends', () async {
      final Result<List<TemplateCategory>> result = await repository
          .getCategories();
      final List<TemplateCategory> categories = result.value!;

      expect(categories, hasLength(4));
      expect(categories.first.id, 1);
      expect(categories.first.icon, 'Users');
      expect(categories.first.name('en'), isNot(categories.first.name('ur')));
      expect(
        categories.map((TemplateCategory category) => category.icon),
        containsAll(<String>['Users', 'Home', 'Briefcase', 'Car']),
      );
    });
  });

  group('live payloads', () {
    test('the list is a summary: no fields, no content, no laws', () {
      final List<LegalTemplate> rows = ApiEnvelope.unwrapList<LegalTemplate>(
        fixtureResponse('templates_list', statusCode: 200),
        (Map<String, dynamic> json) =>
            LegalTemplateDto.fromJson(json).toEntity(),
      );

      expect(rows, hasLength(7));
      final LegalTemplate first = rows.first;
      expect(first.id, 1);
      expect(first.slug, 'general-affidavit');
      expect(first.tier, TemplateTier.free);
      expect(first.categoryName('en'), 'Personal & Family');
      expect(first.fields, isEmpty);
      expect(first.contentTemplate('en'), isNull);
      expect(first.laws, isEmpty);
    });

    test('the detail adds the questionnaire and the statutes', () {
      final LegalTemplate template = ApiEnvelope.unwrapObject<LegalTemplate>(
        fixtureResponse('template_detail', statusCode: 200),
        (Map<String, dynamic> json) =>
            LegalTemplateDto.fromJson(json).toEntity(),
      );

      expect(template.id, 1);
      expect(template.laws, <String>[
        'Oaths Act 1873',
        'High Court Rules & Orders',
      ]);
      expect(template.requiresStampPaper, isTrue);
      expect(template.estimatedStampDuty, 100);
      expect(template.fieldCount, 5);
      expect(template.stepCount, 2);

      final TemplateField cnic = template.fields.firstWhere(
        (TemplateField field) => field.fieldKey == 'Cnic',
      );
      expect(cnic.fieldType, FieldType.cnic);
      expect(cnic.isRequired, isTrue);
      expect(cnic.validationRegex, '^[0-9]{5}-[0-9]{7}-[0-9]\$');
      expect(cnic.placeholder('en'), '35201-1234567-1');
      expect(cnic.help('ur'), isNotNull);

      final TemplateField statement = template.fields.firstWhere(
        (TemplateField field) => field.fieldKey == 'AffidavitStatement',
      );
      expect(statement.fieldType, FieldType.textarea);
      expect(statement.fieldType.acceptsMultiline, isTrue);
      expect(statement.stepNumber, 2);
    });

    test('categories arrive as PascalCase icons with a template count', () {
      final List<TemplateCategory> rows =
          ApiEnvelope.unwrapList<TemplateCategory>(
            fixtureResponse('templates_categories', statusCode: 200),
            (Map<String, dynamic> json) =>
                TemplateCategoryDto.fromJson(json).toEntity(),
          );

      expect(rows, hasLength(4));
      expect(rows.first.templateCount, greaterThan(0));
      expect(rows.map((TemplateCategory category) => category.icon), <String>[
        'Users',
        'Home',
        'Briefcase',
        'Car',
      ]);
    });

    test('a whole rupee amount written without a decimal still reads', () {
      // `basePrice` is a JSON number the server may write as `300`, and
      // `as double` throws on an int.
      final LegalTemplateDto dto = LegalTemplateDto.fromJson(<String, dynamic>{
        'templateId': 9,
        'slug': 'whole-amounts',
        'categoryId': 1,
        'titleEn': 'Whole amounts',
        'titleUr': 'مکمل رقم',
        'requiresStampPaper': false,
        'basePrice': 300,
        'estimatedStampDuty': 50,
      });

      expect(dto.basePrice, 300);
      expect(dto.estimatedStampDuty, 50);
      // A tier the server never sent falls back to the paid band.
      expect(dto.toEntity().tier, TemplateTier.standard);
    });
  });

  group('enum parsing', () {
    test('field types arrive in PascalCase and Select means dropdown', () {
      expect(FieldType.parse('Text'), FieldType.text);
      expect(FieldType.parse('TextArea'), FieldType.textarea);
      expect(FieldType.parse('Cnic'), FieldType.cnic);
      expect(FieldType.parse('CurrencyPkr'), FieldType.currencyPkr);
      expect(FieldType.parse('Select'), FieldType.dropdown);
      expect(FieldType.parse(' select '), FieldType.dropdown);
    });

    test('an unrecognised field type still renders as text', () {
      expect(FieldType.parse('Signature'), FieldType.text);
      expect(FieldType.parse(null), FieldType.text);
    });

    test('only the choice fields are options based', () {
      expect(FieldType.dropdown.isOptionsBased, isTrue);
      expect(FieldType.radio.isOptionsBased, isTrue);
      expect(FieldType.checkbox.isOptionsBased, isTrue);
      expect(FieldType.checkbox.isMultiSelect, isTrue);
      expect(FieldType.radio.isMultiSelect, isFalse);
      expect(FieldType.text.isOptionsBased, isFalse);
      expect(FieldType.address.acceptsMultiline, isTrue);
      expect(FieldType.textarea.acceptsMultiline, isTrue);
      expect(FieldType.email.acceptsMultiline, isFalse);
    });

    test('tiers parse case-insensitively and default to standard', () {
      expect(TemplateTier.parse('Free'), TemplateTier.free);
      expect(TemplateTier.parse('premium'), TemplateTier.premium);
      expect(TemplateTier.parse('Corporate'), TemplateTier.corporate);
      expect(TemplateTier.parse('Bogus'), TemplateTier.standard);
      expect(TemplateTier.free.l10nKey, 'templates.tier_free');
    });
  });

  group('field answers', () {
    TemplateField field({
      bool isRequired = true,
      String? validationRegex,
      FieldType fieldType = FieldType.text,
    }) => TemplateField(
      id: 1,
      fieldKey: 'Cnic',
      fieldType: fieldType,
      labelEn: 'CNIC Number',
      labelUr: 'قومی شناختی کارڈ نمبر',
      isRequired: isRequired,
      stepNumber: 1,
      sortOrder: 1,
      validationRegex: validationRegex,
    );

    test('a required field left blank is the only complaint', () {
      expect(field().errorKeyFor(''), 'validation.required');
      expect(field().errorKeyFor('   '), 'validation.required');
      expect(field(isRequired: false).errorKeyFor(''), isNull);
    });

    test('the server pattern is applied when it sends one', () {
      final TemplateField cnic = field(
        fieldType: FieldType.cnic,
        validationRegex: '^[0-9]{5}-[0-9]{7}-[0-9]\$',
      );

      expect(cnic.errorKeyFor('35201-1234567-1'), isNull);
      expect(cnic.errorKeyFor('3520112345671'), 'validation.invalid_format');
      // Surrounding space is not a reason to reject an answer.
      expect(cnic.errorKeyFor('  35201-1234567-1 '), isNull);
    });

    test('a pattern that will not compile is ignored, not fatal', () {
      expect(field(validationRegex: '^[0-9').errorKeyFor('anything'), isNull);
    });

    test('options are read out of the pass-through column', () {
      expect(parseOptions(null), isEmpty);
      expect(parseOptions('["Male","Female"]'), <String>['Male', 'Female']);
      expect(parseOptions('[{"labelEn":"Yes"},{"labelEn":"No"}]'), <String>[
        'Yes',
        'No',
      ]);
      expect(parseOptions('Yes, No'), <String>['Yes', 'No']);
      expect(parseOptions('not json at all'), <String>['not json at all']);
    });
  });
}
