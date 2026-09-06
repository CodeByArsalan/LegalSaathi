namespace LegalSaathi.Api.Contracts.Documents;

public record CreateDocumentRequest(
    int TemplateId,
    string? Title,
    Dictionary<string, string>? FormAnswers);

public record UpdateAnswersRequest(
    Dictionary<string, string> FormAnswers);

public record GenerateDocumentRequest(
    string Language = "bilingual"); // "en", "ur", "bilingual"

public record GenerateDocumentResponse(
    int UserDocumentId,
    Guid DocumentGuid,
    string Status,
    string? StoragePath,
    string? DocxStoragePath,
    string? DocumentHash,
    string PdfDownloadUrl,
    string DocxDownloadUrl);

public record DocumentSummaryDto(
    int UserDocumentId,
    Guid DocumentGuid,
    int TemplateId,
    string TemplateTitleEn,
    string TemplateTitleUr,
    string Title,
    string Status,
    int StatusId,
    bool IsPaid,
    DateTime CreatedAt,
    DateTime? CompletedAt);

public record DocumentDetailDto(
    int UserDocumentId,
    Guid DocumentGuid,
    int UserId,
    int TemplateId,
    string TemplateTitleEn,
    string TemplateTitleUr,
    string Title,
    string FormAnswersJson,
    string Status,
    int StatusId,
    string? StoragePath,
    string? DocxStoragePath,
    string? DocumentHash,
    bool IsPaid,
    DateTime CreatedAt,
    DateTime? UpdatedAt,
    DateTime? CompletedAt);
