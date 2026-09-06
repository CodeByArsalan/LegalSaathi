namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface IOtpService
{
    Task<(bool Success, string Message, int ExpirySeconds)> SendOtpAsync(string destination, string purpose, CancellationToken ct = default);
    Task<(bool Verified, string Message, string? VerificationToken)> VerifyOtpAsync(string destination, string otpCode, string purpose, CancellationToken ct = default);
}
