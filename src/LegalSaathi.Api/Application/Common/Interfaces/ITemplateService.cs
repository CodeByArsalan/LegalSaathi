using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Contracts.Templates;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface ITemplateService
{
    Task<Result<List<CategoryDto>>> GetCategoriesAsync(CancellationToken ct = default);
    Task<Result<List<TemplateSummaryDto>>> GetTemplatesAsync(string? searchTerm = null, int? categoryId = null, CancellationToken ct = default);
    Task<Result<TemplateDetailDto>> GetTemplateBySlugAsync(string slug, CancellationToken ct = default);
    Task<Result<List<FormFieldDto>>> GetFormFieldsAsync(int templateId, CancellationToken ct = default);
    Task<Result<TemplatePreviewResponse>> PreviewDocumentAsync(string slug, TemplatePreviewRequest request, CancellationToken ct = default);
}
