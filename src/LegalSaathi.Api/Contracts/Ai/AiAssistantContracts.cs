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
    long? QueryId);

public record AiQueryHistoryDto(
    long QueryId,
    int? UserDocumentId,
    string Prompt,
    string Response,
    string LanguageCode,
    int Tokens,
    string ModelUsed,
    DateTime CreatedAt);

public record QuickPromptDto(
    string Id,
    string TitleEng,
    string TitleUrdu,
    string PromptEng,
    string PromptUrdu,
    string Category,
    string Icon);
