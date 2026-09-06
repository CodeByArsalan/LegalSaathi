using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Contracts.Auth;

public record RegisterRequest(
    string FullName,
    string Email,
    string PhoneNumber,
    string Password,
    string? Cnic,
    UserRole Role = UserRole.EndUser);

public record RegisterResponse(
    int UserId,
    string FullName,
    string Email,
    string PhoneNumber,
    string Role,
    bool RequiresEmailVerification,
    string Message);

public record VerifyEmailRequest(
    string Email,
    string OtpCode);

public record ResendVerificationRequest(
    string Email);

public record LoginRequest(
    string EmailOrPhone,
    string Password);

public record AuthResponse(
    int UserId,
    string FullName,
    string Email,
    string PhoneNumber,
    string Role,
    string? Cnic,
    string AccessToken,
    string RefreshToken,
    DateTime ExpiresAt);

public record RefreshTokenRequest(
    string AccessToken,
    string RefreshToken);

public record RevokeTokenRequest(
    string? RefreshToken);

public record UserProfileResponse(
    int UserId,
    string FullName,
    string Email,
    string PhoneNumber,
    string Role,
    int RoleId,
    string? Cnic,
    bool IsEmailVerified,
    bool IsActive,
    DateTime CreatedDateTime,
    DateTime? UpdatedDateTime);

public record UpdateProfileRequest(
    string FullName,
    string PhoneNumber,
    string? Cnic);

public record SendOtpRequest(
    string Destination,
    string Purpose); // "Register", "Login", "Signature", "PasswordReset"

public record SendOtpResponse(
    bool Success,
    string Message,
    int ExpirySeconds);

public record VerifyOtpRequest(
    string Destination,
    string OtpCode,
    string Purpose);

public record VerifyOtpResponse(
    bool Verified,
    string Message,
    string? VerificationToken);

