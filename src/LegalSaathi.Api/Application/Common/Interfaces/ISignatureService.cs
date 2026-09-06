using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Domain.Entities;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public record SignDocumentRequest(
    int UserDocumentId,
    string SignerName,
    string SignerCnic,
    string SignerRole,
    string? SignerPhone,
    string? SignerEmail,
    string SignatureBase64Image,
    string? OtpCode,
    string? IpAddress,
    string? UserAgent);

public record RequestOtpForSigningRequest(
    int UserDocumentId,
    string SignerName,
    string SignerCnic,
    string DestinationPhoneOrEmail);

public record RequestOtpForSigningResponse(
    bool Success,
    string Message,
    string DestinationMasked,
    DateTime ExpiresAt);

public interface ISignatureService
{
    Task<Result<RequestOtpForSigningResponse>> RequestSigningOtpAsync(
        int userId, 
        RequestOtpForSigningRequest request, 
        CancellationToken cancellationToken = default);

    Task<Result<Signature>> SignDocumentAsync(
        int userId, 
        SignDocumentRequest request, 
        CancellationToken cancellationToken = default);

    Task<Result<IReadOnlyList<Signature>>> GetDocumentSignaturesAsync(
        int userDocumentId, 
        int userId, 
        CancellationToken cancellationToken = default);

    Task<Result<bool>> VerifySignatureAuthenticityAsync(
        long signatureId, 
        CancellationToken cancellationToken = default);
}

public interface IEmailService
{
    Task<bool> SendEmailAsync(string toEmail, string subject, string bodyHtml, CancellationToken cancellationToken = default);
}

public interface ISmsService
{
    Task<bool> SendSmsAsync(string phoneNumber, string message, CancellationToken cancellationToken = default);
}

public interface IFileStorageService
{
    Task<string> SaveFileAsync(byte[] fileBytes, string fileName, string contentType, CancellationToken cancellationToken = default);
    Task<byte[]> GetFileAsync(string storagePath, CancellationToken cancellationToken = default);
    Task DeleteFileAsync(string storagePath, CancellationToken cancellationToken = default);
}

public interface ICurrentUserService
{
    int? UserId { get; }
    string? Email { get; }
    string? Role { get; }
    bool IsAuthenticated { get; }
    string? IpAddress { get; }
    string? UserAgent { get; }
}
