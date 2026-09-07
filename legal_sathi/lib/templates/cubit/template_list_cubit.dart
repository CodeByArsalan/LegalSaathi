import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/result.dart';
import '../domain/entities/legal_template.dart';
import '../domain/entities/template_category.dart';
import '../domain/usecases/get_template_categories.dart';
import '../domain/usecases/get_templates.dart';
import 'template_list_state.dart';

class TemplateListCubit extends Cubit<TemplateListState> {
  TemplateListCubit({
    required GetTemplatesUseCase getTemplates,
    required GetTemplateCategoriesUseCase getCategories,
  }) : _getTemplates = getTemplates,
       _getCategories = getCategories,
       super(const TemplateListState());

  final GetTemplatesUseCase _getTemplates;
  final GetTemplateCategoriesUseCase _getCategories;

  Timer? _debounce;

  /// Bumped per request so a slow reply to an abandoned filter is dropped
  /// instead of overwriting the results of a newer one.
  int _issued = 0;

  /// Loads categories and templates together. [categoryId] seeds the filter from
  /// the `?category=` route parameter.
  Future<void> load({int? categoryId}) async {
    if (categoryId != null && categoryId != state.selectedCategoryId) {
      emit(state.copyWith(selectedCategoryId: categoryId));
    }
    emit(state.copyWith(isLoading: true, failure: null));

    final int issued = ++_issued;
    final Future<Result<List<TemplateCategory>>> categoriesRequest =
        _getCategories();
    final Future<Result<List<LegalTemplate>>> templatesRequest = _query();

    final Result<List<TemplateCategory>> categories = await categoriesRequest;
    final Result<List<LegalTemplate>> templates = await templatesRequest;
    if (isClosed || issued != _issued) return;

    emit(
      state.copyWith(
        isLoading: false,
        categories: categories.value ?? state.categories,
        templates: templates.value ?? const <LegalTemplate>[],
        failure: templates.failure ?? categories.failure,
      ),
    );
  }

  void selectCategory(int? categoryId) {
    if (state.selectedCategoryId == categoryId) return;
    emit(state.copyWith(selectedCategoryId: categoryId));
    unawaited(_reload());
  }

  void search(String query) {
    if (state.query == query) return;
    emit(state.copyWith(query: query));
    _debounce?.cancel();
    _debounce = Timer(AppConstants.searchDebounce, () => unawaited(_reload()));
  }

  void clearFilters() {
    if (!state.isFiltered) return;
    emit(state.copyWith(selectedCategoryId: null, query: ''));
    unawaited(_reload());
  }

  Future<void> retry() => load();

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  /// Refetches templates only — the categories do not change with a filter.
  Future<void> _reload() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final int issued = ++_issued;
    final Result<List<LegalTemplate>> templates = await _query();
    if (isClosed || issued != _issued) return;

    emit(
      state.copyWith(
        isLoading: false,
        templates: templates.value ?? const <LegalTemplate>[],
        failure: templates.failure,
      ),
    );
  }

  Future<Result<List<LegalTemplate>>> _query() =>
      _getTemplates(categoryId: state.selectedCategoryId, search: state.query);
}
