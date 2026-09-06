using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Templates;
using LegalSaathi.Api.Domain.Entities;
using LegalSaathi.Api.Infrastructure.Services;
using Microsoft.Extensions.Logging.Abstractions;
using Xunit;

namespace LegalSaathi.Api.Tests;

public class TemplateTests
{
    private class FakeTemplateRepository : ITemplateRepository
    {
        public Task<List<CategoryDto>> GetAllCategoriesAsync(CancellationToken ct = default)
        {
            return Task.FromResult(new List<CategoryDto>
            {
                new(1, "Personal & Family", "ذاتی اور خاندانی", "Affidavits and Declarations", "حلف نامے", "Users", 1)
            });
        }

        public Task<List<TemplateSummaryDto>> GetAllTemplatesAsync(string? searchTerm = null, CancellationToken ct = default)
        {
            return Task.FromResult(new List<TemplateSummaryDto>
            {
                new(1, 1, "Personal & Family", "ذاتی اور خاندانی", "general-affidavit", "General Affidavit", "عمومی بیان حلفی", "Sworn statement", "بیان حلفی", 0, "Free", true, 100)
            });
        }

        public Task<List<TemplateSummaryDto>> GetTemplatesByCategoryAsync(int categoryId, CancellationToken ct = default)
        {
            return GetAllTemplatesAsync(null, ct);
        }

        public Task<Template?> GetTemplateByIdAsync(int templateId, CancellationToken ct = default)
        {
            return Task.FromResult<Template?>(new Template
            {
                TemplateID = 1,
                Category_ID = 1,
                Slug = "general-affidavit",
                TitleEng = "General Affidavit",
                TitleUrdu = "عمومی بیان حلفی",
                ContentTemplateEng = "I, {{DeponentName}}, CNIC {{Cnic}}, state: {{AffidavitStatement}}",
                ContentTemplateUrdu = "میں {{DeponentName}}، شناختی کارڈ {{Cnic}}، بیان کرتا ہوں: {{AffidavitStatement}}",
                BasePrice = 0,
                Tier = "Free"
            });
        }

        public Task<Template?> GetTemplateBySlugAsync(string slug, CancellationToken ct = default)
        {
            if (slug == "general-affidavit")
            {
                return GetTemplateByIdAsync(1, ct);
            }
            return Task.FromResult<Template?>(null);
        }

        public Task<List<FormFieldDto>> GetFormFieldsByTemplateIdAsync(int templateId, CancellationToken ct = default)
        {
            return Task.FromResult(new List<FormFieldDto>
            {
                new(1, 1, "DeponentName", "Text", "Deponent Name", "نام", null, null, null, null, true, null, null, null, 1, 1),
                new(2, 1, "Cnic", "Cnic", "CNIC", "شناختی کارڈ", null, null, null, null, true, @"^[0-9]{5}-[0-9]{7}-[0-9]$", null, null, 1, 2),
                new(3, 1, "AffidavitStatement", "TextArea", "Statement", "بیان", null, null, null, null, true, null, null, null, 2, 1)
            });
        }
    }

    [Fact]
    public async Task PreviewDocument_ShouldInterpolateVariables_AndValidateRequiredFields()
    {
        // Arrange
        var fakeRepo = new FakeTemplateRepository();
        var service = new TemplateService(fakeRepo, NullLogger<TemplateService>.Instance);

        var answers = new Dictionary<string, string>
        {
            { "DeponentName", "Muhammad Usman" },
            { "Cnic", "35201-1234567-1" },
            { "AffidavitStatement", "I am a citizen of Pakistan." }
        };

        var request = new TemplatePreviewRequest(answers);

        // Act
        var result = await service.PreviewDocumentAsync("general-affidavit", request);

        // Assert
        Assert.True(result.Succeeded);
        Assert.True(result.Data!.IsValid);
        Assert.Empty(result.Data.MissingRequiredFields);
        Assert.Contains("Muhammad Usman", result.Data.InterpolatedContentEn);
        Assert.Contains("35201-1234567-1", result.Data.InterpolatedContentEn);
        Assert.Contains("Muhammad Usman", result.Data.InterpolatedContentUr);
    }

    [Fact]
    public async Task PreviewDocument_WhenMissingRequiredField_ShouldReturnValidationError()
    {
        // Arrange
        var fakeRepo = new FakeTemplateRepository();
        var service = new TemplateService(fakeRepo, NullLogger<TemplateService>.Instance);

        var partialAnswers = new Dictionary<string, string>
        {
            { "DeponentName", "Muhammad Usman" }
            // Missing Cnic and AffidavitStatement
        };

        var request = new TemplatePreviewRequest(partialAnswers);

        // Act
        var result = await service.PreviewDocumentAsync("general-affidavit", request);

        // Assert
        Assert.True(result.Succeeded);
        Assert.False(result.Data!.IsValid);
        Assert.Contains("Cnic", result.Data.MissingRequiredFields);
        Assert.Contains("AffidavitStatement", result.Data.MissingRequiredFields);
    }
}
