import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/buttons/ghost_button.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/layout/max_width_body.dart';
import '../../../core/widgets/state_view.dart';
import '../../../templates/domain/entities/legal_template.dart';
import '../../../templates/domain/entities/template_field.dart';
import '../cubit/document_builder_cubit.dart';
import '../cubit/document_builder_state.dart';
import '../widgets/builder_field.dart';

/// Guided wizard behind "Start Building": answers the template's questions page
/// by page — the pages the server chose — persisting a draft as it goes, then
/// renders the document and hands the user to its preview.
class DocumentBuilderView extends StatelessWidget {
  const DocumentBuilderView({required this.slug, super.key});

  /// The template being built, and the key the cubit used to load it.
  final String slug;

  @override
  Widget build(BuildContext context) {
    final DocumentBuilderCubit cubit = context.read<DocumentBuilderCubit>();

    return MultiBlocListener(
      listeners: <BlocListener<DocumentBuilderCubit, DocumentBuilderState>>[
        BlocListener<DocumentBuilderCubit, DocumentBuilderState>(
          listenWhen: (prev, curr) =>
              _ready(prev)?.generation == null &&
              _ready(curr)?.generation != null,
          listener: (BuildContext context, DocumentBuilderState state) {
            final int documentId = _ready(state)!.generation!.documentId;
            AppSnackBar.success(context, tr('documents.generated'));
            context.go(RoutePaths.preview(documentId));
          },
        ),
        BlocListener<DocumentBuilderCubit, DocumentBuilderState>(
          listenWhen: (prev, curr) =>
              (_ready(curr)?.invalidTick ?? 0) >
              (_ready(prev)?.invalidTick ?? 0),
          listener: (BuildContext context, _) =>
              AppSnackBar.show(context, tr('documents.invalid_step')),
        ),
        BlocListener<DocumentBuilderCubit, DocumentBuilderState>(
          listenWhen: (prev, curr) =>
              (_ready(curr)?.draftTick ?? 0) > (_ready(prev)?.draftTick ?? 0),
          listener: (BuildContext context, _) =>
              AppSnackBar.success(context, tr('documents.saved_draft')),
        ),
        BlocListener<DocumentBuilderCubit, DocumentBuilderState>(
          listenWhen: (prev, curr) =>
              (_ready(curr)?.errorTick ?? 0) > (_ready(prev)?.errorTick ?? 0),
          listener: (BuildContext context, DocumentBuilderState state) {
            final DocumentBuilderReady? ready = _ready(state);
            if (ready?.error != null) {
              AppSnackBar.failure(context, ready!.error!);
            }
          },
        ),
      ],
      child: BlocBuilder<DocumentBuilderCubit, DocumentBuilderState>(
        builder: (BuildContext context, DocumentBuilderState state) {
          final DocumentBuilderReady? ready = _ready(state);
          final String languageCode = context.languageCode;

          return AppScaffold(
            title: ready == null
                ? tr('documents.builder_title')
                : ready.template.title(languageCode),
            isLoading: ready?.saving ?? false,
            actions: ready == null
                ? null
                : <Widget>[
                    IconButton(
                      onPressed: ready.saving ? null : cubit.saveDraft,
                      icon: const Icon(Icons.save_outlined),
                      tooltip: tr('common.save_draft'),
                    ),
                  ],
            body: StateView(
              state: state.viewState,
              failure: state.failure,
              onRetry: cubit.start,
              builder: (BuildContext context) => ready == null
                  ? const SizedBox.shrink()
                  : _StepBody(ready: ready),
            ),
          );
        },
      ),
    );
  }

  static DocumentBuilderReady? _ready(DocumentBuilderState state) =>
      state.readyOrNull;
}

class _StepBody extends StatelessWidget {
  const _StepBody({required this.ready});

  final DocumentBuilderReady ready;

  /// The reason a field is not acceptable, once the user has tried to move on.
  /// Before that nothing is marked wrong, so a fresh page does not open covered
  /// in red.
  String? _errorFor(TemplateField field, String value) {
    final String? key = ready.invalidTick == 0
        ? null
        : field.errorKeyFor(value);
    return key == null ? null : tr(key);
  }

  @override
  Widget build(BuildContext context) {
    final DocumentBuilderCubit cubit = context.read<DocumentBuilderCubit>();
    final List<TemplateField> fields = ready.step;

    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: context.gutter,
              top: AppSpacing.md,
              end: context.gutter,
              bottom: AppSpacing.sm,
            ),
            child: MaxWidthBody(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    tr(
                      'documents.step_of',
                      namedArgs: <String, String>{
                        'current': '${ready.currentStep + 1}',
                        'total': '${ready.totalSteps}',
                      },
                    ),
                    style: context.textTheme.labelMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.xxs),
                    child: LinearProgressIndicator(
                      value: (ready.currentStep + 1) / ready.totalSteps,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              key: ValueKey<int>(ready.currentStep),
              padding: EdgeInsetsDirectional.only(
                start: context.gutter,
                top: AppSpacing.lg,
                end: context.gutter,
                bottom: AppSpacing.xxl,
              ),
              children: <Widget>[
                MaxWidthBody(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      for (final TemplateField field in fields)
                        BuilderField(
                          field: field,
                          value: ready.answers[field.fieldKey] ?? '',
                          errorText: _errorFor(
                            field,
                            ready.answers[field.fieldKey] ?? '',
                          ),
                          onChanged: (String value) =>
                              cubit.setAnswer(field.fieldKey, value),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _BottomBar(ready: ready),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.ready});

  final DocumentBuilderReady ready;

  @override
  Widget build(BuildContext context) {
    final DocumentBuilderCubit cubit = context.read<DocumentBuilderCubit>();

    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: context.gutter,
          top: AppSpacing.sm,
          end: context.gutter,
          bottom: AppSpacing.md,
        ),
        child: MaxWidthBody(
          child: Row(
            children: <Widget>[
              if (ready.currentStep > 0)
                GhostButton(
                  label: tr('common.back'),
                  icon: context.isRtl
                      ? Icons.arrow_forward_rounded
                      : Icons.arrow_back_rounded,
                  onPressed: cubit.back,
                )
              else
                const SizedBox(width: AppSpacing.sm),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: PrimaryButton(
                  label: ready.isLastStep
                      ? tr('documents.generate')
                      : tr('common.next'),
                  icon: ready.isLastStep
                      ? Icons.auto_awesome_rounded
                      : Icons.arrow_forward_rounded,
                  isLoading: ready.saving,
                  onPressed: ready.isLastStep ? cubit.finish : cubit.next,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
