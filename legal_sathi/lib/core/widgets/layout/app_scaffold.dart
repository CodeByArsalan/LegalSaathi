import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../utils/extensions/context_x.dart';
import '../feedback/loading_overlay.dart';

/// One scaffold for the whole app: legal-blue app bar, background token,
/// optional tab-aware back button and a global busy overlay.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.title,
    this.actions,
    this.showBackButton = true,
    this.bottomBar,
    this.floatingActionButton,
    this.isLoading = false,
    this.loadingMessage,
    this.extendBodyBehindAppBar = false,
    this.onBack,
    super.key,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? bottomBar;
  final Widget? floatingActionButton;
  final bool isLoading;
  final String? loadingMessage;
  final bool extendBodyBehindAppBar;

  /// Overrides the default pop behaviour (unsaved-form prompts).
  final Future<void> Function()? onBack;

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      bottomNavigationBar: bottomBar,
      floatingActionButton: floatingActionButton,
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title ?? '', overflow: TextOverflow.ellipsis),
              automaticallyImplyLeading: false,
              leading: showBackButton && canPop
                  ? IconButton(
                      onPressed: () async {
                        final override = onBack;
                        if (override != null) {
                          await override();
                          return;
                        }
                        if (context.canPop()) context.pop();
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                      tooltip: tr('common.back'),
                    )
                  : null,
              actions: actions,
            ),
      body: LoadingOverlay(
        isLoading: isLoading,
        message: loadingMessage,
        child: body,
      ),
    );
  }
}

/// Plain body without an app bar — used by shell tabs and splash.
class AppBody extends StatelessWidget {
  const AppBody({
    required this.child,
    this.padding,
    this.isLoading = false,
    super.key,
  });

  final Widget child;
  final EdgeInsets? padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: context.gutter),
        child: SafeArea(child: child),
      ),
    );
  }
}
