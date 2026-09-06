using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Documents;
using LegalSaathi.Api.Contracts.Lawyers;
using LegalSaathi.Api.Contracts.Ai;
using LegalSaathi.Api.Domain.Entities;
using LegalSaathi.Api.Infrastructure.Services;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging.Abstractions;
using Xunit;

namespace LegalSaathi.Api.Tests;

public class LawyerReviewTests
{
    private class FakeQueryRepo : IAIQueryRepository
    {
        public List<AiQuery> Queries { get; } = new();

        public Task<long> CreateQueryAsync(AiQuery query, CancellationToken cancellationToken = default)
        {
            query.QueryID = Queries.Count + 1;
            Queries.Add(query);
            return Task.FromResult(query.QueryID);
        }

        public Task<IReadOnlyList<AiQuery>> GetByDocumentIdAsync(int userDocumentId, CancellationToken cancellationToken = default)
        {
            var list = Queries.Where(q => q.UserDocument_ID == userDocumentId).ToList();
            return Task.FromResult<IReadOnlyList<AiQuery>>(list);
        }
    }

    private class FakeLawyerRepo : ILawyerRepository
    {
        public List<LawyerDto> Lawyers { get; } = new()
        {
            new LawyerDto(
                LawyerId: 1,
                UserId: 101,
                FullName: "Barrister Ahmed Ali Khan",
                Email: "ahmed.ali@paklaw.pk",
                PhoneNumber: "+92 300 1234567",
                BarCouncilNumber: "LHC-18921-2015",
                BarCouncilProvince: "Punjab",
                Specialization: "Real Estate & Tenancy",
                YearsOfExperience: 12,
                OfficeAddress: "Mall Road, Lahore",
                VerifiedStatus: true,
                Rating: 4.9m,
                TotalReviewsCompleted: 84,
                CreatedDateTime: DateTime.UtcNow),
            new LawyerDto(
                LawyerId: 2,
                UserId: 102,
                FullName: "Syeda Fatima Zaidi",
                Email: "fatima.zaidi@legaladvocates.pk",
                PhoneNumber: "+92 321 7654321",
                BarCouncilNumber: "SHC-98214-2017",
                BarCouncilProvince: "Sindh",
                Specialization: "Corporate & Commercial",
                YearsOfExperience: 9,
                OfficeAddress: "Clifton, Karachi",
                VerifiedStatus: true,
                Rating: 4.8m,
                TotalReviewsCompleted: 62,
                CreatedDateTime: DateTime.UtcNow)
        };

        public List<LawyerReviewDto> Reviews { get; } = new();

        public Task<IReadOnlyList<LawyerDto>> GetVerifiedLawyersAsync(string? province = null, string? specialization = null, CancellationToken ct = default)
        {
            var list = Lawyers.AsEnumerable();
            if (!string.IsNullOrWhiteSpace(province) && province != "all")
                list = list.Where(l => l.BarCouncilProvince.Equals(province, StringComparison.OrdinalIgnoreCase));
            if (!string.IsNullOrWhiteSpace(specialization) && specialization != "all")
                list = list.Where(l => l.Specialization.Equals(specialization, StringComparison.OrdinalIgnoreCase));

            return Task.FromResult<IReadOnlyList<LawyerDto>>(list.ToList());
        }

        public Task<LawyerDto?> GetLawyerByIdAsync(int lawyerId, CancellationToken ct = default)
            => Task.FromResult(Lawyers.FirstOrDefault(l => l.LawyerId == lawyerId));

        public Task<LawyerDto?> GetLawyerByUserIdAsync(int userId, CancellationToken ct = default)
            => Task.FromResult(Lawyers.FirstOrDefault(l => l.UserId == userId));

