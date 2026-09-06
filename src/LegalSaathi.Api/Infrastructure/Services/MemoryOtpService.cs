using System.Collections.Concurrent;
using System.Security.Cryptography;
using LegalSaathi.Api.Application.Common.Interfaces;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

public class MemoryOtpService : IOtpService
{
    private readonly ILogger<MemoryOtpService> _logger;
    private static readonly ConcurrentDictionary<string, OtpEntry> OtpStore = new();

    private record OtpEntry(string Code, DateTime ExpiresAtUtc, string Purpose, string VerificationToken);

    public MemoryOtpService(ILogger<MemoryOtpService> logger)
    {
        _logger = logger;
    }

    public Task<(bool Success, string Message, int ExpirySeconds)> SendOtpAsync(string destination, string purpose, CancellationToken ct = default)
    {
        var normalizedDest = destination.Trim().ToLowerInvariant();
        var code = RandomNumberGenerator.GetInt32(100000, 999999).ToString();
        var expiry = DateTime.UtcNow.AddMinutes(5);
        var verificationToken = Guid.NewGuid().ToString("N");

        OtpStore[normalizedDest] = new OtpEntry(code, expiry, purpose, verificationToken);

        _logger.LogInformation("==================================================");
        _logger.LogInformation("MOCK OTP GENERATED FOR {Destination} [{Purpose}]: {Code}", destination, purpose, code);
        _logger.LogInformation("Expires at (UTC): {ExpiresAt}", expiry);
        _logger.LogInformation("==================================================");

        return Task.FromResult((true, $"OTP sent successfully to {destination}. Valid for 5 minutes.", 300));
    }

    public Task<(bool Verified, string Message, string? VerificationToken)> VerifyOtpAsync(string destination, string otpCode, string purpose, CancellationToken ct = default)
    {
        var normalizedDest = destination.Trim().ToLowerInvariant();

        if (!OtpStore.TryGetValue(normalizedDest, out var entry))
        {
            return Task.FromResult<(bool, string, string?)>((false, "No OTP request found for this destination or OTP has expired.", null));
        }

        if (DateTime.UtcNow > entry.ExpiresAtUtc)
        {
            OtpStore.TryRemove(normalizedDest, out _);
            return Task.FromResult<(bool, string, string?)>((false, "OTP has expired. Please request a new one.", null));
        }

        if (!string.Equals(entry.Purpose, purpose, StringComparison.OrdinalIgnoreCase))
        {
            return Task.FromResult<(bool, string, string?)>((false, "Invalid OTP purpose.", null));
        }

        if (!string.Equals(entry.Code, otpCode.Trim(), StringComparison.Ordinal))
        {
            return Task.FromResult<(bool, string, string?)>((false, "Incorrect OTP code. Please try again.", null));
        }

        // Successfully verified
        OtpStore.TryRemove(normalizedDest, out _);
        return Task.FromResult<(bool, string, string?)>((true, "OTP verified successfully.", entry.VerificationToken));
    }
}
