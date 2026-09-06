namespace LegalSaathi.Api.Domain.Entities;

public class Signature
{
    public long SignatureID { get; set; }
    public int SignatureId { get => (int)SignatureID; set => SignatureID = value; }
    public int UserDocument_ID { get; set; }
    public int UserDocumentId { get => UserDocument_ID; set => UserDocument_ID = value; }
    public string SignerName { get; set; } = string.Empty;
    public string SignerCnic { get; set; } = string.Empty;
    public string SignerRole { get; set; } = string.Empty;
    public string? SignerEmail { get; set; }
    public string? SignerPhone { get; set; }
    public string SignatureUri { get; set; } = string.Empty;
    public string SignatureImageUri { get => SignatureUri; set => SignatureUri = value; }
    public bool OtpVerified { get; set; }
    public bool IsOtpVerified { get => OtpVerified; set => OtpVerified = value; }
    public string? OtpCodeHash { get; set; }
    public string? IpAddress { get; set; }
    public string? UserAgent { get; set; }
    public DateTime SignedDateTime { get; set; } = DateTime.UtcNow;
    public DateTime SignedAt { get => SignedDateTime; set => SignedDateTime = value; }
}
