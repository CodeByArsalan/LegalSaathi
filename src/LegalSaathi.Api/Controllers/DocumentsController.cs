using System.Text.Json;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Common;
using LegalSaathi.Api.Contracts.Documents;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LegalSaathi.Api.Controllers;

[ApiController]
[Route("api/documents")]
[Produces("application/json")]
[Authorize]
public class DocumentsController : ApiControllerBase
{
    private readonly IUserDocumentRepository _documentRepository;
    private readonly IDocumentGenerationService _documentGenerationService;
    private readonly IFileStorageService _fileStorageService;
    private readonly ICurrentUserService _currentUserService;

    public DocumentsController(
        IUserDocumentRepository documentRepository,
        IDocumentGenerationService documentGenerationService,
        IFileStorageService fileStorageService,
        ICurrentUserService currentUserService)
    {
        _documentRepository = documentRepository;
        _documentGenerationService = documentGenerationService;
        _fileStorageService = fileStorageService;
        _currentUserService = currentUserService;
    }

    /// <summary>
    /// Create a new draft document from a template and form answers
    /// </summary>
    [HttpPost]
    [ProducesResponseType(typeof(ApiResponse<DocumentDetailDto>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<DocumentDetailDto>>> CreateDocument([FromBody] CreateDocumentRequest request, CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var title = request.Title ?? "Draft Legal Document";
        var answersJson = request.FormAnswers != null ? JsonSerializer.Serialize(request.FormAnswers) : "{}";

        var (docId, docGuid) = await _documentRepository.CreateAsync(userId.Value, request.TemplateId, title, answersJson, ct);
        var createdDoc = await _documentRepository.GetByIdAsync(docId, userId.Value, ct);

        return Ok(ApiResponse<DocumentDetailDto>.Ok(createdDoc!, "Draft document created successfully."));
    }

    /// <summary>
    /// List all documents belonging to the authenticated user
    /// </summary>
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<List<DocumentSummaryDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<List<DocumentSummaryDto>>>> GetMyDocuments(CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var documents = await _documentRepository.GetByUserAsync(userId.Value, ct);
        return Ok(ApiResponse<List<DocumentSummaryDto>>.Ok(documents));
    }

    /// <summary>
    /// Get document details by ID
    /// </summary>
    [HttpGet("{id:int}")]
    [ProducesResponseType(typeof(ApiResponse<DocumentDetailDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<DocumentDetailDto>), StatusCodes.Status404NotFound)]
    public async Task<ActionResult<ApiResponse<DocumentDetailDto>>> GetDocument(int id, CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var doc = await _documentRepository.GetByIdAsync(id, userId.Value, ct);
        if (doc == null)
        {
            return NotFound(ApiResponse<DocumentDetailDto>.Fail("Document not found.", 404));
        }

        return Ok(ApiResponse<DocumentDetailDto>.Ok(doc));
    }

    /// <summary>
    /// Update questionnaire answers for an existing document
    /// </summary>
    [HttpPut("{id:int}/answers")]
    [ProducesResponseType(typeof(ApiResponse<DocumentDetailDto>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<DocumentDetailDto>>> UpdateAnswers(int id, [FromBody] UpdateAnswersRequest request, CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var answersJson = JsonSerializer.Serialize(request.FormAnswers);
        var success = await _documentRepository.UpdateAnswersAsync(id, userId.Value, answersJson, ct);
        if (!success)
        {
            return BadRequest(ApiResponse<DocumentDetailDto>.Fail("Failed to update document answers.", 400));
        }

        var updatedDoc = await _documentRepository.GetByIdAsync(id, userId.Value, ct);
        return Ok(ApiResponse<DocumentDetailDto>.Ok(updatedDoc!, "Answers updated successfully."));
    }

    /// <summary>
    /// Generate and render court-compliant PDF &amp; DOCX document files with SHA-256 tamper-evident integrity hash
    /// </summary>
    [HttpPost("{id:int}/generate")]
    [ProducesResponseType(typeof(ApiResponse<GenerateDocumentResponse>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<GenerateDocumentResponse>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<GenerateDocumentResponse>>> GenerateDocument(
        int id,
        [FromBody] GenerateDocumentRequest request,
        CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var ip = HttpContext.Connection.RemoteIpAddress?.ToString();
        var userAgent = Request.Headers.UserAgent.ToString();

        var result = await _documentGenerationService.GenerateAndSaveDocumentAsync(
            documentId: id,
            userId: userId.Value,
            language: request.Language,
            ipAddress: ip,
            userAgent: userAgent,
            ct: ct
        );

        return HandleResult(result);
    }

    /// <summary>
    /// Download generated court-compliant PDF
    /// </summary>
    [HttpGet("{id:int}/download/pdf")]
    [ProducesResponseType(typeof(FileContentResult), StatusCodes.Status200OK)]
    public async Task<IActionResult> DownloadPdf(int id, CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var doc = await _documentRepository.GetByIdAsync(id, userId.Value, ct);
        if (doc == null || string.IsNullOrEmpty(doc.StoragePath))
        {
            return NotFound("PDF document not found or has not been generated yet.");
        }

        var bytes = await _fileStorageService.GetFileAsync(doc.StoragePath, ct);
        var filename = $"{doc.Title.Replace(' ', '_')}_{doc.DocumentGuid.ToString()[..8]}.pdf";
        return File(bytes, "application/pdf", filename);
    }

    /// <summary>
    /// Download generated editable Word (.docx) file
    /// </summary>
    [HttpGet("{id:int}/download/docx")]
    [ProducesResponseType(typeof(FileContentResult), StatusCodes.Status200OK)]
    public async Task<IActionResult> DownloadDocx(int id, CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized();

        var doc = await _documentRepository.GetByIdAsync(id, userId.Value, ct);
        if (doc == null || string.IsNullOrEmpty(doc.DocxStoragePath))
        {
            return NotFound("Word document not found or has not been generated yet.");
        }

        var bytes = await _fileStorageService.GetFileAsync(doc.DocxStoragePath, ct);
        var filename = $"{doc.Title.Replace(' ', '_')}_{doc.DocumentGuid.ToString()[..8]}.docx";
        return File(bytes, "application/vnd.openxmlformats-officedocument.wordprocessingml.document", filename);
    }
}
