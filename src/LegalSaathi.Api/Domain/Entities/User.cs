using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Domain.Entities;

public class User
{
    public int UserID { get; set; }
    public int UserId { get => UserID; set => UserID = value; }
    public string Name { get; set; } = string.Empty;
    public string FullName { get => Name; set => Name = value; }
    public string Email { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string PhoneNumber { get => Phone; set => Phone = value; }
    public string PasswordHash { get; set; } = string.Empty;
    public int? Role_ID { get; set; } = 1;
    public UserRole Role { get; set; } = UserRole.EndUser;
    public string? Cnic { get; set; }
    public bool IsEmailVerified { get; set; }
    public bool IsActive { get; set; } = true;
    public string? RefreshToken { get; set; }
    public DateTime? RefreshTokenExpiryDateTime { get; set; }
    public DateTime? RefreshTokenExpiryTime { get => RefreshTokenExpiryDateTime; set => RefreshTokenExpiryDateTime = value; }
    public DateTime CreatedDateTime { get; set; } = DateTime.UtcNow;
    public DateTime CreatedAt { get => CreatedDateTime; set => CreatedDateTime = value; }
    public DateTime? UpdatedDateTime { get; set; }
    public DateTime? UpdatedAt { get => UpdatedDateTime; set => UpdatedDateTime = value; }
}
