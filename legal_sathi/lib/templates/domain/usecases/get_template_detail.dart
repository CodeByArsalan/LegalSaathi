import '../../../core/errors/result.dart';
import '../entities/legal_template.dart';
import '../repositories/template_repository.dart';

/// Keyed by slug: that is the only identifier the detail endpoint accepts, and
/// the only call that returns the questionnaire.
class GetTemplateDetailUseCase {
  const GetTemplateDetailUseCase(this._repository);

  final TemplateRepository _repository;

  Future<Result<LegalTemplate>> call(String slug) =>
      _repository.getTemplateBySlug(slug);
}
