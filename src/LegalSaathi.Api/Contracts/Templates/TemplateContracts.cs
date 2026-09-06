using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Contracts.Templates;

public record CategoryDto(
    int CategoryId,
    string NameEn,
    string NameUr,
    string? DescriptionEn,
    string? DescriptionUr,
    string? Icon,
    int TemplateCount);

public record FormFieldDto(
    int FieldId,
    int TemplateId,
    string FieldKey,
    string FieldType,
    string LabelEn,
    string LabelUr,
    string? PlaceholderEn,
    string? PlaceholderUr,
    string? HelpTextEn,
    string? HelpTextUr,
    bool IsRequired,
    string? ValidationRegex,
    string? OptionsJson,
    string? ConditionalLogicJson,
    int StepNumber,
    int SortOrder);

public record TemplateSummaryDto(
    int TemplateId,
    int CategoryId,
    string CategoryNameEn,
    string CategoryNameUr,
    string Slug,
    string TitleEn,
    string TitleUr,
    string? DescriptionEn,
    string? DescriptionUr,
    decimal BasePrice,
    string Tier,
    bool RequiresStampPaper,
    decimal EstimatedStampDuty);

public record TemplateDetailDto(
    int TemplateId,
    int CategoryId,
    string Slug,
    string TitleEn,
    string TitleUr,
    string? DescriptionEn,
    string? DescriptionUr,
    decimal BasePrice,
    string Tier,
    string ContentTemplateEn,
    string ContentTemplateUr,
    string? ApplicableLaws,
    bool RequiresStampPaper,
    decimal EstimatedStampDuty,
    List<FormFieldDto> FormFields);

public record TemplatePreviewRequest(
    Dictionary<string, string> FormAnswers,
    string? Language = "en");

public record TemplatePreviewResponse(
    string InterpolatedContentEn,
    string InterpolatedContentUr,
    List<string> MissingRequiredFields,
    bool IsValid,
    List<string> ValidationErrors);
