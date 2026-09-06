using System.Text.RegularExpressions;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Contracts.Auth;
using LegalSaathi.Api.Domain.Entities;
using LegalSaathi.Api.Domain.Enums;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

public class AuthService : IAuthService
{
    private readonly IUserRepository _userRepository;
    private readonly IPasswordHasher _passwordHasher;
    private readonly IJwtTokenGenerator _jwtTokenGenerator;
    private readonly IOtpService _otpService;
    private readonly IAuditLogService _auditLogService;
    private readonly ILogger<AuthService> _logger;

    private static readonly Regex EmailRegex = new(@"^[^@s]+@[^@s]+.[^@s]+$", RegexOptions.Compiled | RegexOptions.IgnoreCase);
    private static readonly Regex PakistanPhoneRegex = new(@"^((+92)|(0092)|(0))?3[0-9]{9}$", RegexOptions.Compiled);
    private static readonly Regex PakistanCnicRegex = new(@"^([0-9]{5}-[0-9]{7}-[0-9]|[0-9]{13})$", RegexOptions.Compiled);

    public AuthService(
        IUserRepository userRepository,
        IPasswordHasher passwordHasher,
        IJwtTokenGenerator jwtTokenGenerator,
        IOtpService otpService,
        IAuditLogService auditLogService,
        ILogger<AuthService> logger)
    {
        _userRepository = userRepository;
        _passwordHasher = passwordHasher;
        _jwtTokenGenerator = jwtTokenGenerator;
        _otpService = otpService;
        _auditLogService = auditLogService;
        _logger = logger;
    }

    public async Task<Result<AuthResponse>> RegisterAsync(RegisterRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default)
    {
        // 1. Validation
        if (string.IsNullOrWhiteSpace(request.FullName) || request.FullName.Trim().Length < 2)
        {
            return Result<AuthResponse>.Failure("Full name is required and must be at least 2 characters.");
        }

        if (string.IsNullOrWhiteSpace(request.Email) || !EmailRegex.IsMatch(request.Email.Trim()))
        {
            return Result<AuthResponse>.Failure("A valid email address is required.");
        }

        var normalizedPhone = NormalizePhoneNumber(request.PhoneNumber);
        if (string.IsNullOrWhiteSpace(normalizedPhone) || !PakistanPhoneRegex.IsMatch(normalizedPhone))
        {
            return Result<AuthResponse>.Failure("A valid Pakistani mobile number is required (e.g. 03001234567 or +923001234567).");
        }

        if (string.IsNullOrWhiteSpace(request.Password) || request.Password.Length < 8)
        {
            return Result<AuthResponse>.Failure("Password must be at least 8 characters long.");
        }

        string? formattedCnic = null;
        if (!string.IsNullOrWhiteSpace(request.Cnic))
        {
            var cleanedCnic = request.Cnic.Trim();
            if (!PakistanCnicRegex.IsMatch(cleanedCnic))
            {
                return Result<AuthResponse>.Failure("CNIC must follow the 13-digit Pakistani format (e.g. 35201-1234567-1).");
            }
            formattedCnic = FormatCnic(cleanedCnic);
        }

        // 2. Check for duplicate email or phone
        var existingUser = await _userRepository.GetByEmailOrPhoneAsync(request.Email.Trim(), ct);
        if (existingUser != null)
        {
            return Result<AuthResponse>.Failure("An account with this email address already exists.");
        }

        var existingPhoneUser = await _userRepository.GetByEmailOrPhoneAsync(normalizedPhone, ct);
        if (existingPhoneUser != null)
        {
            return Result<AuthResponse>.Failure("An account with this phone number already exists.");
        }

        // 3. Hash password and persist user
        var passwordHash = _passwordHasher.HashPassword(request.Password);
        var roleId = (int)request.Role;

        var user = new User
        {
            Name = request.FullName.Trim(),
            Email = request.Email.Trim().ToLowerInvariant(),
            Phone = normalizedPhone,
            PasswordHash = passwordHash,
            Role_ID = roleId,
            Role = request.Role,
            Cnic = formattedCnic,
            IsEmailVerified = false,
            IsActive = true,
            CreatedDateTime = DateTime.UtcNow
        };

        var userId = await _userRepository.CreateUserAsync(user, ct);
        user.UserID = userId;

        // 4. Generate JWT & Refresh Tokens
        var accessToken = _jwtTokenGenerator.GenerateAccessToken(user);
        var refreshToken = _jwtTokenGenerator.GenerateRefreshToken();
        var refreshExpiry = DateTime.UtcNow.AddDays(7);

        await _userRepository.UpdateRefreshTokenAsync(userId, refreshToken, refreshExpiry, ct);

        // 5. Audit Log
        await _auditLogService.LogAsync(
            userId: userId,
            action: "USER_REGISTER",
            entityName: "Users",
            entityId: userId.ToString(),
            ipAddress: ipAddress,
            userAgent: userAgent,
            newValuesJson: System.Text.Json.JsonSerializer.Serialize(new { user.Email, user.Phone, Role = request.Role.ToString(), user.Cnic }),
            ct: ct);

        var expiresAt = DateTime.UtcNow.AddMinutes(60);
        return Result<AuthResponse>.Success(new AuthResponse(
            UserId: userId,
            FullName: user.Name,
            Email: user.Email,
            PhoneNumber: user.Phone,
            Role: request.Role.ToString(),
            Cnic: user.Cnic,
            AccessToken: accessToken,
            RefreshToken: refreshToken,
            ExpiresAt: expiresAt));
    }

