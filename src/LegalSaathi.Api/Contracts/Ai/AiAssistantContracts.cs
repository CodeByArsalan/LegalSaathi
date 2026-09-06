namespace LegalSaathi.Api.Contracts.Ai;

public record AiAskRequest(
    string Prompt,
    string? LanguageCode = "ur",
    int? TemplateId = null,
    int? DocumentId = null,
    string? ContextJson = null);

public record AiAskResponse(
    string Answer,
    int TotalTokens,
    string Model,
    long? QueryId = null);

public record AiQueryHistoryDto(
    long QueryId,
    int? UserDocumentId,
    string Prompt,
    string Response,
    string LanguageCode,
    int Tokens,
    string ModelUsed,
    DateTime CreatedAt);
