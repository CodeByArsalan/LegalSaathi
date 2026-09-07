import '../../../core/errors/result.dart';
import '../entities/template_category.dart';
import '../repositories/template_repository.dart';

class GetTemplateCategoriesUseCase {
  const GetTemplateCategoriesUseCase(this._repository);

  final TemplateRepository _repository;

  Future<Result<List<TemplateCategory>>> call() => _repository.getCategories();
}
