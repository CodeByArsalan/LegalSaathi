using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Documents;
using LegalSaathi.Api.Domain.Entities;
using LegalSaathi.Api.Infrastructure.Services;
using Microsoft.Extensions.Logging.Abstractions;
using Xunit;

namespace LegalSaathi.Api.Tests;

public class SignatureTests
{
    private class FakeSignatureRepo : ISignatureRepository
    {
        public List<Signature> Signatures { get; } = new();

        public Task<long> CreateSignatureAsync(Signature signature, CancellationToken cancellationToken = default)
        {
            signature.SignatureID = Signatures.Count + 1;
            Signatures.Add(signature);
            return Task.FromResult(signature.SignatureID);
        }

        public Task<IReadOnlyList<Signature>> GetByDocumentIdAsync(int userDocumentId, CancellationToken cancellationToken = default)
        {
            var list = Signatures.Where(s => s.UserDocument_ID == userDocumentId).ToList();
            return Task.FromResult<IReadOnlyList<Signature>>(list);
        }
    }

    private class FakeUserDocRepo : IUserDocumentRepository
    {
        public int LastUpdatedStatusId { get; private set; }
        public int DocId { get; set; } = 10;
        public int UId { get; set; } = 1;

        public Task<(int DocumentId, Guid DocumentGuid)> CreateAsync(int userId, int templateId, string title, string formAnswersJson, CancellationToken ct = default)
            => Task.FromResult((DocId, Guid.NewGuid()));

        public Task<DocumentDetailDto?> GetByIdAsync(int documentId, int? userId = null, CancellationToken ct = default)
        {
            if (documentId == DocId)
            {
                return Task.FromResult<DocumentDetailDto?>(new DocumentDetailDto(
                    UserDocumentId: DocId,
                    DocumentGuid: Guid.NewGuid(),
                    UserId: UId,
                    TemplateId: 1,
                    TemplateTitleEn: "Affidavit",
                    TemplateTitleUr: "بیان حلفی",
                    Title: "General Affidavit",
                    FormAnswersJson: "{}",
                    Status: "Draft",
                    StatusId: 1,
                    StoragePath: null,
                    DocxStoragePath: null,
                    DocumentHash: null,
                    IsPaid: true,
                    CreatedAt: DateTime.UtcNow,
                    UpdatedAt: null,
                    CompletedAt: null
                ));
            }
            return Task.FromResult<DocumentDetailDto?>(null);
        }

        public Task<List<DocumentSummaryDto>> GetByUserAsync(int userId, CancellationToken ct = default)
            => Task.FromResult(new List<DocumentSummaryDto>());

        public Task<bool> UpdateAnswersAsync(int documentId, int userId, string formAnswersJson, CancellationToken ct = default)
            => Task.FromResult(true);

        public Task<bool> UpdateStatusAsync(int documentId, int statusId, string? storagePath = null, string? docxStoragePath = null, string? documentHash = null, CancellationToken ct = default)
        {
            LastUpdatedStatusId = statusId;
            return Task.FromResult(true);
        }
    }

    private class FakeFileStorage : IFileStorageService
    {
        public Task DeleteFileAsync(string storagePath, CancellationToken cancellationToken = default) => Task.CompletedTask;
        public Task<byte[]> GetFileAsync(string storagePath, CancellationToken cancellationToken = default) => Task.FromResult(Array.Empty<byte>());
        public Task<string> SaveFileAsync(byte[] fileBytes, string fileName, string contentType, CancellationToken cancellationToken = default)
            => Task.FromResult("/vault/signatures/" + fileName);
    }

    private class FakeAuditLog : IAuditLogService
    {
        public Task<long> LogAsync(int? userId, string action, string entityName, string? entityId = null, string? ipAddress = null, string? userAgent = null, string? oldValuesJson = null, string? newValuesJson = null, CancellationToken ct = default)
            => Task.FromResult(1L);
    }

    private class FakeSmsService : ISmsService
    {
        public Task<bool> SendSmsAsync(string phoneNumber, string message, CancellationToken cancellationToken = default) => Task.FromResult(true);
    }

    private class FakeEmailService : IEmailService
    {
        public Task<bool> SendEmailAsync(string toEmail, string subject, string bodyHtml, CancellationToken cancellationToken = default) => Task.FromResult(true);
    }

    [Fact]
    public async Task SignatureService_ShouldSignDocument_And_UpdateStatusToSigned()
    {
        // Arrange
        var sigRepo = new FakeSignatureRepo();
        var docRepo = new FakeUserDocRepo();
        var otpService = new MemoryOtpService(NullLogger<MemoryOtpService>.Instance);
        var fileStorage = new FakeFileStorage();
        var auditLog = new FakeAuditLog();

        var service = new SignatureService(
            sigRepo,
            docRepo,
            otpService,
            fileStorage,
            auditLog,
            NullLogger<SignatureService>.Instance);

        var request = new SignDocumentRequest(
            UserDocumentId: 10,
            SignerName: "Muhammad Ali",
            SignerCnic: "35201-1234567-1",
            SignerRole: "Deponent",
            SignerPhone: "03001234567",
            SignerEmail: "ali@example.com",
            SignatureBase64Image: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==",
            OtpCode: null,
            IpAddress: "192.168.1.1",
            UserAgent: "Mozilla/5.0");

        // Act
        var result = await service.SignDocumentAsync(1, request);

        // Assert
        Assert.True(result.Succeeded);
        Assert.NotNull(result.Data);
        Assert.Equal("Muhammad Ali", result.Data.SignerName);
        Assert.Equal("35201-1234567-1", result.Data.SignerCnic);
        Assert.Equal(4, docRepo.LastUpdatedStatusId); // Status ID 4 = Signed
        Assert.Single(sigRepo.Signatures);
    }

    [Fact]
    public async Task SignatureService_RequestOtp_ShouldGenerateCode_And_Succeed()
    {
        // Arrange
        var sigRepo = new FakeSignatureRepo();
        var docRepo = new FakeUserDocRepo();
        var otpService = new MemoryOtpService(NullLogger<MemoryOtpService>.Instance);
        var fileStorage = new FakeFileStorage();
        var auditLog = new FakeAuditLog();

        var service = new SignatureService(
            sigRepo,
            docRepo,
            otpService,
            fileStorage,
            auditLog,
            NullLogger<SignatureService>.Instance);

        var req = new RequestOtpForSigningRequest(
            UserDocumentId: 10,
            SignerName: "Fatima Noor",
            SignerCnic: "35201-7654321-2",
            DestinationPhoneOrEmail: "03219876543");

        // Act
        var result = await service.RequestSigningOtpAsync(1, req);

        // Assert
        Assert.True(result.Succeeded);
        Assert.NotNull(result.Data);
        Assert.True(result.Data.Success);
        Assert.Contains("****", result.Data.DestinationMasked);
    }
}
