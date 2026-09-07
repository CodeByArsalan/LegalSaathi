import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/payment.dart';
import '../domain/usecases/initiate_payment.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required InitiatePaymentUseCase initiatePayment,
    required String documentId,
    required double amount,
  }) : _initiatePayment = initiatePayment,
       super(PaymentState(documentId: documentId, amount: amount));

  final InitiatePaymentUseCase _initiatePayment;

  void selectMethod(PaymentMethod method) {
    if (state.method == method) return;
    emit(state.copyWith(method: method, failure: null, receipt: null));
  }

  /// The real gateway opens a WebView and this cubit polls
  /// `checkPaymentStatus`; the mock settles in one call.
  Future<bool> pay() async {
    emit(state.copyWith(isSubmitting: true, failure: null));

    final result = await _initiatePayment(
      documentId: state.documentId,
      amount: state.amount,
      method: state.method,
    );
    if (isClosed) return false;

    return result.fold<bool>(
      onSuccess: (Payment payment) {
        emit(state.copyWith(isSubmitting: false, receipt: payment));
        return true;
      },
      onFailure: (Failure failure) {
        emit(state.copyWith(isSubmitting: false, failure: failure));
        return false;
      },
    );
  }
}
