using System.Text.Json;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Documents;
using LegalSaathi.Api.Contracts.Templates;
using LegalSaathi.Api.Domain.Entities;
using LegalSaathi.Api.Infrastructure.Services;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging.Abstractions;
using Xunit;

namespace LegalSaathi.Api.Tests;

public class AIAssistantTests
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

    private class FakeUserDocRepo : IUserDocumentRepository
    {
        public Task<(int DocumentId, Guid DocumentGuid)> CreateAsync(int userId, int templateId, string title, string formAnswersJson, CancellationToken ct = default)
            => Task.FromResult((1, Guid.NewGuid()));
        public Task<DocumentDetailDto?> GetByIdAsync(int documentId, int? userId = null, CancellationToken ct = default)
            => Task.FromResult<DocumentDetailDto?>(null);
        public Task<List<DocumentSummaryDto>> GetByUserAsync(int userId, CancellationToken ct = default)
            => Task.FromResult(new List<DocumentSummaryDto>());
        public Task<bool> UpdateAnswersAsync(int documentId, int userId, string formAnswersJson, CancellationToken ct = default)
            => Task.FromResult(true);
        public Task<bool> UpdateStatusAsync(int documentId, int statusId, string? storagePath = null, string? docxStoragePath = null, string? documentHash = null, CancellationToken ct = default)
            => Task.FromResult(true);
    }

    private class FakeTemplateRepo : ITemplateRepository
    {
        public Task<List<CategoryDto>> GetAllCategoriesAsync(CancellationToken ct = default)
            => Task.FromResult(new List<CategoryDto>());
        public Task<List<TemplateSummaryDto>> GetAllTemplatesAsync(string? searchTerm = null, CancellationToken ct = default)
            => Task.FromResult(new List<TemplateSummaryDto>());
        public Task<Template?> GetTemplateByIdAsync(int templateId, CancellationToken ct = default)
            => Task.FromResult<Template?>(null);
        public Task<Template?> GetTemplateBySlugAsync(string slug, CancellationToken ct = default)
            => Task.FromResult<Template?>(null);
        public Task<List<TemplateSummaryDto>> GetTemplatesByCategoryAsync(int categoryId, CancellationToken ct = default)
            => Task.FromResult(new List<TemplateSummaryDto>());
        public Task<List<FormFieldDto>> GetFormFieldsByTemplateIdAsync(int templateId, CancellationToken ct = default)
            => Task.FromResult(new List<FormFieldDto>());
    }

    [Fact]
    public async Task AIAssistant_ShouldProvidePakistaniStampDutyGuidance_InUrdu()
    {
        // Arrange
        var queryRepo = new FakeQueryRepo();
        var docRepo = new FakeUserDocRepo();
        var templateRepo = new FakeTemplateRepo();
        var config = new ConfigurationBuilder().AddInMemoryCollection(new Dictionary<string, string?>
        {
            { "AiSettings:Provider", "FreeLocal" }
        }).Build();

        var service = new AIAssistantService(
            queryRepo,
            docRepo,
            templateRepo,
            new HttpClient(),
            config,
            NullLogger<AIAssistantService>.Instance);

        var request = new AiAssistantRequest(
            Prompt: "اسٹامپ پیپر اور ڈیوٹی کی کیا شرائط ہیں؟",
            LanguageCode: "ur",
            TemplateId: 1,
            DocumentId: 1);

        // Act
        var result = await service.AskAssistantAsync(userId: 42, request);

        // Assert
        Assert.True(result.Succeeded);
        Assert.NotNull(result.Data);
        Assert.Contains("اسٹامپ پیپر", result.Data.Answer);
        Assert.Contains("قانونی انتباہ", result.Data.Answer);
        Assert.Single(queryRepo.Queries);
        Assert.Equal(42, queryRepo.Queries[0].User_ID);
        Assert.Equal("ur", queryRepo.Queries[0].LanguageCode);
    }

    [Fact]
    public async Task AIAssistant_ShouldProvideWitnessRules_InEnglish()
    {
        // Arrange
        var queryRepo = new FakeQueryRepo();
        var docRepo = new FakeUserDocRepo();
        var templateRepo = new FakeTemplateRepo();
        var config = new ConfigurationBuilder().AddInMemoryCollection(new Dictionary<string, string?>
        {
            { "AiSettings:Provider", "FreeLocal" }
        }).Build();

        var service = new AIAssistantService(
            queryRepo,
            docRepo,
            templateRepo,
            new HttpClient(),
            config,
            NullLogger<AIAssistantService>.Instance);

        var request = new AiAssistantRequest(
            Prompt: "What are the witness requirements for a contract in Pakistan?",
            LanguageCode: "en",
            TemplateId: 2,
            DocumentId: 5);

        // Act
        var result = await service.AskAssistantAsync(userId: 10, request);

        // Assert
        Assert.True(result.Succeeded);
        Assert.NotNull(result.Data);
        Assert.Contains("Qanun-e-Shahadat", result.Data.Answer);
        Assert.Contains("two", result.Data.Answer);
        Assert.Contains("Legal Notice", result.Data.Answer);
        Assert.Single(queryRepo.Queries);
    }
}
