import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/failure.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/feedback/error_view.dart';
import '../../../core/widgets/feedback/loading_overlay.dart';
import '../../../core/widgets/layout/app_card.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/layout/max_width_body.dart';
import '../../../core/widgets/layout/section_header.dart';
import '../cubit/template_detail_cubit.dart';
import '../cubit/template_detail_state.dart';
import '../domain/entities/legal_template.dart';
import '../domain/entities/template_field.dart';
import '../widgets/field_preview_tile.dart';
import '../widgets/price_tag.dart';
import '../widgets/template_meta_row.dart';

/// What a template covers, what it costs, which statutes it rests on, and
/// which questions the builder will ask.
class TemplateDetailView extends StatefulWidget {
  const TemplateDetailView({required this.slug, super.key});

  /// The detail endpoint is keyed by slug; the numeric id in its reply is not
  /// accepted as a lookup.
  final String slug;

  @override
  State<TemplateDetailView> createState() => _TemplateDetailViewState();
}

class _TemplateDetailViewState extends State<TemplateDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<TemplateDetailCubit>().load(widget.slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDetailCubit, TemplateDetailState>(
      builder: (BuildContext context, TemplateDetailState state) {
        return state.when(
          loading: () => AppScaffold(
            title: tr('templates.title'),
            body: const LoadingView(),
          ),
          failure: (Failure failure) => AppScaffold(
            title: tr('templates.title'),
            body: ErrorView(
              failure: failure,
              onRetry: () =>
                  context.read<TemplateDetailCubit>().load(widget.slug),
            ),
          ),
          ready: (LegalTemplate template) => _DetailBody(template: template),
        );
      },
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.template});

  final LegalTemplate template;

  @override
  Widget build(BuildContext context) {
    final String languageCode = context.locale.languageCode;
    final List<TemplateField> fields = template.orderedFields;

    return AppScaffold(
      title: template.title(languageCode),
      bottomBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            context.gutter,
            AppSpacing.md,
            context.gutter,
            AppSpacing.md,
          ),
          child: PrimaryButton(
            label: tr('templates.start_building'),
            icon: Icons.edit_note_rounded,
            onPressed: () =>
                context.push(RoutePaths.documentBuilder(template.slug)),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.gutter),
        children: <Widget>[
          MaxWidthBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: AppSpacing.md),
                Text(
                  template.description(languageCode),
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                TemplateMetaRow(template: template),
                const SizedBox(height: AppSpacing.lg),
                _InfoCard(template: template),
                if (template.requiresStampPaper) ...<Widget>[
                  const SizedBox(height: AppSpacing.md),
                  _StampDutyNotice(duty: template.estimatedStampDuty),
                ],
                if (template.laws.isNotEmpty) ...<Widget>[
                  SectionHeader(title: tr('templates.applicable_laws')),
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: Column(
                      children: <Widget>[
                        for (final String law in template.laws)
                          _LawRow(law: law),
                      ],
                    ),
                  ),
                ],
                if (fields.isNotEmpty) ...<Widget>[
                  SectionHeader(title: tr('templates.what_you_need')),
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: Column(
                      children: <Widget>[
                        for (int index = 0; index < fields.length; index++)
                          FieldPreviewTile(
                            field: fields[index],
                            position: index + 1,
                            languageCode: languageCode,
                          ),
                      ],
                    ),
                  ),
                ],
                if (template.contentTemplate(languageCode) != null) ...<Widget>[
                  SectionHeader(title: tr('templates.content_preview')),
                  _ContentCard(text: template.contentTemplate(languageCode)!),
                ],
                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.template});

  final LegalTemplate template;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  tr('templates.price'),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ),
              PriceTag(price: template.basePrice, isFree: template.isFree),
            ],
          ),
          const Divider(height: AppSpacing.xl),
          _InfoRow(
            icon: Icons.menu_book_rounded,
            label: tr('templates.bilingual_note'),
          ),
          _InfoRow(
            icon: Icons.account_balance_rounded,
            label: tr('templates.court_ready'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18, color: AppColors.secondary),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(label, style: context.textTheme.bodySmall)),
        ],
      ),
    );
  }
}

class _LawRow extends StatelessWidget {
  const _LawRow({required this.law});

  final String law;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.gavel_rounded, size: 16, color: AppColors.textLight),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(law, style: context.textTheme.bodySmall)),
        ],
      ),
    );
  }
}

/// Stamp duty is a real cost the user pays at the counter, separately from the
/// template price, so it gets its own notice rather than a line in the meta row.
class _StampDutyNotice extends StatelessWidget {
  const _StampDutyNotice({required this.duty});

  final double duty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.warningSoft,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.confirmation_number_rounded,
            size: 18,
            color: AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              tr(
                'templates.stamp_paper_notice',
                namedArgs: <String, String>{'amount': Formatters.rupees(duty)},
              ),
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.text,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The stored wording, shown with its `{{Placeholder}}` markers intact: that is
/// what the server holds, and seeing where the answers land is the point.
class _ContentCard extends StatelessWidget {
  const _ContentCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.surfaceMuted,
      child: Text(
        text,
        style: context.textTheme.bodySmall?.copyWith(
          color: AppColors.text,
          height: 1.7,
        ),
      ),
    );
  }
}
