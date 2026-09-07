import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../cubit/ai_chat_cubit.dart';
import '../cubit/ai_chat_state.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_transcript.dart';

class AiChatView extends StatefulWidget {
  const AiChatView({super.key});

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send([String? preset]) {
    final String question = (preset ?? _input.text).trim();
    if (question.isEmpty) return;
    _input.clear();
    context.read<AiChatCubit>().send(
      question,
      languageCode: context.locale.languageCode,
    );
  }

  void _scrollToEnd() {
    if (!_scroll.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiChatCubit, AiChatState>(
      listenWhen: (AiChatState previous, AiChatState current) =>
          previous.messages.length != current.messages.length ||
          previous.isWaitingForAnswer != current.isWaitingForAnswer ||
          (current.failure != null && previous.failure != current.failure),
      listener: (BuildContext context, AiChatState state) {
        final Failure? failure = state.failure;
        if (failure != null) AppSnackBar.failure(context, failure);
        _scrollToEnd();
      },
      builder: (BuildContext context, AiChatState state) {
        final bool isEmpty = state.messages.isEmpty;

        return AppScaffold(
          title: tr('ai.title'),
          actions: <Widget>[
            if (!isEmpty)
              IconButton(
                onPressed: () {
                  context.read<AiChatCubit>().clear();
                  AppSnackBar.success(context, tr('ai.cleared'));
                },
                icon: const Icon(Icons.delete_sweep_outlined),
                tooltip: tr('ai.cleared'),
              ),
          ],
          bottomBar: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (isEmpty)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.gutter,
                      AppSpacing.sm,
                      context.gutter,
                      0,
                    ),
                    child: SuggestedQuestions(
                      prompts: state.quickPrompts,
                      languageCode: context.locale.languageCode,
                      onSelected: _send,
                    ),
                  ),
                ChatInputBar(
                  controller: _input,
                  enabled: !state.isWaitingForAnswer,
                  onSend: _send,
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              const _DisclaimerBanner(),
              Expanded(
                child: ChatTranscript(
                  messages: state.messages,
                  isWaitingForAnswer: state.isWaitingForAnswer,
                  scrollController: _scroll,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DisclaimerBanner extends StatelessWidget {
  const _DisclaimerBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.warningSoft,
      padding: EdgeInsets.symmetric(
        horizontal: context.gutter,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.info_outline_rounded,
            size: 15,
            color: AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              tr('ai.disclaimer'),
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
