using LegalSaathi.Api.Domain.Entities;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface IUserRepository
{
    Task<int> CreateUserAsync(User user, CancellationToken ct = default);
    Task<User?> GetByIdAsync(int userId, CancellationToken ct = default);
    Task<User?> GetByEmailAsync(string email, CancellationToken ct = default);
    Task<User?> GetByEmailOrPhoneAsync(string identifier, CancellationToken ct = default);
    Task<bool> UpdateUserAsync(int userId, string name, string phone, string? cnic, CancellationToken ct = default);
    Task<bool> UpdateRefreshTokenAsync(int userId, string refreshToken, DateTime expiryTime, CancellationToken ct = default);
}
