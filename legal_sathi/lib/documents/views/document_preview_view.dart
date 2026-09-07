import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/failure.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/buttons/ghost_button.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../../../core/widgets/layout/app_card.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/layout/max_width_body.dart';
import '../../../core/widgets/layout/section_header.dart';
import '../../../core/widgets/state_view.dart';
import '../../../signature/domain/entities/document_signature.dart';
import '../../../signature/domain/entities/signer_identity.dart';
import '../cubit/document_preview_cubit.dart';
import '../cubit/document_preview_state.dart';
import '../domain/entities/document_format.dart';
import '../domain/entities/legal_document.dart';
import '../widgets/document_status_chip.dart';

/// One document as the server holds it: its stage, the answers that were rendered
/// into it, and the files that can be taken away.
///
/// The rendered file itself is not shown inline — the bytes are a PDF or a DOCX,
/// and both are better read in the viewer the user already has, which is what the
/// share sheet offers.
class DocumentPreviewView extends StatelessWidget {
  const DocumentPreviewView({required this.documentId, super.key});

  final int documentId;

  @override
  Widget build(BuildContext context) {
    final DocumentPreviewCubit cubit = context.read<DocumentPreviewCubit>();

    return BlocListener<DocumentPreviewCubit, DocumentPreviewState>(
      listenWhen: (prev, curr) =>
          (curr.readyOrNull?.errorTick ?? 0) >
          (prev.readyOrNull?.errorTick ?? 0),
      listener: (BuildContext context, DocumentPreviewState state) {
        final Failure? failure = state.readyOrNull?.failure;
        if (failure != null) AppSnackBar.failure(context, failure);
      },
      child: BlocBuilder<DocumentPreviewCubit, DocumentPreviewState>(
        builder: (BuildContext context, DocumentPreviewState state) {
          final DocumentPreviewReady? ready = state.readyOrNull;

          return AppScaffold(
            title: tr('documents.preview_title'),
            body: StateView(
              state: state.viewState,
              failure: state.failure,
              onRetry: cubit.load,
              builder: (BuildContext context) => _Body(ready: ready!),
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.ready});

  final DocumentPreviewReady ready;

  @override
  Widget build(BuildContext context) {
    final DocumentPreviewCubit cubit = context.read<DocumentPreviewCubit>();
    final LegalDocument document = ready.document;
    final String languageCode = context.languageCode;
    final bool hasOwnTitle = document.title.trim().isNotEmpty;

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          context.gutter,
          AppSpacing.md,
          context.gutter,
          AppSpacing.xxxl,
        ),
        children: <Widget>[
          MaxWidthBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              document.displayName(languageCode),
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          DocumentStatusChip(status: document.status),
                        ],
                      ),
                      if (hasOwnTitle) ...<Widget>[
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          document.templateTitle(languageCode),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      _Fact(
                        icon: Icons.schedule_rounded,
                        label: tr('documents.created'),
                        value: Formatters.date(document.createdAt),
                      ),
                      if (document.completedAt case final DateTime completed?)
                        _Fact(
                          icon: Icons.task_alt_rounded,
                          label: tr('documents.rendered'),
                          value: Formatters.dateTime(completed),
                        ),
                      if (document.documentHash case final String hash?)
                        _Fact(
                          icon: Icons.fingerprint_rounded,
                          label: tr('documents.hash'),
                          value: hash,
                        ),
                    ],
                  ),
                ),
                SectionHeader(title: tr('documents.answers_title')),
                _Answers(document: document),
                SectionHeader(title: tr('documents.files_title')),
                if (document.hasDownloads) ...<Widget>[
                  PrimaryButton(
                    label: tr('documents.download_pdf'),
                    icon: Icons.picture_as_pdf_rounded,
                    isLoading: ready.busyFormat == DocumentFormat.pdf,
                    onPressed: () => cubit.share(DocumentFormat.pdf),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  GhostButton(
                    label: tr('documents.download_docx'),
                    icon: Icons.description_rounded,
                    onPressed: ready.busyFormat == null
                        ? () => cubit.share(DocumentFormat.docx)
                        : null,
                  ),
                ] else
                  AppCard(
                    child: Text(
                      tr('documents.no_files_body'),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                if (document.status.needsSignature) ...<Widget>[
                  SectionHeader(title: tr('documents.signature_title')),
                  PrimaryButton(
                    label: tr('documents.add_signature'),
                    icon: Icons.draw_rounded,
                    onPressed: () async {
                      await context.push(RoutePaths.signature(document.id));
                      // Signing moves the document to `Signed` server-side; the
                      // copy on this page is the one loaded before that.
                      await cubit.load();
                    },
                  ),
                ],
                if (ready.signatures.isNotEmpty) ...<Widget>[
                  SectionHeader(title: tr('documents.signature_title')),
                  _Signatures(signatures: ready.signatures),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The signatures filed against this document. The captured image is not shown:
/// the API stores it in a vault that no endpoint serves.
class _Signatures extends StatelessWidget {
  const _Signatures({required this.signatures});

  final List<DocumentSignature> signatures;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < signatures.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            _SignatureRow(signature: signatures[i]),
          ],
        ],
      ),
    );
  }
}

class _SignatureRow extends StatelessWidget {
  const _SignatureRow({required this.signature});

  final DocumentSignature signature;

  @override
  Widget build(BuildContext context) {
    final SignerRole? role = SignerRole.tryParse(signature.signerRole);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          signature.isOtpVerified
              ? Icons.verified_user_rounded
              : Icons.gpp_maybe_outlined,
          size: 20,
          color: signature.isOtpVerified
              ? AppColors.success
              : AppColors.warning,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(signature.signerName, style: context.textTheme.bodyMedium),
              const SizedBox(height: 2),
              Text(
                '${role == null ? signature.signerRole : tr(role.l10nKey)} · '
                '${Formatters.dateTime(signature.signedAt.toLocal())}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Answers extends StatelessWidget {
  const _Answers({required this.document});

  final LegalDocument document;

  @override
  Widget build(BuildContext context) {
    // Only what was actually answered: a draft carries empty strings for every
    // question the user reached and then left blank.
    final List<MapEntry<String, String>> answered = document.answers.entries
        .where(
          (MapEntry<String, String> entry) => entry.value.trim().isNotEmpty,
        )
        .toList(growable: false);

    if (answered.isEmpty) {
      return AppCard(
        child: Text(
          tr('documents.no_answers'),
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.textLight,
          ),
        ),
      );
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < answered.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            Text(
              Formatters.fieldLabel(answered[i].key),
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 2),
            Text(answered[i].value, style: context.textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 16, color: AppColors.textLight),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
                Text(value, style: context.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
