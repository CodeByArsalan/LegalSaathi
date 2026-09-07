import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/payment.dart';

part 'payment_dto.freezed.dart';
part 'payment_dto.g.dart';

@freezed
abstract class PaymentDto with _$PaymentDto {
  const factory PaymentDto({
    required String id,
    required String documentId,
    required double amount,
    required String paymentMethod,
    required String status,
    required DateTime createdAt,
    @Default('PKR') String currency,
    String? transactionId,
  }) = _PaymentDto;

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);
}

extension PaymentDtoMapper on PaymentDto {
  Payment toEntity() => Payment(
    id: id,
    documentId: documentId,
    amount: amount,
    method: PaymentMethod.parse(paymentMethod),
    status: PaymentStatus.parse(status),
    createdAt: createdAt,
    currency: currency,
    transactionId: transactionId,
  );
}

extension PaymentMapper on Payment {
  PaymentDto toDto() => PaymentDto(
    id: id,
    documentId: documentId,
    amount: amount,
    paymentMethod: method.name,
    status: status.name,
    createdAt: createdAt,
    currency: currency,
    transactionId: transactionId,
  );
}
