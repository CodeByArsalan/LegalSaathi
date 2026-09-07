import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/layout/max_width_body.dart';
import '../../../core/widgets/layout/section_header.dart';
import '../../../core/widgets/state_view.dart';
import '../../../documents/domain/entities/legal_document.dart';
import '../../../templates/domain/entities/legal_template.dart';
import '../../../templates/domain/entities/template_category.dart';
import '../../../templates/widgets/template_card.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../domain/entities/home_feed.dart';
import '../widgets/category_grid.dart';
import '../widgets/greeting_header.dart';
import '../widgets/quick_action_row.dart';
import '../widgets/recent_document_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<HomeCubit>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit auth = context.read<AuthCubit>();
    final HomeCubit cubit = context.read<HomeCubit>();

    return AppScaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return SafeArea(
            child: StateView(
              state: state.viewState,
              failure: state.failure,
              onRetry: cubit.load,
              builder: (BuildContext context) {
                final HomeFeed feed = state.feed!;
                return RefreshIndicator(
                  onRefresh: cubit.load,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: context.gutter),
                    children: <Widget>[
                      MaxWidthBody(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            GreetingHeader(
                              name: auth.currentUser?.fullName ?? '',
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            QuickActionRow(
                              onAskAssistant: () =>
                                  context.push(RoutePaths.aiAssistant),
                              onStartDocument: () =>
                                  context.go(RoutePaths.templates),
                            ),
                            SectionHeader(title: tr('home.categories')),
                            CategoryGrid(
                              categories: feed.categories,
                              onSelected: (TemplateCategory category) =>
                                  context.go(
                                    RoutePaths.templatesByCategory(category.id),
                                  ),
                            ),
                            SectionHeader(
                              title: tr('home.featured'),
                              actionLabel: tr('common.see_all'),
                              onAction: () => context.go(RoutePaths.templates),
                            ),
                            for (final LegalTemplate template
                                in feed.featuredTemplates)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.md,
                                ),
                                child: TemplateCard(
                                  template: template,
                                  onTap: () => context.push(
                                    RoutePaths.templateDetail(template.slug),
                                  ),
                                ),
                              ),
                            if (feed.recentDocuments.isNotEmpty) ...<Widget>[
                              SectionHeader(
                                title: tr('home.recent'),
                                actionLabel: tr('common.see_all'),
                                onAction: () =>
                                    context.go(RoutePaths.documents),
                              ),
                              for (final LegalDocument document
                                  in feed.recentDocuments)
                                RecentDocumentTile(
                                  document: document,
                                  onTap: () => context.push(
                                    RoutePaths.preview(document.id),
                                  ),
                                ),
                            ],
                            const SizedBox(height: AppSpacing.xxxl),
                            _FeedSummary(count: feed.completedCount),
                            const SizedBox(height: AppSpacing.lg),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Small footer stat so the dashboard reflects real account activity.
class _FeedSummary extends StatelessWidget {
  const _FeedSummary({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox.shrink();
    return Center(
      child: Text(
        '${tr('profile.paid_count')}: $count',
        style: context.textTheme.labelSmall?.copyWith(
          color: AppColors.textLight,
        ),
      ),
    );
  }
}
