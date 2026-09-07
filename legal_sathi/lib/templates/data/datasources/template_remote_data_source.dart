import '../models/legal_template_dto.dart';
import '../models/template_category_dto.dart';

/// `GET /Templates`, `/Templates/categories`, `/Templates/{slug}`.
/// Implementations throw `AppException`; the repository maps them.
abstract class TemplateRemoteDataSource {
  /// The server does both the keyword match and the category filter, so a
  /// `categoryId` of `null` means "every category" rather than "filter later".
  Future<List<LegalTemplateDto>> getTemplates({
    int? categoryId,
    String? search,
  });

  Future<List<TemplateCategoryDto>> getCategories();

  /// The slug is the only key the detail endpoint accepts — and the only call
  /// that returns `formFields`.
  Future<LegalTemplateDto> getTemplateBySlug(String slug);
}
