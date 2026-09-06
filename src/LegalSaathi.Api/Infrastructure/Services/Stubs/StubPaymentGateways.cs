using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Domain.Enums;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services.Stubs;

public class JazzCashPaymentGateway : IPaymentGateway
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<JazzCashPaymentGateway> _logger;

    public PaymentGatewayType GatewayType => PaymentGatewayType.JazzCash;

    public JazzCashPaymentGateway(IConfiguration configuration, ILogger<JazzCashPaymentGateway> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<Result<PaymentInitiationResponse>> InitiatePaymentAsync(PaymentInitiationRequest request, CancellationToken cancellationToken = default)
    {
        // TODO: In Phase 5, calculate HMAC-SHA256 hash using JAZZCASH_INTEGRITY_SALT and construct merchant POST payload
        _logger.LogInformation("Initiating JazzCash transaction for user {UserId}, amount: PKR {Amount}", request.UserId, request.Amount);

        await Task.CompletedTask;
        var txnRef = $"JC-{DateTime.UtcNow:yyyyMMddHHmmss}-{Guid.NewGuid().ToString("N")[..6].ToUpper()}";

        return Result<PaymentInitiationResponse>.Success(new PaymentInitiationResponse(
            IsSuccess: true,
            TransactionReference: txnRef,
            RedirectUrl: "https://sandbox.jazzcash.com.pk/CustomerPortal/transactionmanagement/merchantform/",
            FormPostData: null,
            ErrorMessage: null
        ));
    }

    public async Task<Result<PaymentCallbackResult>> VerifyPaymentCallbackAsync(IDictionary<string, string> callbackParameters, CancellationToken cancellationToken = default)
    {
        // TODO: In Phase 5, verify JazzCash response secure hash (pp_SecureHash)
        await Task.CompletedTask;
        var txnRef = callbackParameters.TryGetValue("pp_TxnRefNo", out var val) ? val : "JC-UNKNOWN";

        return Result<PaymentCallbackResult>.Success(new PaymentCallbackResult(
            IsSuccess: true,
            TransactionReference: txnRef,
            GatewayTransactionId: Guid.NewGuid().ToString("N"),
            Amount: 199.00m,
            Status: PaymentStatus.Success,
            RawPayload: "{}"
        ));
    }
}

public class EasyPaisaPaymentGateway : IPaymentGateway
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<EasyPaisaPaymentGateway> _logger;

    public PaymentGatewayType GatewayType => PaymentGatewayType.EasyPaisa;

    public EasyPaisaPaymentGateway(IConfiguration configuration, ILogger<EasyPaisaPaymentGateway> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<Result<PaymentInitiationResponse>> InitiatePaymentAsync(PaymentInitiationRequest request, CancellationToken cancellationToken = default)
    {
        // TODO: In Phase 5, integrate EasyPaisa Open API / MA checkout endpoint
        _logger.LogInformation("Initiating EasyPaisa transaction for user {UserId}, amount: PKR {Amount}", request.UserId, request.Amount);

        await Task.CompletedTask;
        var txnRef = $"EP-{DateTime.UtcNow:yyyyMMddHHmmss}-{Guid.NewGuid().ToString("N")[..6].ToUpper()}";

        return Result<PaymentInitiationResponse>.Success(new PaymentInitiationResponse(
            IsSuccess: true,
            TransactionReference: txnRef,
            RedirectUrl: "https://easypaystg.easypaisa.com.pk/easypay/Index.jsf",
            FormPostData: null,
            ErrorMessage: null
        ));
    }

    public async Task<Result<PaymentCallbackResult>> VerifyPaymentCallbackAsync(IDictionary<string, string> callbackParameters, CancellationToken cancellationToken = default)
    {
        // TODO: In Phase 5, verify EasyPaisa callback token and payment status
        await Task.CompletedTask;
        return Result<PaymentCallbackResult>.Success(new PaymentCallbackResult(
            IsSuccess: true,
            TransactionReference: "EP-SAMPLE-TXN",
            GatewayTransactionId: Guid.NewGuid().ToString("N"),
            Amount: 199.00m,
            Status: PaymentStatus.Success,
            RawPayload: "{}"
        ));
    }
}

public class PayFastPaymentGateway : IPaymentGateway
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<PayFastPaymentGateway> _logger;

    public PaymentGatewayType GatewayType => PaymentGatewayType.PayFast;

    public PayFastPaymentGateway(IConfiguration configuration, ILogger<PayFastPaymentGateway> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<Result<PaymentInitiationResponse>> InitiatePaymentAsync(PaymentInitiationRequest request, CancellationToken cancellationToken = default)
    {
        // TODO: In Phase 5, generate PayFast access token and checkout URL
        _logger.LogInformation("Initiating PayFast card transaction for user {UserId}, amount: PKR {Amount}", request.UserId, request.Amount);

        await Task.CompletedTask;
        var txnRef = $"PF-{DateTime.UtcNow:yyyyMMddHHmmss}-{Guid.NewGuid().ToString("N")[..6].ToUpper()}";

        return Result<PaymentInitiationResponse>.Success(new PaymentInitiationResponse(
            IsSuccess: true,
            TransactionReference: txnRef,
            RedirectUrl: "https://ipg.apps.net.pk/ecommerce/api/Transaction/GetAccessToken",
            FormPostData: null,
            ErrorMessage: null
        ));
    }

    public async Task<Result<PaymentCallbackResult>> VerifyPaymentCallbackAsync(IDictionary<string, string> callbackParameters, CancellationToken cancellationToken = default)
    {
        // TODO: In Phase 5, verify PayFast checksum
        await Task.CompletedTask;
        return Result<PaymentCallbackResult>.Success(new PaymentCallbackResult(
            IsSuccess: true,
            TransactionReference: "PF-SAMPLE-TXN",
            GatewayTransactionId: Guid.NewGuid().ToString("N"),
            Amount: 499.00m,
            Status: PaymentStatus.Success,
            RawPayload: "{}"
        ));
    }
}

public class PaymentGatewayFactory : IPaymentGatewayFactory
{
    private readonly IEnumerable<IPaymentGateway> _gateways;

    public PaymentGatewayFactory(IEnumerable<IPaymentGateway> gateways)
    {
        _gateways = gateways;
    }

    public IPaymentGateway GetGateway(PaymentGatewayType gatewayType)
    {
        var gateway = _gateways.FirstOrDefault(g => g.GatewayType == gatewayType);
        if (gateway == null)
        {
            throw new NotSupportedException($"Payment gateway '{gatewayType}' is not currently configured or supported.");
        }
        return gateway;
    }
}