    public async Task<Result<AuthResponse>> LoginAsync(LoginRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(request.EmailOrPhone) || string.IsNullOrWhiteSpace(request.Password))
        {
            return Result<AuthResponse>.Failure("Email/Phone and password are required.");
        }

        var identifier = request.EmailOrPhone.Trim();
        var normalizedPhone = NormalizePhoneNumber(identifier);

        var user = await _userRepository.GetByEmailOrPhoneAsync(identifier, ct);
        if (user == null && !string.Equals(identifier, normalizedPhone, StringComparison.OrdinalIgnoreCase))
        {
            user = await _userRepository.GetByEmailOrPhoneAsync(normalizedPhone, ct);
        }

        if (user == null)
        {
            return Result<AuthResponse>.Failure("Invalid email/phone or password.");
        }

        if (!user.IsActive)
        {
            return Result<AuthResponse>.Failure("Your account has been deactivated. Please contact Legal Saathi support.");
        }

        if (!_passwordHasher.VerifyPassword(request.Password, user.PasswordHash))
        {
            return Result<AuthResponse>.Failure("Invalid email/phone or password.");
        }

        // Generate Tokens
        var accessToken = _jwtTokenGenerator.GenerateAccessToken(user);
        var refreshToken = _jwtTokenGenerator.GenerateRefreshToken();
        var refreshExpiry = DateTime.UtcNow.AddDays(7);

        await _userRepository.UpdateRefreshTokenAsync(user.UserID, refreshToken, refreshExpiry, ct);

        // Audit Log
        await _auditLogService.LogAsync(
            userId: user.UserID,
            action: "USER_LOGIN",
            entityName: "Users",
            entityId: user.UserID.ToString(),
            ipAddress: ipAddress,
            userAgent: userAgent,
            ct: ct);

