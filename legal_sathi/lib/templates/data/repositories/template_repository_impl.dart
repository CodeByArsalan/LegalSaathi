import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../domain/entities/legal_template.dart';
import '../../domain/entities/template_category.dart';
import '../../domain/repositories/template_repository.dart';
import '../datasources/template_remote_data_source.dart';
import '../models/legal_template_dto.dart';
import '../models/template_category_dto.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  TemplateRepositoryImpl(this._remote);

  final TemplateRemoteDataSource _remote;

  @override
  Future<Result<List<LegalTemplate>>> getTemplates({
    int? categoryId,
    String? search,
  }) async {
    try {
      final List<LegalTemplateDto> rows = await _remote.getTemplates(
        categoryId: categoryId,
        search: search,
      );
      return Success<List<LegalTemplate>>(
        rows
            .map((LegalTemplateDto dto) => dto.toEntity())
            .toList(growable: false),
      );
    } on Object catch (error) {
      return FailureResult<List<LegalTemplate>>(Failure.from(error));
    }
  }

  @override
  Future<Result<List<TemplateCategory>>> getCategories() async {
    try {
      final List<TemplateCategoryDto> rows = await _remote.getCategories();
      return Success<List<TemplateCategory>>(
        rows
            .map((TemplateCategoryDto dto) => dto.toEntity())
            .toList(growable: false),
      );
    } on Object catch (error) {
      return FailureResult<List<TemplateCategory>>(Failure.from(error));
    }
  }

  @override
  Future<Result<LegalTemplate>> getTemplateBySlug(String slug) async {
    try {
      return Success<LegalTemplate>(
        (await _remote.getTemplateBySlug(slug)).toEntity(),
      );
    } on Object catch (error) {
      return FailureResult<LegalTemplate>(Failure.from(error));
    }
  }
}
