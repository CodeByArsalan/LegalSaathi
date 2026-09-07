import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';
import '../models/payment_dto.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl(this._remote);

  final PaymentRemoteDataSource _remote;

  @override
  Future<Result<Payment>> initiatePayment({
    required String documentId,
    required double amount,
    required PaymentMethod method,
  }) async {
    try {
      return Success<Payment>(
        (await _remote.initiatePayment(
          documentId: documentId,
          amount: amount,
          method: method,
        )).toEntity(),
      );
    } on Object catch (error) {
      return FailureResult<Payment>(Failure.from(error));
    }
  }

  @override
  Future<Result<Payment>> checkPaymentStatus(String paymentId) async {
    try {
      return Success<Payment>(
        (await _remote.checkPaymentStatus(paymentId)).toEntity(),
      );
    } on Object catch (error) {
      return FailureResult<Payment>(Failure.from(error));
    }
  }

  @override
  Future<Result<List<Payment>>> getPaymentHistory() async {
    try {
      return Success<List<Payment>>(
        (await _remote.getPaymentHistory())
            .map((PaymentDto dto) => dto.toEntity())
            .toList(growable: false),
      );
    } on Object catch (error) {
      return FailureResult<List<Payment>>(Failure.from(error));
    }
  }
}