        public Task<long> CreateLawyerReviewAsync(int userDocumentId, int? lawyerId, string? notes, decimal fee, CancellationToken ct = default)
        {
            var id = Reviews.Count + 1;
            var lawyer = Lawyers.FirstOrDefault(l => l.LawyerId == lawyerId);

            Reviews.Add(new LawyerReviewDto(
                LawyerReviewId: id,
                UserDocumentId: userDocumentId,
                DocumentTitle: "Residential Tenancy Agreement",
                TemplateName: "Rent Agreement",
                LawyerId: lawyerId,
                LawyerName: lawyer?.FullName,
                LawyerSpecialization: lawyer?.Specialization,
                BarCouncilProvince: lawyer?.BarCouncilProvince,
                Notes: notes,
                AnnotatedPdfPath: null,
                ReviewFee: fee,
                Status: "Requested",
                StatusId: 1,
                RequestedDateTime: DateTime.UtcNow,
                AssignedDateTime: null,
                CompletedDateTime: null));

            return Task.FromResult((long)id);
        }

        public Task<LawyerReviewDto?> GetReviewByIdAsync(long reviewId, CancellationToken ct = default)
            => Task.FromResult(Reviews.FirstOrDefault(r => r.LawyerReviewId == reviewId));

        public Task<IReadOnlyList<LawyerReviewDto>> GetReviewsByUserAsync(int userId, CancellationToken ct = default)
            => Task.FromResult<IReadOnlyList<LawyerReviewDto>>(Reviews);

        public Task<IReadOnlyList<LawyerReviewDto>> GetReviewsByLawyerAsync(int lawyerId, CancellationToken ct = default)
            => Task.FromResult<IReadOnlyList<LawyerReviewDto>>(Reviews.Where(r => r.LawyerId == lawyerId).ToList());

        public Task<IReadOnlyList<LawyerReviewDto>> GetReviewsByDocumentAsync(int documentId, CancellationToken ct = default)
            => Task.FromResult<IReadOnlyList<LawyerReviewDto>>(Reviews.Where(r => r.UserDocumentId == documentId).ToList());

        public Task<bool> AssignLawyerAsync(long reviewId, int lawyerId, CancellationToken ct = default)
            => Task.FromResult(true);

        public Task<bool> UpdateReviewFeedbackAsync(long reviewId, int statusId, string notes, string? annotatedPdfPath, CancellationToken ct = default)
        {
            var rev = Reviews.FirstOrDefault(r => r.LawyerReviewId == reviewId);
            if (rev == null) return Task.FromResult(false);

            Reviews.Remove(rev);
            Reviews.Add(rev with
            {
                StatusId = statusId,
                Status = statusId == 4 ? "Approved" : "Completed",
                Notes = notes,
                AnnotatedPdfPath = annotatedPdfPath,
                CompletedDateTime = DateTime.UtcNow
            });
            return Task.FromResult(true);
        }
    }

    private class FakeUserDocRepo : IUserDocumentRepository
    {
        public int LastUpdatedStatusDocId { get; private set; }
        public int LastUpdatedStatusId { get; private set; }

        public Task<(int DocumentId, Guid DocumentGuid)> CreateAsync(int userId, int templateId, string title, string formAnswersJson, CancellationToken ct = default)
            => Task.FromResult((1, Guid.NewGuid()));

        public Task<DocumentDetailDto?> GetByIdAsync(int documentId, int? userId = null, CancellationToken ct = default)
        {
            return Task.FromResult<DocumentDetailDto?>(new DocumentDetailDto(
                UserDocumentId: documentId,
                DocumentGuid: Guid.NewGuid(),
                UserId: 42,
                TemplateId: 1,
                TemplateTitleEn: "Rent Agreement",
                TemplateTitleUr: "کرایہ نامہ",
                Title: "My Lahore Rent Agreement",
                FormAnswersJson: "{}",
                Status: "Draft",
                StatusId: 1,
                StoragePath: null,
                DocxStoragePath: null,
                DocumentHash: null,
                IsPaid: true,
                CreatedAt: DateTime.UtcNow,
                UpdatedAt: null,
                CompletedAt: null));
        }

        public Task<List<DocumentSummaryDto>> GetByUserAsync(int userId, CancellationToken ct = default)
            => Task.FromResult(new List<DocumentSummaryDto>());

        public Task<bool> UpdateAnswersAsync(int documentId, int userId, string formAnswersJson, CancellationToken ct = default)
            => Task.FromResult(true);

        public Task<bool> UpdateStatusAsync(int documentId, int statusId, string? storagePath = null, string? docxStoragePath = null, string? documentHash = null, CancellationToken ct = default)
        {
            LastUpdatedStatusDocId = documentId;
            LastUpdatedStatusId = statusId;
            return Task.FromResult(true);
        }
    }

