import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';

/// Local payment rails from `Mobile App Development.md` §5.
enum PaymentMethod {
  jazzcash,
  easypaisa,
  card;

  static PaymentMethod parse(String? value) => PaymentMethod.values.firstWhere(
    (PaymentMethod method) =>
        method.name == value?.trim().toLowerCase().replaceAll(' ', ''),
    orElse: () => PaymentMethod.jazzcash,
  );

  String get l10nKey => switch (this) {
    PaymentMethod.jazzcash => 'payments.jazzcash',
    PaymentMethod.easypaisa => 'payments.easypaisa',
    PaymentMethod.card => 'payments.card',
  };
}

enum PaymentStatus {
  pending,
  success,
  failed,
  refunded;

  static PaymentStatus parse(String? value) => PaymentStatus.values.firstWhere(
    (PaymentStatus status) => status.name == value?.trim().toLowerCase(),
    orElse: () => PaymentStatus.pending,
  );

  String get l10nKey => switch (this) {
    PaymentStatus.pending => 'payments.status.pending',
    PaymentStatus.success => 'payments.status.success',
    PaymentStatus.failed => 'payments.status.failed',
    PaymentStatus.refunded => 'payments.status.refunded',
  };
}

/// A gateway charge against one document.
@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String documentId,
    required double amount,
    required PaymentMethod method,
    required PaymentStatus status,
    required DateTime createdAt,
    @Default('PKR') String currency,
    String? transactionId,
  }) = _Payment;
}

extension PaymentX on Payment {
  bool get isSuccessful => status == PaymentStatus.success;
}
