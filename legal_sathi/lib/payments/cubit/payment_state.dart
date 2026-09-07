import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/payment.dart';

part 'payment_state.freezed.dart';

/// Composable checkout state: the chosen method, the in-flight charge and any
/// gateway failure live side by side.
@freezed
abstract class PaymentState with _$PaymentState {
  const factory PaymentState({
    required String documentId,
    required double amount,
    @Default(PaymentMethod.jazzcash) PaymentMethod method,
    @Default(false) bool isSubmitting,
    Payment? receipt,
    Failure? failure,
  }) = _PaymentState;
}

extension PaymentStateX on PaymentState {
  bool get isPaid => receipt?.isSuccessful ?? false;
}
