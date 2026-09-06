using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Common;
using LegalSaathi.Api.Contracts.Lawyers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LegalSaathi.Api.Controllers;

[ApiController]
[Route("api/lawyers")]
[Produces("application/json")]
public class LawyersController : ApiControllerBase
{
    private readonly ILawyerReviewService _lawyerReviewService;
    private readonly ICurrentUserService _currentUserService;

    public LawyersController(ILawyerReviewService lawyerReviewService, ICurrentUserService currentUserService)
    {
        _lawyerReviewService = lawyerReviewService;
        _currentUserService = currentUserService;
    }

    /// <summary>
    /// Retrieve a directory of verified Pakistani High Court advocates
    /// </summary>
    [AllowAnonymous]
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyList<LawyerDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<IReadOnlyList<LawyerDto>>>> GetLawyers(
        [FromQuery] string? province,
        [FromQuery] string? specialization,
        CancellationToken ct)
    {
        var result = await _lawyerReviewService.GetVerifiedLawyersAsync(province, specialization, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Get details and credentials of a verified advocate
    /// </summary>
    [AllowAnonymous]
    [HttpGet("{id:int}")]
    [ProducesResponseType(typeof(ApiResponse<LawyerDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<LawyerDto>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<LawyerDto>>> GetLawyerById([FromRoute] int id, CancellationToken ct)
    {
        var result = await _lawyerReviewService.GetLawyerByIdAsync(id, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Request a free lawyer review for a draft or completed legal document
    /// </summary>
    [Authorize]
    [HttpPost("reviews")]
    [ProducesResponseType(typeof(ApiResponse<LawyerReviewDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<LawyerReviewDto>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<LawyerReviewDto>>> RequestReview([FromBody] RequestLawyerReviewRequest request, CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized(ApiResponse<LawyerReviewDto>.Fail("User is not authenticated.", 401));

        var result = await _lawyerReviewService.RequestReviewAsync(userId.Value, request, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Get all lawyer review requests for the currently authenticated user
    /// </summary>
    [Authorize]
    [HttpGet("reviews/my")]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyList<LawyerReviewDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<IReadOnlyList<LawyerReviewDto>>>> GetMyReviews(CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized(ApiResponse<IReadOnlyList<LawyerReviewDto>>.Fail("User is not authenticated.", 401));

        var result = await _lawyerReviewService.GetUserReviewsAsync(userId.Value, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Get all reviews assigned to the authenticated lawyer
    /// </summary>
    [Authorize]
    [HttpGet("reviews/assigned")]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyList<LawyerReviewDto>>), StatusCodes.Status200OK)]
    public async Task<ActionResult<ApiResponse<IReadOnlyList<LawyerReviewDto>>>> GetAssignedReviews(CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized(ApiResponse<IReadOnlyList<LawyerReviewDto>>.Fail("User is not authenticated.", 401));

        var result = await _lawyerReviewService.GetLawyerAssignedReviewsAsync(userId.Value, ct);
        return HandleResult(result);
    }

    /// <summary>
    /// Submit lawyer annotations, review notes, and legal approval
    /// </summary>
    [Authorize]
    [HttpPut("reviews/{id:long}/feedback")]
    [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<ApiResponse<bool>>> SubmitFeedback(
        [FromRoute] long id,
        [FromBody] SubmitLawyerReviewFeedbackRequest request,
        CancellationToken ct)
    {
        var userId = _currentUserService.UserId;
        if (!userId.HasValue) return Unauthorized(ApiResponse<bool>.Fail("User is not authenticated.", 401));

        var result = await _lawyerReviewService.SubmitFeedbackAsync(id, userId.Value, request, ct);
        return HandleResult(result);
    }
}
