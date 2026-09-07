import '../../../core/constants/asset_paths.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/mock/mock_data_source.dart';
import '../models/legal_template_dto.dart';
import '../models/template_category_dto.dart';
import 'template_remote_data_source.dart';

/// Offline/demo mode. The bundled catalogue is a capture of the real one —
/// seven templates with their bilingual content and questionnaires — so the
/// screens show the same thing whether or not there is a network.
///
/// Filtering is done here because the server normally does it; the keyword match
/// covers Urdu as well as English so a search behaves the same in both modes.
class TemplateRemoteDataSourceMock extends MockDataSource
    implements TemplateRemoteDataSource {
  @override
  Future<List<LegalTemplateDto>> getTemplates({
    int? categoryId,
    String? search,
  }) async {
    final List<LegalTemplateDto> all = await _loadTemplates();
    final String needle = search?.trim().toLowerCase() ?? '';

    final List<LegalTemplateDto> matches = all
        .where((LegalTemplateDto template) {
          if (categoryId != null && template.categoryId != categoryId) {
            return false;
          }
          if (needle.isEmpty) return true;
          return <String>[
            template.titleEn,
            template.titleUr,
            template.descriptionEn,
            template.descriptionUr,
          ].any((String value) => value.toLowerCase().contains(needle));
        })
        .toList(growable: false);

    return withLatency(matches);
  }

  @override
  Future<List<TemplateCategoryDto>> getCategories() async {
    final List<TemplateCategoryDto> rows = (await loadRows(
      AssetPaths.mockCategories,
    )).map(TemplateCategoryDto.fromJson).toList(growable: false);
    return withLatency(rows);
  }

  @override
  Future<LegalTemplateDto> getTemplateBySlug(String slug) async {
    for (final LegalTemplateDto template in await _loadTemplates()) {
      if (template.slug == slug) return withLatency(template);
    }
    // Deliberately the server's own answer to an unknown slug: HTTP 400 with the
    // message in `errors`, not a 404. Mock mode should fail the same way.
    throw AppException(
      "Template with slug '$slug' not found.",
      kind: AppExceptionKind.validation,
      statusCode: 400,
    );
  }

  Future<List<LegalTemplateDto>> _loadTemplates() async {
    final List<LegalTemplateDto> rows = (await loadRows(
      AssetPaths.mockTemplates,
    )).map(LegalTemplateDto.fromJson).toList(growable: false);
    return rows;
  }
}
