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

    private static readonly List<QuickPromptDto> QuickPrompts = new()
    {
        new QuickPromptDto(
            Id: "rent-rights",
            TitleEng: "Rent Agreement Rights",
            TitleUrdu: "کرایہ داری کے حقوق اور قوانین",
            PromptEng: "What are tenant and landlord rights under Pakistani tenancy acts? Explain deposit, notice period, and eviction rules.",
            PromptUrdu: "پاکستانی کرایہ داری قانون کے تحت مالک مکان اور کرایہ دار کے بنیادی حقوق اور بے دخلی کے قواعد کیا ہیں؟",
            Category: "Tenancy",
            Icon: "Home"),
        new QuickPromptDto(
            Id: "affidavit-validity",
            TitleEng: "Affidavit Legal Attestation",
            TitleUrdu: "بیان حلفی کی تصدیق اور شرائط",
            PromptEng: "What makes an affidavit legally valid in Pakistani courts? What are Oath Commissioner and Stamp Paper requirements?",
            PromptUrdu: "عدالت میں بیان حلفی کی قانونی حیثیت کے لیے کن شرائط اور اسٹامپ پیپر کا ہونا ضروری ہے؟",
            Category: "Affidavit",
            Icon: "FileText"),
        new QuickPromptDto(
            Id: "digital-signatures",
            TitleEng: "Digital Signatures in Court",
            TitleUrdu: "ڈیجیٹل دستخط کی قانونی حیثیت",
            PromptEng: "Are digital and OTP signatures legally binding in Pakistani courts under Electronic Transactions Ordinance 2002?",
            PromptUrdu: "کیا الیکٹرانک ٹرانزیکشن آرڈیننس 2002 کے تحت ڈیجیٹل اور او ٹی پی دستخط عدالت میں قابل قبول ہیں؟",
            Category: "DigitalSignature",
            Icon: "CheckCircle"),
        new QuickPromptDto(
            Id: "nda-clauses",
            TitleEng: "NDA & Confidentiality Terms",
            TitleUrdu: "رازداری کا معاہدہ (این ڈی اے)",
            PromptEng: "What essential clauses must be included in a Pakistani Non-Disclosure Agreement (NDA) under the Contract Act 1872?",
            PromptUrdu: "کاروباری راز کے تحفظ کے لیے این ڈی اے (NDA) میں کون سی قانونی شقیں شامل ہونی چاہئیں؟",
            Category: "Contracts",
            Icon: "Shield"),
        new QuickPromptDto(
            Id: "witness-rules",
            TitleEng: "Witness Rules (QSO 1984)",
            TitleUrdu: "گواہان کے قانونی تقاضے",
            PromptEng: "What are the legal witness requirements for contracts and property sales under Article 79 of Qanun-e-Shahadat 1984?",
            PromptUrdu: "قانون شہادت 1984 کے تحت معاہدات اور دستاویزات پر کتنے گواہوں کے دستخط لازمی ہیں؟",
            Category: "Evidence",
            Icon: "Users")
    };

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
    /// Get popular starter legal prompts in English and Urdu
    /// </summary>
    [AllowAnonymous]
    [HttpGet("quick-prompts")]
    public ActionResult<ApiResponse<List<QuickPromptDto>>> GetQuickPrompts()
    {
        return Ok(ApiResponse<List<QuickPromptDto>>.Ok(QuickPrompts, "Quick prompts retrieved successfully."));
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
