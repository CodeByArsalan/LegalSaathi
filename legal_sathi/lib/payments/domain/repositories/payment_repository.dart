import '../../../core/errors/result.dart';
import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<Result<Payment>> initiatePayment({
    required String documentId,
    required double amount,
    required PaymentMethod method,
  });

  Future<Result<Payment>> checkPaymentStatus(String paymentId);

  Future<Result<List<Payment>>> getPaymentHistory();
}
