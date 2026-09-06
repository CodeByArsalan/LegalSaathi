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

    private static readonly Regex EmailRegex = new(@"^[^@\s]+@[^@\s]+\.[^@\s]+$", RegexOptions.Compiled | RegexOptions.IgnoreCase);
    private static readonly Regex PakistanPhoneRegex = new(@"^((\+92)|(0092)|(0))?3[0-9]{9}$", RegexOptions.Compiled);
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

    public async Task<Result<RegisterResponse>> RegisterAsync(RegisterRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default)
    {
        // 1. Validation
        if (string.IsNullOrWhiteSpace(request.FullName) || request.FullName.Trim().Length < 2)
        {
            return Result<RegisterResponse>.Failure("Full name is required and must be at least 2 characters.");
        }

        if (string.IsNullOrWhiteSpace(request.Email) || !EmailRegex.IsMatch(request.Email.Trim()))
        {
            return Result<RegisterResponse>.Failure("A valid email address is required.");
        }

        var normalizedPhone = NormalizePhoneNumber(request.PhoneNumber);
        if (string.IsNullOrWhiteSpace(normalizedPhone) || !PakistanPhoneRegex.IsMatch(normalizedPhone))
        {
            return Result<RegisterResponse>.Failure("A valid Pakistani mobile number is required (e.g. 03001234567 or +923001234567).");
        }

        if (string.IsNullOrWhiteSpace(request.Password) || request.Password.Length < 8)
        {
            return Result<RegisterResponse>.Failure("Password must be at least 8 characters long.");
        }

        string? formattedCnic = null;
        if (!string.IsNullOrWhiteSpace(request.Cnic))
        {
            var cleanedCnic = request.Cnic.Trim();
            if (!PakistanCnicRegex.IsMatch(cleanedCnic))
            {
                return Result<RegisterResponse>.Failure("CNIC must follow the 13-digit Pakistani format (e.g. 35201-1234567-1).");
            }
            formattedCnic = FormatCnic(cleanedCnic);
        }

        // 2. Check for duplicate email or phone
        var existingUser = await _userRepository.GetByEmailOrPhoneAsync(request.Email.Trim(), ct);
        if (existingUser != null)
        {
            return Result<RegisterResponse>.Failure("An account with this email address already exists.");
        }

        var existingPhoneUser = await _userRepository.GetByEmailOrPhoneAsync(normalizedPhone, ct);
        if (existingPhoneUser != null)
        {
            return Result<RegisterResponse>.Failure("An account with this phone number already exists.");
        }

        // 3. Hash password and persist user with IsEmailVerified = false
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

        // 4. Generate & Send Email Verification OTP
        await _otpService.SendOtpAsync(user.Email, "EmailVerification", ct);

        // 5. Audit Log
        await _auditLogService.LogAsync(
            userId: userId,
            action: "USER_REGISTER",
            entityName: "Users",
            entityId: userId.ToString(),
            ipAddress: ipAddress,
            userAgent: userAgent,
            newValuesJson: System.Text.Json.JsonSerializer.Serialize(new { user.Email, user.Phone, Role = request.Role.ToString(), user.Cnic, IsEmailVerified = false }),
            ct: ct);

        return Result<RegisterResponse>.Success(new RegisterResponse(
            UserId: userId,
            FullName: user.Name,
            Email: user.Email,
            PhoneNumber: user.Phone,
            Role: request.Role.ToString(),
            RequiresEmailVerification: true,
            Message: $"Registration successful! A 6-digit verification code has been sent to {user.Email}."));
    }

    public async Task<Result<AuthResponse>> VerifyEmailAsync(VerifyEmailRequest request, string? ipAddress = null, string? userAgent = null, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(request.Email) || string.IsNullOrWhiteSpace(request.OtpCode))
        {
            return Result<AuthResponse>.Failure("Email address and 6-digit OTP code are required.");
        }

        var email = request.Email.Trim().ToLowerInvariant();
        var user = await _userRepository.GetByEmailAsync(email, ct);
        if (user == null)
        {
            return Result<AuthResponse>.Failure("No account found with this email address.");
        }

        // Verify OTP
        var (verified, otpMessage, _) = await _otpService.VerifyOtpAsync(email, request.OtpCode.Trim(), "EmailVerification", ct);
        if (!verified)
        {
            return Result<AuthResponse>.Failure(otpMessage, "InvalidOtp");
        }

        // Mark Email as verified in database
        await _userRepository.VerifyEmailAsync(user.UserID, ct);
        user.IsEmailVerified = true;

        // Generate JWT Tokens for verified user
        var accessToken = _jwtTokenGenerator.GenerateAccessToken(user);
        var refreshToken = _jwtTokenGenerator.GenerateRefreshToken();
        var refreshExpiry = DateTime.UtcNow.AddDays(7);

        await _userRepository.UpdateRefreshTokenAsync(user.UserID, refreshToken, refreshExpiry, ct);

        // Audit Log
        await _auditLogService.LogAsync(
            userId: user.UserID,
            action: "EMAIL_VERIFIED",
            entityName: "Users",
            entityId: user.UserID.ToString(),
            ipAddress: ipAddress,
            userAgent: userAgent,
            newValuesJson: System.Text.Json.JsonSerializer.Serialize(new { user.Email, IsEmailVerified = true, VerifiedAt = DateTime.UtcNow }),
            ct: ct);

        var expiresAt = DateTime.UtcNow.AddMinutes(15);
        return Result<AuthResponse>.Success(new AuthResponse(
            UserId: user.UserID,
            FullName: user.Name,
            Email: user.Email,
            PhoneNumber: user.Phone,
            Role: user.Role.ToString(),
            Cnic: user.Cnic,
            AccessToken: accessToken,
            RefreshToken: refreshToken,
            ExpiresAt: expiresAt),
            "Email verified successfully. Welcome to Legal Saathi!");
    }

    public async Task<Result<SendOtpResponse>> ResendVerificationEmailAsync(ResendVerificationRequest request, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(request.Email))
        {
            return Result<SendOtpResponse>.Failure("Email address is required.");
        }

        var email = request.Email.Trim().ToLowerInvariant();
        var user = await _userRepository.GetByEmailAsync(email, ct);
        if (user == null)
        {
            return Result<SendOtpResponse>.Failure("No account found with this email address.");
        }

        if (user.IsEmailVerified)
        {
            return Result<SendOtpResponse>.Failure("This email address is already verified. You can log in directly.");
        }

        var (success, message, expiry) = await _otpService.SendOtpAsync(user.Email, "EmailVerification", ct);
        if (!success)
        {
            return Result<SendOtpResponse>.Failure(message);
        }

        return Result<SendOtpResponse>.Success(new SendOtpResponse(success, $"Verification code sent to {user.Email}.", expiry));
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

        // Email Verification Guard: Prevent login if email is not verified
        if (!user.IsEmailVerified)
        {
            // Automatically trigger fresh OTP for the user
            await _otpService.SendOtpAsync(user.Email, "EmailVerification", ct);
            return Result<AuthResponse>.Failure(
                $"Your email address ({user.Email}) has not been verified yet. A 6-digit verification OTP has been sent to your email. Please verify your email before logging in.",
                "EmailNotVerified");
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

        var expiresAt = DateTime.UtcNow.AddMinutes(15);
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
        if (string.IsNullOrWhiteSpace(request.RefreshToken))
        {
            return Result<AuthResponse>.Failure("Refresh token is required.");
        }

        var incomingRefreshToken = request.RefreshToken.Trim();
        User? user = null;

        // If access token was supplied, try reading user claims from it
        if (!string.IsNullOrWhiteSpace(request.AccessToken))
        {
            var principal = _jwtTokenGenerator.GetPrincipalFromExpiredToken(request.AccessToken);
            if (principal != null)
            {
                var userIdClaim = principal.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value
                                  ?? principal.FindFirst(System.IdentityModel.Tokens.Jwt.JwtRegisteredClaimNames.Sub)?.Value;

                if (!string.IsNullOrEmpty(userIdClaim) && int.TryParse(userIdClaim, out int userId))
                {
                    user = await _userRepository.GetByIdAsync(userId, ct);
                }
            }
        }

        // If user wasn't resolved from access token, lookup directly by refresh token in database
        if (user == null)
        {
            user = await _userRepository.GetByRefreshTokenAsync(incomingRefreshToken, ct);
        }

        if (user == null || !user.IsActive)
        {
            return Result<AuthResponse>.Failure("User account not found, deactivated, or invalid session.");
        }

        if (string.IsNullOrEmpty(user.RefreshToken) || 
            !string.Equals(user.RefreshToken, incomingRefreshToken, StringComparison.Ordinal) ||
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

        var expiresAt = DateTime.UtcNow.AddMinutes(15);
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
        var cleaned = Regex.Replace(phone, @"[\s\-]", "");
        if (cleaned.StartsWith("+92")) cleaned = "0" + cleaned[3..];
        else if (cleaned.StartsWith("0092")) cleaned = "0" + cleaned[4..];
        else if (cleaned.StartsWith("92") && cleaned.Length == 12) cleaned = "0" + cleaned[2..];
        else if (!cleaned.StartsWith("0") && cleaned.Length == 10 && cleaned.StartsWith("3")) cleaned = "0" + cleaned;
        return cleaned;
    }

    private static string FormatCnic(string cnic)
    {
        var digits = Regex.Replace(cnic, @"[^\d]", "");
        if (digits.Length == 13)
        {
            return $"{digits[..5]}-{digits.Substring(5, 7)}-{digits[12]}";
        }
        return cnic;
    }
}