        var expiresAt = DateTime.UtcNow.AddMinutes(60);
        return Result<AuthResponse>.Success(new AuthResponse(
            UserId: user.UserID,
            FullName: user.Name,
            Email: user.Email,
            PhoneNumber: user.Phone,
            Role: user.Role.ToString(),
            Cnic: user.Cnic,
            AccessToken: accessToken,
            RefreshToken: refreshToken,
            ExpiresAt: expiresAt));
    }

    public async Task<Result<AuthResponse>> RefreshTokenAsync(RefreshTokenRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(request.AccessToken) || string.IsNullOrWhiteSpace(request.RefreshToken))
        {
            return Result<AuthResponse>.Failure("Access token and refresh token are required.");
        }

        var principal = _jwtTokenGenerator.GetPrincipalFromExpiredToken(request.AccessToken);
        if (principal == null)
        {
            return Result<AuthResponse>.Failure("Invalid token.");
        }

        var userIdClaim = principal.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value
                          ?? principal.FindFirst(System.IdentityModel.Tokens.Jwt.JwtRegisteredClaimNames.Sub)?.Value;

        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
        {
            return Result<AuthResponse>.Failure("Invalid token payload.");
        }

        var user = await _userRepository.GetByEmailOrPhoneAsync(principal.FindFirst(System.Security.Claims.ClaimTypes.Email)?.Value ?? "", ct);
        if (user == null || user.UserID != userId)
        {
            user = await _userRepository.GetByIdAsync(userId, ct);
        }

        if (user == null || !user.IsActive)
        {
            return Result<AuthResponse>.Failure("User account not found or inactive.");
        }

        if (string.IsNullOrEmpty(user.RefreshToken) || 
            !string.Equals(user.RefreshToken, request.RefreshToken, StringComparison.Ordinal) ||
            user.RefreshTokenExpiryDateTime == null || 
            user.RefreshTokenExpiryDateTime <= DateTime.UtcNow)
        {
            return Result<AuthResponse>.Failure("Invalid or expired refresh token. Please sign in again.");
        }

        // Generate new token pair (sliding rotation)
        var newAccessToken = _jwtTokenGenerator.GenerateAccessToken(user);
        var newRefreshToken = _jwtTokenGenerator.GenerateRefreshToken();
        var refreshExpiry = DateTime.UtcNow.AddDays(7);

        await _userRepository.UpdateRefreshTokenAsync(user.UserID, newRefreshToken, refreshExpiry, ct);

        var expiresAt = DateTime.UtcNow.AddMinutes(60);
        return Result<AuthResponse>.Success(new AuthResponse(
            UserId: user.UserID,
            FullName: user.Name,
            Email: user.Email,
            PhoneNumber: user.Phone,
            Role: user.Role.ToString(),
            Cnic: user.Cnic,
            AccessToken: newAccessToken,
            RefreshToken: newRefreshToken,
            ExpiresAt: expiresAt));
    }

    public async Task<Result> RevokeTokenAsync(int userId, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default)
    {
        await _userRepository.UpdateRefreshTokenAsync(userId, "", DateTime.UtcNow, ct);

        await _auditLogService.LogAsync(
            userId: userId,
            action: "TOKEN_REVOKED",
            entityName: "Users",
            entityId: userId.ToString(),
            ipAddress: ipAddress,
            userAgent: userAgent,
            ct: ct);

        return Result.Success();
    }

    public async Task<Result<UserProfileResponse>> GetProfileAsync(int userId, CancellationToken ct = default)
    {
        var user = await _userRepository.GetByIdAsync(userId, ct);
        if (user == null)
        {
            return Result<UserProfileResponse>.Failure("User not found.");
        }

        return Result<UserProfileResponse>.Success(new UserProfileResponse(
            UserId: user.UserID,
            FullName: user.Name,
            Email: user.Email,
            PhoneNumber: user.Phone,
            Role: user.Role.ToString(),
            RoleId: user.Role_ID ?? (int)user.Role,
            Cnic: user.Cnic,
            IsEmailVerified: user.IsEmailVerified,
            IsActive: user.IsActive,
            CreatedDateTime: user.CreatedDateTime,
            UpdatedDateTime: user.UpdatedDateTime));
    }

    public async Task<Result<UserProfileResponse>> UpdateProfileAsync(int userId, UpdateProfileRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(request.FullName) || request.FullName.Trim().Length < 2)
        {
            return Result<UserProfileResponse>.Failure("Full name must be at least 2 characters.");
        }

        var normalizedPhone = NormalizePhoneNumber(request.PhoneNumber);
        if (string.IsNullOrWhiteSpace(normalizedPhone) || !PakistanPhoneRegex.IsMatch(normalizedPhone))
        {
            return Result<UserProfileResponse>.Failure("A valid Pakistani mobile number is required.");
        }

        string? formattedCnic = null;
        if (!string.IsNullOrWhiteSpace(request.Cnic))
        {
            var cleaned = request.Cnic.Trim();
            if (!PakistanCnicRegex.IsMatch(cleaned))
            {
                return Result<UserProfileResponse>.Failure("CNIC must follow the 13-digit Pakistani format.");
            }
            formattedCnic = FormatCnic(cleaned);
        }

        var existingUser = await _userRepository.GetByIdAsync(userId, ct);
        if (existingUser == null)
        {
            return Result<UserProfileResponse>.Failure("User not found.");
        }

        var oldValues = System.Text.Json.JsonSerializer.Serialize(new { existingUser.Name, existingUser.Phone, existingUser.Cnic });

        await _userRepository.UpdateUserAsync(userId, request.FullName.Trim(), normalizedPhone, formattedCnic, ct);

        var updatedUser = await _userRepository.GetByIdAsync(userId, ct);

        var newValues = System.Text.Json.JsonSerializer.Serialize(new { Name = request.FullName.Trim(), Phone = normalizedPhone, Cnic = formattedCnic });

        await _auditLogService.LogAsync(
            userId: userId,
            action: "USER_PROFILE_UPDATE",
            entityName: "Users",
            entityId: userId.ToString(),
            ipAddress: ipAddress,
            userAgent: userAgent,
            oldValuesJson: oldValues,
            newValuesJson: newValues,
            ct: ct);

        return Result<UserProfileResponse>.Success(new UserProfileResponse(
            UserId: updatedUser!.UserID,
            FullName: updatedUser.Name,
            Email: updatedUser.Email,
            PhoneNumber: updatedUser.Phone,
            Role: updatedUser.Role.ToString(),
            RoleId: updatedUser.Role_ID ?? (int)updatedUser.Role,
            Cnic: updatedUser.Cnic,
            IsEmailVerified: updatedUser.IsEmailVerified,
            IsActive: updatedUser.IsActive,
            CreatedDateTime: updatedUser.CreatedDateTime,
            UpdatedDateTime: updatedUser.UpdatedDateTime));
    }

    public async Task<Result<SendOtpResponse>> SendOtpAsync(SendOtpRequest request, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(request.Destination))
        {
            return Result<SendOtpResponse>.Failure("Destination (Phone or Email) is required.");
        }

        var (success, message, expiry) = await _otpService.SendOtpAsync(request.Destination, request.Purpose, ct);
        if (!success)
        {
            return Result<SendOtpResponse>.Failure(message);
        }

        return Result<SendOtpResponse>.Success(new SendOtpResponse(success, message, expiry));
    }

    public async Task<Result<VerifyOtpResponse>> VerifyOtpAsync(VerifyOtpRequest request, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(request.Destination) || string.IsNullOrWhiteSpace(request.OtpCode))
        {
            return Result<VerifyOtpResponse>.Failure("Destination and OTP code are required.");
        }

        var (verified, message, token) = await _otpService.VerifyOtpAsync(request.Destination, request.OtpCode, request.Purpose, ct);
        if (!verified)
        {
            return Result<VerifyOtpResponse>.Failure(message);
        }

        return Result<VerifyOtpResponse>.Success(new VerifyOtpResponse(verified, message, token));
    }

    private static string NormalizePhoneNumber(string phone)
    {
        if (string.IsNullOrWhiteSpace(phone)) return string.Empty;
        var cleaned = Regex.Replace(phone, @"[s-]", "");
        if (cleaned.StartsWith("+92")) cleaned = "0" + cleaned[3..];
        else if (cleaned.StartsWith("0092")) cleaned = "0" + cleaned[4..];
        else if (cleaned.StartsWith("92")) cleaned = "0" + cleaned[2..];
        return cleaned;
    }

    private static string FormatCnic(string cnic)
    {
        var digits = Regex.Replace(cnic, @"[^d]", "");
        if (digits.Length == 13)
        {
            return $"{digits[..5]}-{digits.Substring(5, 7)}-{digits[12]}";
        }
        return cnic;
    }
}
