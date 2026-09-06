using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Contracts.Payments;

public record InitiateCheckoutRequest(
    int? DocumentId,
    PaymentGatewayType GatewayType,
    string ReturnUrl);

public record CheckoutSessionDto(
    string TransactionReference,
    decimal Amount,
    string Currency,
    PaymentGatewayType GatewayType,
    string? RedirectUrl,
    string? FormPostData);

public record PaymentTransactionDto(
    int PaymentId,
    Guid PaymentGuid,
    int? UserDocumentId,
    decimal Amount,
    string Currency,
    PaymentGatewayType Gateway,
    PaymentStatus Status,
    string? TransactionReference,
    DateTime CreatedAt,
    DateTime? CompletedAt);
