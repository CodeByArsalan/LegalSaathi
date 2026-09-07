import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/layout/section_header.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';
import '../domain/entities/payment.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/payment_method_tile.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({
    required this.documentId,
    required this.amount,
    this.documentName,
    super.key,
  });

  final String documentId;
  final double amount;
  final String? documentName;

  @override
  Widget build(BuildContext context) {
    final PaymentCubit cubit = context.read<PaymentCubit>();

    return BlocConsumer<PaymentCubit, PaymentState>(
      listenWhen: (PaymentState previous, PaymentState current) =>
          previous.receipt != current.receipt ||
          (current.failure != null && previous.failure != current.failure),
      listener: (BuildContext context, PaymentState state) {
        final failure = state.failure;
        if (failure != null) {
          AppSnackBar.failure(context, failure);
          return;
        }
        final receipt = state.receipt;
        if (receipt != null) {
          context.pushReplacement(
            RoutePaths.paymentSuccessLocation(
              transactionId: receipt.transactionId ?? receipt.id,
              amount: receipt.amount,
            ),
          );
        }
      },
      builder: (BuildContext context, PaymentState state) {
        return AppScaffold(
          title: tr('payments.title'),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: context.gutter),
              children: <Widget>[
                const SizedBox(height: AppSpacing.md),
                OrderSummaryCard(
                  documentLabel:
                      documentName ?? '${tr('payments.document')}: $documentId',
                  amount: amount,
                ),
                SectionHeader(
                  title: tr('payments.method'),
                  padding: const EdgeInsets.only(
                    top: AppSpacing.xl,
                    bottom: AppSpacing.md,
                  ),
                ),
                for (final PaymentMethod method in PaymentMethod.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: PaymentMethodTile(
                      method: method,
                      selected: state.method == method,
                      onTap: () => cubit.selectMethod(method),
                    ),
                  ),
                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
          bottomBar: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.gutter,
                AppSpacing.md,
                context.gutter,
                AppSpacing.md,
              ),
              child: PrimaryButton(
                label: tr('payments.proceed'),
                icon: Icons.lock_rounded,
                isLoading: state.isSubmitting,
                onPressed: cubit.pay,
              ),
            ),
          ),
        );
      },
    );
  }
}
