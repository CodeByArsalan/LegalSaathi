using System.Collections.Concurrent;
using System.Security.Cryptography;
using LegalSaathi.Api.Application.Common.Interfaces;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

public class MemoryOtpService : IOtpService
{
    private readonly IEmailService? _emailService;
    private readonly ILogger<MemoryOtpService> _logger;
    private static readonly ConcurrentDictionary<string, OtpEntry> OtpStore = new();

    private record OtpEntry(string Code, DateTime ExpiresAtUtc, string Purpose, string VerificationToken);

    public MemoryOtpService(ILogger<MemoryOtpService> logger, IEmailService? emailService = null)
    {
        _logger = logger;
        _emailService = emailService;
    }

    public async Task<(bool Success, string Message, int ExpirySeconds)> SendOtpAsync(string destination, string purpose, CancellationToken ct = default)
    {
        var normalizedDest = destination.Trim().ToLowerInvariant();
        var code = RandomNumberGenerator.GetInt32(100000, 999999).ToString();
        var expiry = DateTime.UtcNow.AddMinutes(5);
        var verificationToken = Guid.NewGuid().ToString("N");

        OtpStore[normalizedDest] = new OtpEntry(code, expiry, purpose, verificationToken);

        _logger.LogInformation("==================================================");
        _logger.LogInformation("OTP GENERATED FOR {Destination} [{Purpose}]: {Code}", destination, purpose, code);
        _logger.LogInformation("Expires at (UTC): {ExpiresAt}", expiry);
        _logger.LogInformation("==================================================");

        // If destination is an email address and email service is available, dispatch HTML email
        if (normalizedDest.Contains('@') && _emailService != null)
        {
            var subject = $"Legal Saathi Verification Code: {code} | لیگل ساتھی تصدیقی کوڈ";
            var bodyHtml = $@"
<!DOCTYPE html>
<html>
<head>
  <meta charset=""utf-8"">
  <style>
    body {{ font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8fafc; margin: 0; padding: 20px; }}
    .container {{ max-width: 540px; margin: 0 auto; background: #ffffff; border-radius: 16px; border: 1px solid #e2e8f0; overflow: hidden; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); }}
    .header {{ background: linear-gradient(135deg, #047857 0%, #065f46 100%); padding: 30px; text-align: center; color: #ffffff; }}
    .header h1 {{ margin: 0; font-size: 24px; font-weight: 800; }}
    .header p {{ margin: 6px 0 0; font-size: 14px; opacity: 0.9; }}
    .body {{ padding: 30px; color: #334155; line-height: 1.6; }}
    .otp-box {{ background-color: #ecfdf5; border: 2px dashed #059669; border-radius: 12px; padding: 18px; text-align: center; margin: 24px 0; }}
    .otp-code {{ font-size: 36px; font-weight: 800; letter-spacing: 8px; color: #047857; margin: 0; }}
    .urdu-text {{ font-size: 15px; color: #065f46; text-align: right; margin-top: 15px; direction: rtl; font-family: 'Jameel Noori Nastaleeq', Tahoma, sans-serif; }}
    .footer {{ background: #f1f5f9; padding: 20px; text-align: center; font-size: 12px; color: #64748b; border-top: 1px solid #e2e8f0; }}
  </style>
</head>
<body>
  <div class=""container"">
    <div class=""header"">
      <h1>Legal Saathi • لیگل ساتھی</h1>
      <p>Pakistan's AI Legal Documentation Platform</p>
    </div>
    <div class=""body"">
      <p>Hello,</p>
      <p>Thank you for registering on <strong>Legal Saathi</strong>. Please use the following 6-digit One-Time Password (OTP) to verify your email address:</p>
      
      <div class=""otp-box"">
        <div class=""otp-code"">{code}</div>
      </div>

      <p class=""urdu-text"">
        لیگل ساتھی پر آپ کا استقبال ہے۔ براہ کرم اپنے ای میل ایڈریس کی تصدیق کے لیے اوپر دیا گیا 6 ہندسوں کا کوڈ درج کریں۔
      </p>

      <p style=""font-size: 12px; color: #64748b; margin-top: 20px;"">
        ⚠️ This code is valid for <strong>5 minutes</strong>. If you did not request this verification, please disregard this email.
      </p>
    </div>
    <div class=""footer"">
      &copy; {DateTime.UtcNow.Year} Legal Saathi (Private) Limited. All rights reserved.<br/>
      Islamabad / Lahore / Karachi, Pakistan
    </div>
  </div>
</body>
</html>";

            await _emailService.SendEmailAsync(normalizedDest, subject, bodyHtml, ct);
        }

        return (true, $"OTP sent successfully to {destination}. Valid for 5 minutes.", 300);
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
