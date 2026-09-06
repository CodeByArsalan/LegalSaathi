namespace LegalSaathi.Api.Contracts.Signatures;

public record RequestSigningOtpDto(
    int UserDocumentId,
    string SignerName,
    string SignerCnic,
    string DestinationPhoneOrEmail);

public record RequestSigningOtpResponseDto(
    bool Success,
    string Message,
    string DestinationMasked,
    DateTime ExpiresAt);

public record SubmitSignatureDto(
    int UserDocumentId,
    string SignerName,
    string SignerCnic,
    string SignerRole,
    string? SignerPhone,
    string? SignerEmail,
    string SignatureBase64Image,
    string? OtpCode);

public record SignatureDetailDto(
    long SignatureId,
    int UserDocumentId,
    string SignerName,
    string SignerCnic,
    string SignerRole,
    string? SignerEmail,
    string? SignerPhone,
    string SignatureUri,
    bool IsOtpVerified,
    string? IpAddress,
    DateTime SignedAt);
