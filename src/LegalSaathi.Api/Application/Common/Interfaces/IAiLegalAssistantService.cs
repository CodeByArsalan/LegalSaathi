using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Domain.Entities;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public record AiAssistantRequest(
    string Prompt,
    string? LanguageCode = "ur",
    int? TemplateId = null,
    int? DocumentId = null,
    string? FormContextJson = null);

public record AiAssistantResponse(
    string Answer,
    int PromptTokens,
    int CompletionTokens,
    int TotalTokens,
    string Model,
    long? QueryId = null);

public interface IAiLegalAssistantService
{
    Task<Result<AiAssistantResponse>> AskAssistantAsync(
        int? userId,
        AiAssistantRequest request, 
        CancellationToken cancellationToken = default);

    Task<Result<IReadOnlyList<AiQuery>>> GetDocumentQueriesAsync(
        int userDocumentId,
        int userId,
        CancellationToken cancellationToken = default);
}
