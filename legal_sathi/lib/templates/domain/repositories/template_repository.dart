import '../../../core/errors/result.dart';
import '../entities/legal_template.dart';
import '../entities/template_category.dart';

abstract class TemplateRepository {
  /// Both filters are applied by whoever serves the catalogue, so callers pass
  /// `null` to mean "no filter" rather than narrowing the result themselves.
  Future<Result<List<LegalTemplate>>> getTemplates({
    int? categoryId,
    String? search,
  });

  Future<Result<List<TemplateCategory>>> getCategories();

  /// Returns the template with its questionnaire; the list call does not.
  Future<Result<LegalTemplate>> getTemplateBySlug(String slug);
}
