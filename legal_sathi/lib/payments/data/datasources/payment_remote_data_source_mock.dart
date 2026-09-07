import '../../../core/constants/asset_paths.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/mock/mock_data_source.dart';
import '../../../core/mock/mock_session_store.dart';
import '../../domain/entities/payment.dart';
import '../models/payment_dto.dart';
import 'payment_remote_data_source.dart';

/// Simulates the JazzCash / Easypaisa redirect: the gateway accepts every
/// amount except a declined card, and a successful charge sets the document's
/// `isPaid` flag.
class PaymentRemoteDataSourceMock extends MockDataSource
    implements PaymentRemoteDataSource {
  PaymentRemoteDataSourceMock(this._session);

  final MockSessionStore _session;

  static const double _declinedAmount = 9999;

  @override
  Future<PaymentDto> initiatePayment({
    required String documentId,
    required double amount,
    required PaymentMethod method,
  }) async {
    final String id = 'pay_${DateTime.now().millisecondsSinceEpoch}';
    final bool declined = amount == _declinedAmount;

    final PaymentDto dto = PaymentDto(
      id: id,
      documentId: documentId,
      amount: amount,
      paymentMethod: method.name,
      status: declined ? 'failed' : 'success',
      createdAt: DateTime.now(),
      transactionId: '${method.name.substring(0, 2).toUpperCase()}-$id',
    );
    _session.putPayment(dto.toJson());

    if (!declined) _markDocumentPaid(documentId);

    if (declined) {
      throw AppException(
        'The gateway declined this transaction.',
        kind: AppExceptionKind.server,
        statusCode: 402,
      );
    }

    return withLatency(dto);
  }

  @override
  Future<PaymentDto> checkPaymentStatus(String paymentId) async {
    final List<Map<String, dynamic>> matches = _session.payments
        .where((Map<String, dynamic> item) => item['id'] == paymentId)
        .toList(growable: false);
    if (matches.isEmpty) {
      throw AppException(
        'No payment with id "$paymentId".',
        kind: AppExceptionKind.notFound,
        statusCode: 404,
      );
    }
    return withLatency(PaymentDto.fromJson(matches.first));
  }

  @override
  Future<List<PaymentDto>> getPaymentHistory() async {
    final List<PaymentDto> seeded = (await loadRows(
      AssetPaths.mockPayments,
    )).map(PaymentDto.fromJson).toList();
    final List<PaymentDto> made =
        _session.payments.map(PaymentDto.fromJson).toList()..sort(
          (PaymentDto a, PaymentDto b) => b.createdAt.compareTo(a.createdAt),
        );
    return withLatency(<PaymentDto>[...made, ...seeded]);
  }

  void _markDocumentPaid(String documentId) {
    // Payments keep a string document id until the signature layer moves onto
    // the API's numeric one; the store is keyed by that numeric id.
    final int? id = int.tryParse(documentId);
    final Map<String, dynamic>? row = id == null ? null : _session.document(id);
    if (row == null) return;
    _session.putDocument(Map<String, dynamic>.of(row)..['isPaid'] = true);
  }
}
