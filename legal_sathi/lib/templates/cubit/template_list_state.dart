import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../../../core/widgets/state_view.dart';
import '../domain/entities/legal_template.dart';
import '../domain/entities/template_category.dart';

part 'template_list_state.freezed.dart';

/// Composable list state: filters can change independently of the load phase,
/// so this uses one immutable object instead of a union.
@freezed
abstract class TemplateListState with _$TemplateListState {
  const factory TemplateListState({
    @Default(true) bool isLoading,
    @Default(<TemplateCategory>[]) List<TemplateCategory> categories,

    /// Already narrowed by [selectedCategoryId] and [query]: whoever serves the
    /// catalogue does the filtering, so there is nothing left to hide locally.
    @Default(<LegalTemplate>[]) List<LegalTemplate> templates,
    int? selectedCategoryId,
    @Default('') String query,
    Failure? failure,
  }) = _TemplateListState;
}

extension TemplateListStateX on TemplateListState {
  ViewState get viewState {
    if (isLoading && templates.isEmpty) return ViewState.loading;
    if (failure != null && templates.isEmpty) return ViewState.failure;
    if (!isLoading && templates.isEmpty) return ViewState.empty;
    return ViewState.ready;
  }

  bool get isFiltered => selectedCategoryId != null || query.trim().isNotEmpty;
}
