import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../errors/failure.dart';
import 'feedback/empty_state.dart';
import 'feedback/error_view.dart';
import 'feedback/loading_overlay.dart';

/// The four states every feature screen repeats. Feature Cubit states expose a
/// `viewState` getter so a view can hand the switch over to [StateView].
enum ViewState { initial, loading, ready, empty, failure }

class StateView extends StatelessWidget {
  const StateView({
    required this.state,
    required this.builder,
    this.failure,
    this.onRetry,
    this.emptyTitle,
    this.emptyMessage,
    this.emptyIcon = Icons.inbox_outlined,
    this.emptyAction,
    this.loadingMessage,
    super.key,
  });

  final ViewState state;

  /// Built only for [ViewState.ready] / [ViewState.initial].
  final WidgetBuilder builder;
  final Failure? failure;
  final VoidCallback? onRetry;
  final String? emptyTitle;
  final String? emptyMessage;
  final IconData emptyIcon;
  final Widget? emptyAction;
  final String? loadingMessage;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      ViewState.loading => LoadingView(message: loadingMessage),
      ViewState.failure => ErrorView(
        failure: failure ?? const UnknownFailure(),
        onRetry: onRetry,
      ),
      ViewState.empty => EmptyState(
        title: emptyTitle ?? tr('common.nothing_here'),
        message: emptyMessage,
        icon: emptyIcon,
        action: emptyAction,
      ),
      ViewState.initial || ViewState.ready => builder(context),
    };
  }
}
