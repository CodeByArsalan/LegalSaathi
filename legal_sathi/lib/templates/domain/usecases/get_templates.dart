import '../../../core/errors/result.dart';
import '../entities/legal_template.dart';
import '../repositories/template_repository.dart';

/// Category and search filters are optional so the list screen and the
/// home feed share one usecase.
class GetTemplatesUseCase {
  const GetTemplatesUseCase(this._repository);

  final TemplateRepository _repository;

  Future<Result<List<LegalTemplate>>> call({int? categoryId, String? search}) =>
      _repository.getTemplates(categoryId: categoryId, search: search);
}
