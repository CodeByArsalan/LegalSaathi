using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Ai;
using LegalSaathi.Api.Contracts.Common;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LegalSaathi.Api.Controllers;

[ApiController]
[Route("api/ai")]
public class AiController : ApiControllerBase
{
    private readonly IAiLegalAssistantService _aiService;
    private readonly ICurrentUserService _currentUserService;

    public AiController(IAiLegalAssistantService aiService, ICurrentUserService currentUserService)
    {
        _aiService = aiService;
        _currentUserService = currentUserService;
    }

    /// <summary>
    /// Ask a Pakistani legal question or get contextual field guidance
    /// </summary>
    [AllowAnonymous]
    [HttpPost("ask")]
    public async Task<ActionResult<ApiResponse<AiAskResponse>>> Ask([FromBody] AiAskRequest dto, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;

        var req = new AiAssistantRequest(
            Prompt: dto.Prompt,
            LanguageCode: dto.LanguageCode ?? "ur",
            TemplateId: dto.TemplateId,
            DocumentId: dto.DocumentId,
            FormContextJson: dto.ContextJson);

        var result = await _aiService.AskAssistantAsync(userId, req, cancellationToken);
        if (!result.Succeeded)
        {
            return BadRequest(ApiResponse<AiAskResponse>.Fail(result.Errors, 400, result.Message));
        }

        var res = result.Data!;
        return Ok(ApiResponse<AiAskResponse>.Ok(new AiAskResponse(
            Answer: res.Answer,
            TotalTokens: res.TotalTokens,
            Model: res.Model,
            QueryId: res.QueryId
        ), "AI response generated successfully."));
    }

    /// <summary>
    /// Retrieve AI query history for a document
    /// </summary>
    [Authorize]
    [HttpGet("document/{documentId:int}")]
    public async Task<ActionResult<ApiResponse<List<AiQueryHistoryDto>>>> GetDocumentQueries([FromRoute] int documentId, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var result = await _aiService.GetDocumentQueriesAsync(documentId, userId.Value, cancellationToken);
        if (!result.Succeeded)
        {
            return BadRequest(ApiResponse<List<AiQueryHistoryDto>>.Fail(result.Errors, 400, result.Message));
        }

        var dtos = result.Data!.Select(q => new AiQueryHistoryDto(
            QueryId: q.QueryID,
            UserDocumentId: q.UserDocument_ID,
            Prompt: q.Prompt,
            Response: q.Response,
            LanguageCode: q.LanguageCode,
            Tokens: q.Tokens,
            ModelUsed: q.ModelUsed,
            CreatedAt: q.CreatedDateTime
        )).ToList();

        return Ok(ApiResponse<List<AiQueryHistoryDto>>.Ok(dtos, "Queries retrieved successfully."));
    }
}
