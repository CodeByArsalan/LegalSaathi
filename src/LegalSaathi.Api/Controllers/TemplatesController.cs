using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Common;
using LegalSaathi.Api.Contracts.Templates;
using Microsoft.AspNetCore.Mvc;

namespace LegalSaathi.Api.Controllers;

[ApiController]
[Route("api/templates")]
[Produces("application/json")]
public class TemplatesController : ApiControllerBase
{
    private readonly ITemplateService _templateService;

    public TemplatesController(ITemplateService templateService)
    {
        _templateService = templateService;
    }

    /// <summary>
    /// Get all template categories with active document counts
    /// </summary>
    [HttpGet("categories")]
    [ProducesResponseType(typeof(ApiResponse<List<CategoryDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<List<CategoryDto>>>> GetCategories(CancellationToken ct)
    {
        var result = await _templateService.GetCategoriesAsync(ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Search and list legal document templates by keyword or category ID
    /// </summary>
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<List<TemplateSummaryDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<List<TemplateSummaryDto>>>> GetTemplates(
        [FromQuery] string? search,
        [FromQuery] int? categoryId,
        CancellationToken ct)
    {
        var result = await _templateService.GetTemplatesAsync(search, categoryId, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Get template metadata, legal clauses, stamp paper duties, and questionnaire form fields by slug
    /// </summary>
    [HttpGet("{slug}")]
    [ProducesResponseType(typeof(ApiResponse<TemplateDetailDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<TemplateDetailDto>), StatusCodes.Status404NotFound)]
    public async Task<ActionResult<ApiResponse<TemplateDetailDto>>> GetTemplateBySlug(string slug, CancellationToken ct)
    {
        var result = await _templateService.GetTemplateBySlugAsync(slug, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Get ordered form fields for a template
    /// </summary>
    [HttpGet("{id:int}/fields")]
    [ProducesResponseType(typeof(ApiResponse<List<FormFieldDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<List<FormFieldDto>>>> GetFormFields(int id, CancellationToken ct)
    {
        var result = await _templateService.GetFormFieldsAsync(id, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Validate dynamic questionnaire answers and generate bilingual live preview content
    /// </summary>
    [HttpPost("{slug}/preview")]
    [ProducesResponseType(typeof(ApiResponse<TemplatePreviewResponse>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<TemplatePreviewResponse>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<TemplatePreviewResponse>>> PreviewTemplate(
        string slug,
        [FromBody] TemplatePreviewRequest request,
        CancellationToken ct)
    {
        var result = await _templateService.PreviewDocumentAsync(slug, request, ct);
        return HandleResult(result);
    }
}
