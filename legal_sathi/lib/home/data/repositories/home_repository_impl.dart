import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../../documents/domain/entities/legal_document.dart';
import '../../../documents/domain/repositories/document_repository.dart';
import '../../../templates/domain/entities/legal_template.dart';
import '../../../templates/domain/repositories/template_repository.dart';
import '../../domain/entities/home_feed.dart';
import '../../domain/repositories/home_repository.dart';

/// Composes the template and document repositories into one dashboard read.
///
/// There is no home data source yet because the backend has no `/home`
/// endpoint: when one appears, this class forwards to it instead of fanning
/// out, and nothing above the repository changes.
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required TemplateRepository templates,
    required DocumentRepository documents,
  }) : _templates = templates,
       _documents = documents;

  final TemplateRepository _templates;
  final DocumentRepository _documents;

  static const int _featuredCount = 5;
  static const int _recentCount = 3;

  @override
  Future<Result<HomeFeed>> getHomeFeed() async {
    final categoriesRequest = _templates.getCategories();
    final templatesRequest = _templates.getTemplates();
    final documentsRequest = _documents.getUserDocuments();

    final categories = await categoriesRequest;
    final templates = await templatesRequest;
    final documents = await documentsRequest;

    final Failure? failure =
        templates.failure ?? categories.failure ?? documents.failure;
    if (failure != null && (templates.value?.isEmpty ?? true)) {
      return FailureResult<HomeFeed>(failure);
    }

    // No ranking signal survives in the payload — the API returns neither a
    // popularity score nor a created date — so "featured" is simply the
    // catalogue's own order, truncated.
    final List<LegalTemplate> featured = <LegalTemplate>[...?templates.value];
    final List<LegalDocument> all = <LegalDocument>[...?documents.value]
      ..sort(
        (LegalDocument a, LegalDocument b) =>
            b.createdAt.compareTo(a.createdAt),
      );

    return Success<HomeFeed>(
      HomeFeed(
        featuredTemplates: featured
            .take(_featuredCount)
            .toList(growable: false),
        categories: categories.value ?? const <Never>[],
        recentDocuments: all.take(_recentCount).toList(growable: false),
        completedCount: all
            .where((LegalDocument doc) => doc.status.isGenerated)
            .length,
      ),
    );
  }
}
