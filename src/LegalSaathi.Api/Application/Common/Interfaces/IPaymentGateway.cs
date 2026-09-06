using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public record PaymentInitiationRequest(
    int UserId,
    int? DocumentId,
    decimal Amount,
    string Currency,
    string CustomerEmail,
    string CustomerPhone,
    string ReturnUrl,
    string Description);

public record PaymentInitiationResponse(
    bool IsSuccess,
    string TransactionReference,
    string? RedirectUrl,
    string? FormPostData,
    string? ErrorMessage);

public record PaymentCallbackResult(
    bool IsSuccess,
    string TransactionReference,
    string? GatewayTransactionId,
    decimal Amount,
    PaymentStatus Status,
    string RawPayload);

/// <summary>
/// Abstraction for Pakistani Payment Gateways (JazzCash, EasyPaisa, PayFast)
/// </summary>
public interface IPaymentGateway
{
    PaymentGatewayType GatewayType { get; }
    Task<Result<PaymentInitiationResponse>> InitiatePaymentAsync(
        PaymentInitiationRequest request, 
        CancellationToken cancellationToken = default);

    Task<Result<PaymentCallbackResult>> VerifyPaymentCallbackAsync(
        IDictionary<string, string> callbackParameters, 
        CancellationToken cancellationToken = default);
}

/// <summary>
/// Factory to resolve payment gateways dynamically
/// </summary>
public interface IPaymentGatewayFactory
{
    IPaymentGateway GetGateway(PaymentGatewayType gatewayType);
}
