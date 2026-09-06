using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Contracts.Auth;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface IAuthService
{
    Task<Result<RegisterResponse>> RegisterAsync(RegisterRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default);
    Task<Result<AuthResponse>> VerifyEmailAsync(VerifyEmailRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default);
    Task<Result<SendOtpResponse>> ResendVerificationEmailAsync(ResendVerificationRequest request, CancellationToken ct = default);
    Task<Result<AuthResponse>> LoginAsync(LoginRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default);
    Task<Result<AuthResponse>> RefreshTokenAsync(RefreshTokenRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default);
    Task<Result> RevokeTokenAsync(int userId, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default);
    Task<Result<UserProfileResponse>> GetProfileAsync(int userId, CancellationToken ct = default);
    Task<Result<UserProfileResponse>> UpdateProfileAsync(int userId, UpdateProfileRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default);
    Task<Result<SendOtpResponse>> SendOtpAsync(SendOtpRequest request, CancellationToken ct = default);
    Task<Result<VerifyOtpResponse>> VerifyOtpAsync(VerifyOtpRequest request, CancellationToken ct = default);
}
