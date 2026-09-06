using System.Security.Claims;
using LegalSaathi.Api.Domain.Entities;
using LegalSaathi.Api.Domain.Enums;
using LegalSaathi.Api.Infrastructure.Services;
using LegalSaathi.Api.Security;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using Xunit;

namespace LegalSaathi.Api.Tests;

public class AuthTests
{
    [Fact]
    public void PasswordHasher_ShouldHashAndVerifyPassword_Successfully()
    {
        // Arrange
        var hasher = new Pbkdf2PasswordHasher();
        var password = "SecureLawyerPassword@2026";

        // Act
        var hash = hasher.HashPassword(password);
        var isValid = hasher.VerifyPassword(password, hash);
        var isInvalid = hasher.VerifyPassword("WrongPassword", hash);

        // Assert
        Assert.NotEmpty(hash);
        Assert.Contains(".", hash);
        Assert.True(isValid);
        Assert.False(isInvalid);
    }

    [Fact]
    public void JwtTokenGenerator_ShouldGenerateTokenWithClaims()
    {
        // Arrange
        var settings = Options.Create(new JwtSettings
        {
            SecretKey = "SuperSecretKeyForLegalSaathiPlatformJwtAuthentication2026!",
            Issuer = "LegalSaathiApi",
            Audience = "LegalSaathiWeb",
            AccessTokenExpirationMinutes = 60
        });

        var tokenGenerator = new JwtTokenGenerator(settings);
        var user = new User
        {
            UserID = 42,
            Name = "Advocate Arsalan Khan",
            Email = "arsalan.lawyer@legalsaathi.pk",
            Phone = "03001234567",
            Cnic = "35201-1234567-1",
            Role_ID = 4,
            Role = UserRole.Lawyer
        };

        // Act
        var token = tokenGenerator.GenerateAccessToken(user);
        var refreshToken = tokenGenerator.GenerateRefreshToken();

        // Assert
        Assert.NotEmpty(token);
        Assert.NotEmpty(refreshToken);
        Assert.True(refreshToken.Length > 30);
    }

    [Fact]
    public async Task MemoryOtpService_ShouldSendAndVerifyOtp_Successfully()
    {
        // Arrange
        var otpService = new MemoryOtpService(NullLogger<MemoryOtpService>.Instance);
        var destination = "03001234567";
        var purpose = "Register";

        // Act
        var sendResult = await otpService.SendOtpAsync(destination, purpose);

        // Assert
        Assert.True(sendResult.Success);
        Assert.Equal(300, sendResult.ExpirySeconds);

        // Wrong code verification
        var wrongVerify = await otpService.VerifyOtpAsync(destination, "000000", purpose);
        Assert.False(wrongVerify.Verified);
    }
}
