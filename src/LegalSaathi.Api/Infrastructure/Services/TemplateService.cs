using System.Text.RegularExpressions;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Contracts.Templates;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

public class TemplateService : ITemplateService
{
    private readonly ITemplateRepository _templateRepository;
    private readonly ILogger<TemplateService> _logger;

    public TemplateService(ITemplateRepository templateRepository, ILogger<TemplateService> logger)
    {
        _templateRepository = templateRepository;
        _logger = logger;
    }

    public async Task<Result<List<CategoryDto>>> GetCategoriesAsync(CancellationToken ct = default)
    {
        var categories = await _templateRepository.GetAllCategoriesAsync(ct);
        return Result<List<CategoryDto>>.Success(categories);
    }

    public async Task<Result<List<TemplateSummaryDto>>> GetTemplatesAsync(string? searchTerm = null, int? categoryId = null, CancellationToken ct = default)
    {
        List<TemplateSummaryDto> templates;
        if (categoryId.HasValue && categoryId.Value > 0)
        {
            templates = await _templateRepository.GetTemplatesByCategoryAsync(categoryId.Value, ct);
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                templates = templates.Where(t => 
                    t.TitleEn.Contains(searchTerm, StringComparison.OrdinalIgnoreCase) ||
                    t.TitleUr.Contains(searchTerm, StringComparison.OrdinalIgnoreCase)).ToList();
            }
        }
        else
        {
            templates = await _templateRepository.GetAllTemplatesAsync(searchTerm, ct);
        }

        return Result<List<TemplateSummaryDto>>.Success(templates);
    }

    public async Task<Result<TemplateDetailDto>> GetTemplateBySlugAsync(string slug, CancellationToken ct = default)
    {
        var template = await _templateRepository.GetTemplateBySlugAsync(slug, ct);
        if (template == null)
        {
            return Result<TemplateDetailDto>.Failure($"Template with slug '{slug}' not found.");
        }

        var fields = await _templateRepository.GetFormFieldsByTemplateIdAsync(template.TemplateID, ct);

        var detail = new TemplateDetailDto(
            TemplateId: template.TemplateID,
            CategoryId: template.Category_ID,
            Slug: template.Slug,
            TitleEn: template.TitleEng,
            TitleUr: template.TitleUrdu,
            DescriptionEn: template.DescriptionEng,
            DescriptionUr: template.DescriptionUrdu,
            BasePrice: template.BasePrice,
            Tier: template.Tier,
            ContentTemplateEn: template.ContentTemplateEng,
            ContentTemplateUr: template.ContentTemplateUrdu,
            ApplicableLaws: template.ApplicableLaws,
            RequiresStampPaper: template.RequiresStampPaper,
            EstimatedStampDuty: template.EstimatedStampDuty,
            FormFields: fields
        );

        return Result<TemplateDetailDto>.Success(detail);
    }

    public async Task<Result<List<FormFieldDto>>> GetFormFieldsAsync(int templateId, CancellationToken ct = default)
    {
        var fields = await _templateRepository.GetFormFieldsByTemplateIdAsync(templateId, ct);
        return Result<List<FormFieldDto>>.Success(fields);
    }

    public async Task<Result<TemplatePreviewResponse>> PreviewDocumentAsync(string slug, TemplatePreviewRequest request, CancellationToken ct = default)
    {
        var template = await _templateRepository.GetTemplateBySlugAsync(slug, ct);
        if (template == null)
        {
            return Result<TemplatePreviewResponse>.Failure($"Template with slug '{slug}' not found.");
        }

        var fields = await _templateRepository.GetFormFieldsByTemplateIdAsync(template.TemplateID, ct);
        var missingFields = new List<string>();
        var validationErrors = new List<string>();

        // Validate form fields
        foreach (var field in fields)
        {
            request.FormAnswers.TryGetValue(field.FieldKey, out var value);

            if (field.IsRequired && string.IsNullOrWhiteSpace(value))
            {
                missingFields.Add(field.FieldKey);
                validationErrors.Add($"Field '{field.LabelEn}' ({field.LabelUr}) is required.");
            }
            else if (!string.IsNullOrWhiteSpace(value) && !string.IsNullOrWhiteSpace(field.ValidationRegex))
            {
                try
                {
                    if (!Regex.IsMatch(value, field.ValidationRegex))
                    {
                        validationErrors.Add($"Field '{field.LabelEn}' format is invalid.");
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogWarning(ex, "Invalid regex expression {Regex} on field {FieldKey}", field.ValidationRegex, field.FieldKey);
                }
            }
        }

        // Live token interpolation
        var interpolatedEn = InterpolateTemplateTokens(template.ContentTemplateEng, request.FormAnswers);
        var interpolatedUr = InterpolateTemplateTokens(template.ContentTemplateUrdu, request.FormAnswers);

        var isValid = missingFields.Count == 0 && validationErrors.Count == 0;

        return Result<TemplatePreviewResponse>.Success(new TemplatePreviewResponse(
            InterpolatedContentEn: interpolatedEn,
            InterpolatedContentUr: interpolatedUr,
            MissingRequiredFields: missingFields,
            IsValid: isValid,
            ValidationErrors: validationErrors
        ));
    }

    private static string InterpolateTemplateTokens(string templateContent, Dictionary<string, string> answers)
    {
        if (string.IsNullOrWhiteSpace(templateContent)) return string.Empty;

        return Regex.Replace(templateContent, @"{{([a-zA-Z0-9_]+)}}", match =>
        {
            var key = match.Groups[1].Value;
            if (answers.TryGetValue(key, out var val) && !string.IsNullOrWhiteSpace(val))
            {
                return val;
            }
            return $"[{key}]"; // Unfilled placeholder representation
        });
    }
}
