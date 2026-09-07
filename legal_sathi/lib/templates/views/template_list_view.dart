import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/buttons/ghost_button.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/state_view.dart';
import '../cubit/template_list_cubit.dart';
import '../cubit/template_list_state.dart';
import '../domain/entities/legal_template.dart';
import '../widgets/category_chip_row.dart';
import '../widgets/template_card.dart';
import '../widgets/template_filter_bar.dart';

class TemplateListView extends StatefulWidget {
  const TemplateListView({this.initialCategoryId, super.key});

  /// Set from the `?category=` query parameter.
  final int? initialCategoryId;

  @override
  State<TemplateListView> createState() => _TemplateListViewState();
}

class _TemplateListViewState extends State<TemplateListView> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _load();
    });
  }

  @override
  void didUpdateWidget(TemplateListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The shell keeps this State alive when only the query parameter changes.
    if (oldWidget.initialCategoryId != widget.initialCategoryId) _load();
  }

  void _load() {
    if (widget.initialCategoryId != null) {
      _search.clear();
      context.read<TemplateListCubit>().search('');
    }
    context.read<TemplateListCubit>().load(
      categoryId: widget.initialCategoryId,
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TemplateListCubit cubit = context.read<TemplateListCubit>();

    return AppScaffold(
      title: tr('templates.title'),
      showBackButton: false,
      body: BlocBuilder<TemplateListCubit, TemplateListState>(
        builder: (BuildContext context, TemplateListState state) {
          // Nothing is filtered here: the API narrows by search text and
          // category, so what it returned is what is on screen.
          final List<LegalTemplate> templates = state.templates;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    context.gutter,
                    AppSpacing.sm,
                    context.gutter,
                    0,
                  ),
                  child: TemplateFilterBar(
                    controller: _search,
                    onChanged: cubit.search,
                    resultCount: templates.length,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.gutter),
                  child: CategoryChipRow(
                    categories: state.categories,
                    selectedCategoryId: state.selectedCategoryId,
                    onSelected: cubit.selectCategory,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: StateView(
                    state: state.viewState,
                    failure: state.failure,
                    onRetry: () => cubit.load(),
                    emptyTitle: tr('templates.no_results'),
                    emptyAction: state.isFiltered
                        ? GhostButton(
                            label: tr('common.clear'),
                            icon: Icons.filter_alt_off_rounded,
                            onPressed: () {
                              _search.clear();
                              cubit.clearFilters();
                            },
                          )
                        : null,
                    builder: (BuildContext context) => RefreshIndicator(
                      onRefresh: () => cubit.load(),
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          context.gutter,
                          0,
                          context.gutter,
                          AppSpacing.xxxl,
                        ),
                        itemCount: templates.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.md),
                        itemBuilder: (BuildContext context, int index) {
                          final LegalTemplate template = templates[index];
                          return TemplateCard(
                            template: template,
                            onTap: () => context.push(
                              RoutePaths.templateDetail(template.slug),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
