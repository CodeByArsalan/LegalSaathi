using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Domain.Entities;
using LegalSaathi.Api.Domain.Enums;
using LegalSaathi.Api.Security;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;

namespace LegalSaathi.Api.Infrastructure.Services;

public class JwtTokenGenerator : IJwtTokenGenerator
{
    private readonly JwtSettings _jwtSettings;

    public JwtTokenGenerator(IOptions<JwtSettings> jwtSettings)
    {
        _jwtSettings = jwtSettings.Value;
    }

    public string GenerateAccessToken(User user)
    {
        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.UTF8.GetBytes(
            string.IsNullOrEmpty(_jwtSettings.SecretKey)
                ? "LegalSaathi_Default_Fallback_Key_For_Development_Only_Must_Be_Long_2026!"
                : _jwtSettings.SecretKey);

        var roleName = user.Role switch
        {
            UserRole.SuperAdmin => UserRoleNames.SuperAdmin,
            UserRole.EndUser => UserRoleNames.EndUser,
            UserRole.CorporateAdmin => UserRoleNames.CorporateAdmin,
            UserRole.Lawyer => UserRoleNames.Lawyer,
            _ => UserRoleNames.EndUser
        };

        var claims = new List<Claim>
        {
            new(JwtRegisteredClaimNames.Sub, user.UserID.ToString()),
            new(JwtRegisteredClaimNames.Email, user.Email),
            new(JwtRegisteredClaimNames.Name, user.Name),
            new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new(ClaimTypes.NameIdentifier, user.UserID.ToString()),
            new(ClaimTypes.Name, user.Name),
            new(ClaimTypes.Email, user.Email),
            new(ClaimTypes.MobilePhone, user.Phone),
            new(ClaimTypes.Role, roleName),
            new("role_id", (user.Role_ID ?? (int)user.Role).ToString())
        };

        if (!string.IsNullOrWhiteSpace(user.Cnic))
        {
            claims.Add(new Claim("cnic", user.Cnic));
        }

        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(claims),
            Expires = DateTime.UtcNow.AddMinutes(_jwtSettings.AccessTokenExpirationMinutes > 0 ? _jwtSettings.AccessTokenExpirationMinutes : 60),
            Issuer = _jwtSettings.Issuer,
            Audience = _jwtSettings.Audience,
            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
        };

        var token = tokenHandler.CreateToken(tokenDescriptor);
        return tokenHandler.WriteToken(token);
    }

    public string GenerateRefreshToken()
    {
        var randomBytes = new byte[64];
        using var rng = RandomNumberGenerator.Create();
        rng.GetBytes(randomBytes);
        return Convert.ToBase64String(randomBytes);
    }

    public ClaimsPrincipal? GetPrincipalFromExpiredToken(string token)
    {
        var tokenValidationParameters = new TokenValidationParameters
        {
            ValidateAudience = false,
            ValidateIssuer = false,
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(
                string.IsNullOrEmpty(_jwtSettings.SecretKey)
                    ? "LegalSaathi_Default_Fallback_Key_For_Development_Only_Must_Be_Long_2026!"
                    : _jwtSettings.SecretKey)),
            ValidateLifetime = false // deliberately false to read expired tokens during refresh exchange
        };

        var tokenHandler = new JwtSecurityTokenHandler();
        try
        {
            var principal = tokenHandler.ValidateToken(token, tokenValidationParameters, out SecurityToken securityToken);
            if (securityToken is not JwtSecurityToken jwtSecurityToken || 
                !jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha256, StringComparison.InvariantCultureIgnoreCase))
            {
                return null;
            }

            return principal;
        }
        catch
        {
            return null;
        }
    }
}
