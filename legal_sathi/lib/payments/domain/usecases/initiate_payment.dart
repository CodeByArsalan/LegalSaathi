import '../../../core/errors/result.dart';
import '../entities/payment.dart';
import '../repositories/payment_repository.dart';

class InitiatePaymentUseCase {
  const InitiatePaymentUseCase(this._repository);

  final PaymentRepository _repository;

  Future<Result<Payment>> call({
    required String documentId,
    required double amount,
    required PaymentMethod method,
  }) => _repository.initiatePayment(
    documentId: documentId,
    amount: amount,
    method: method,
  );
}
