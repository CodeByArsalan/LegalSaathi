import '../../domain/entities/payment.dart';
import '../models/payment_dto.dart';

/// `/payment` endpoints. Implementations throw `AppException`.
abstract class PaymentRemoteDataSource {
  Future<PaymentDto> initiatePayment({
    required String documentId,
    required double amount,
    required PaymentMethod method,
  });

  Future<PaymentDto> checkPaymentStatus(String paymentId);

  Future<List<PaymentDto>> getPaymentHistory();
}