    private class FakeAuditLogService : IAuditLogService
    {
        public List<string> Actions { get; } = new();

        public Task<long> LogAsync(int? userId, string action, string entityName, string? entityId = null, string? ipAddress = null, string? userAgent = null, string? oldValuesJson = null, string? newValuesJson = null, CancellationToken ct = default)
        {
            Actions.Add(action);
            return Task.FromResult(1L);
        }
    }

    [Fact]
    public async Task LawyerDirectory_ShouldFilterByProvinceAndSpecialization()
    {
        // Arrange
        var lawyerRepo = new FakeLawyerRepo();
        var docRepo = new FakeUserDocRepo();
        var audit = new FakeAuditLogService();
        var service = new LawyerReviewService(lawyerRepo, docRepo, audit, NullLogger<LawyerReviewService>.Instance);

        // Act
        var punjabLawyers = await service.GetVerifiedLawyersAsync("Punjab", "Real Estate & Tenancy");
        var sindhLawyers = await service.GetVerifiedLawyersAsync("Sindh", null);

        // Assert
        Assert.True(punjabLawyers.Succeeded);
        Assert.Single(punjabLawyers.Data!);
        Assert.Equal("Barrister Ahmed Ali Khan", punjabLawyers.Data![0].FullName);

        Assert.True(sindhLawyers.Succeeded);
        Assert.Single(sindhLawyers.Data!);
        Assert.Equal("Syeda Fatima Zaidi", sindhLawyers.Data![0].FullName);
    }

    [Fact]
    public async Task RequestReview_ShouldCreateFreeReviewAndSetDocumentStatusUnderReview()
    {
        // Arrange
        var lawyerRepo = new FakeLawyerRepo();
        var docRepo = new FakeUserDocRepo();
        var audit = new FakeAuditLogService();
        var service = new LawyerReviewService(lawyerRepo, docRepo, audit, NullLogger<LawyerReviewService>.Instance);

        var request = new RequestLawyerReviewRequest(
            UserDocumentId: 10,
            LawyerId: 1,
            Notes: "Please review security deposit clauses.");

        // Act
        var result = await service.RequestReviewAsync(userId: 42, request);

        // Assert
        Assert.True(result.Succeeded);
        Assert.NotNull(result.Data);
        Assert.Equal(0.00m, result.Data.ReviewFee);
        Assert.Equal(10, result.Data.UserDocumentId);
        Assert.Equal("Requested", result.Data.Status);
        Assert.Equal(5, docRepo.LastUpdatedStatusId);
        Assert.Contains("LAWYER_REVIEW_REQUESTED", audit.Actions);
    }

    [Fact]
    public async Task FreeAiAssistant_ShouldProvideBilingualPakistaniStatutes()
    {
        // Arrange
        var queryRepo = new FakeQueryRepo();
        var config = new ConfigurationBuilder().AddInMemoryCollection(new Dictionary<string, string?>
        {
            { "AiSettings:ApiUrl", "" }
        }).Build();

        var aiService = new FreeAiLegalAssistantService(
            queryRepo,
            new HttpClient(),
            config,
            NullLogger<FreeAiLegalAssistantService>.Instance);

        // Act 1: English Tenancy Query
        var enRes = await aiService.AskAssistantAsync(userId: 42, new AiAssistantRequest(
            Prompt: "What are the rules for tenant eviction under Punjab Rented Premises Act?",
            LanguageCode: "en"));

        // Act 2: Urdu Stamp Paper Query
        var urRes = await aiService.AskAssistantAsync(userId: 42, new AiAssistantRequest(
            Prompt: "اسٹامپ پیپر اور اسٹامپ ڈیوٹی کے بارے میں بتائیں",
            LanguageCode: "ur"));

        // Assert
        Assert.True(enRes.Succeeded);
        Assert.Contains("Punjab Rented Premises Act", enRes.Data!.Answer);

        Assert.True(urRes.Succeeded);
        Assert.Contains("اسٹامپ پیپر", urRes.Data!.Answer);
        Assert.Equal(2, queryRepo.Queries.Count);
    }
}
