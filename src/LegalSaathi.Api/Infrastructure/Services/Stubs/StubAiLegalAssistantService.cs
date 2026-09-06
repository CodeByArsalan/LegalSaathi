using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Domain.Entities;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services.Stubs;

/// <summary>
/// AI Legal Assistant Provider fallback stub
/// </summary>
public class StubAiLegalAssistantService : IAiLegalAssistantService
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<StubAiLegalAssistantService> _logger;

    public StubAiLegalAssistantService(IConfiguration configuration, ILogger<StubAiLegalAssistantService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<Result<AiAssistantResponse>> AskAssistantAsync(int? userId, AiAssistantRequest request, CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Processing AI Legal Assistant prompt for language: {LanguageCode}", request.LanguageCode);
        await Task.CompletedTask;

        var defaultAnswer = request.LanguageCode == "ur"
            ? "لیگل ساتھی قانونی معاون: آپ کا سوال موصول ہوا ہے۔ پاکستانی قانون کے تحت کسی بھی معاہدے یا حلف نامے پر صحیح تفصیلات کا اندراج ضروری ہے۔"
            : "Legal Saathi AI: Under Pakistani Law (Contract Act 1872), ensure all parties have lawful capacity and mutual consent before executing this document.";

        return Result<AiAssistantResponse>.Success(new AiAssistantResponse(
            Answer: defaultAnswer,
            PromptTokens: 35,
            CompletionTokens: 45,
            TotalTokens: 80,
            Model: "legal-saathi-stub"
        ));
    }

    public async Task<Result<IReadOnlyList<AiQuery>>> GetDocumentQueriesAsync(int userDocumentId, int userId, CancellationToken cancellationToken = default)
    {
        await Task.CompletedTask;
        return Result<IReadOnlyList<AiQuery>>.Success(new List<AiQuery>());
    }
}
