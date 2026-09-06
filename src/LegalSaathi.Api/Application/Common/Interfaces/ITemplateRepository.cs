using LegalSaathi.Api.Contracts.Templates;
using LegalSaathi.Api.Domain.Entities;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface ITemplateRepository
{
    Task<List<CategoryDto>> GetAllCategoriesAsync(CancellationToken ct = default);
    Task<List<TemplateSummaryDto>> GetAllTemplatesAsync(string? searchTerm = null, CancellationToken ct = default);
    Task<List<TemplateSummaryDto>> GetTemplatesByCategoryAsync(int categoryId, CancellationToken ct = default);
    Task<Template?> GetTemplateByIdAsync(int templateId, CancellationToken ct = default);
    Task<Template?> GetTemplateBySlugAsync(string slug, CancellationToken ct = default);
    Task<List<FormFieldDto>> GetFormFieldsByTemplateIdAsync(int templateId, CancellationToken ct = default);
}
