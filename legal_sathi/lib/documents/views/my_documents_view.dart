import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/state_view.dart';
import '../cubit/my_documents_cubit.dart';
import '../cubit/my_documents_state.dart';
import '../domain/entities/legal_document.dart';
import '../widgets/document_card.dart';

/// The Documents tab. Rows are not dismissible: the API has no DELETE route, so
/// there is nothing to offer but the list itself.
class MyDocumentsView extends StatefulWidget {
  const MyDocumentsView({super.key});

  @override
  State<MyDocumentsView> createState() => _MyDocumentsViewState();
}

class _MyDocumentsViewState extends State<MyDocumentsView> {
  DateTime? _lastFetchAt;

  /// The shell detaches hidden branches and re-attaches them on return, which
  /// re-fires this callback: first attach loads (with spinner), later attaches
  /// silently refresh so newly built documents appear without a pull.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final DateTime now = DateTime.now();
    if (_lastFetchAt != null &&
        now.difference(_lastFetchAt!) < const Duration(seconds: 2)) {
      return;
    }
    final bool firstFetch = _lastFetchAt == null;
    _lastFetchAt = now;

    final MyDocumentsCubit cubit = context.read<MyDocumentsCubit>();
    if (firstFetch) {
      cubit.load();
    } else {
      cubit.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final MyDocumentsCubit cubit = context.read<MyDocumentsCubit>();

    return AppScaffold(
      title: tr('documents.title'),
      showBackButton: false,
      body: BlocBuilder<MyDocumentsCubit, MyDocumentsState>(
        builder: (BuildContext context, MyDocumentsState state) {
          return SafeArea(
            child: StateView(
              state: state.viewState,
              failure: state.failure,
              onRetry: cubit.load,
              emptyTitle: tr('documents.empty_title'),
              emptyMessage: tr('documents.empty_body'),
              emptyIcon: Icons.folder_off_outlined,
              emptyAction: PrimaryButton(
                label: tr('documents.new_document'),
                icon: Icons.add_rounded,
                expanded: false,
                onPressed: () => context.go(RoutePaths.templates),
              ),
              builder: (BuildContext context) => RefreshIndicator(
                onRefresh: cubit.load,
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    context.gutter,
                    AppSpacing.md,
                    context.gutter,
                    AppSpacing.xxxl * 2,
                  ),
                  itemCount: state.documents.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (BuildContext context, int index) {
                    final LegalDocument document = state.documents[index];
                    return DocumentCard(
                      document: document,
                      onTap: () =>
                          context.push(RoutePaths.preview(document.id)),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
