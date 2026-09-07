import '../../../core/errors/result.dart';
import '../entities/payment.dart';
import '../repositories/payment_repository.dart';

class CheckPaymentStatusUseCase {
  const CheckPaymentStatusUseCase(this._repository);

  final PaymentRepository _repository;

  Future<Result<Payment>> call(String paymentId) =>
      _repository.checkPaymentStatus(paymentId);
}
