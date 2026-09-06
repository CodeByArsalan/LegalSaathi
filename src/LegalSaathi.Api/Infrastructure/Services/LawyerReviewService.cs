using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Contracts.Lawyers;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

public class LawyerReviewService : ILawyerReviewService
{
    private readonly ILawyerRepository _lawyerRepository;
    private readonly IUserDocumentRepository _documentRepository;
    private readonly IAuditLogService _auditLogService;
    private readonly ILogger<LawyerReviewService> _logger;

    public LawyerReviewService(
        ILawyerRepository lawyerRepository,
        IUserDocumentRepository documentRepository,
        IAuditLogService auditLogService,
        ILogger<LawyerReviewService> logger)
    {
        _lawyerRepository = lawyerRepository;
        _documentRepository = documentRepository;
        _auditLogService = auditLogService;
        _logger = logger;
    }

    public async Task<Result<IReadOnlyList<LawyerDto>>> GetVerifiedLawyersAsync(string? province = null, string? specialization = null, CancellationToken ct = default)
    {
        var lawyers = await _lawyerRepository.GetVerifiedLawyersAsync(province, specialization, ct);
        return Result<IReadOnlyList<LawyerDto>>.Success(lawyers, "Verified lawyers retrieved successfully.");
    }

    public async Task<Result<LawyerDto>> GetLawyerByIdAsync(int lawyerId, CancellationToken ct = default)
    {
        var lawyer = await _lawyerRepository.GetLawyerByIdAsync(lawyerId, ct);
        if (lawyer == null)
        {
            return Result<LawyerDto>.Failure("Lawyer profile not found.");
        }
        return Result<LawyerDto>.Success(lawyer);
    }

    public async Task<Result<LawyerReviewDto>> RequestReviewAsync(int userId, RequestLawyerReviewRequest request, CancellationToken ct = default)
    {
        var document = await _documentRepository.GetByIdAsync(request.UserDocumentId, ct: ct);
        if (document == null)
        {
            return Result<LawyerReviewDto>.Failure("Document not found.");
        }

        if (document.UserId != userId)
        {
            return Result<LawyerReviewDto>.Failure("You are not authorized to submit this document for review.");
        }

        // Free lawyer review flow (no payment required)
        var reviewId = await _lawyerRepository.CreateLawyerReviewAsync(
            userDocumentId: request.UserDocumentId,
            lawyerId: request.LawyerId,
            notes: request.Notes,
            fee: 0.00m,
            ct: ct);

        // Update document status to UnderLawyerReview (ID = 5)
        await _documentRepository.UpdateStatusAsync(request.UserDocumentId, 5, ct: ct);

        await _auditLogService.LogAsync(
            userId: userId,
            action: "LAWYER_REVIEW_REQUESTED",
            entityName: "LawyerReviews",
            entityId: reviewId.ToString(),
            newValuesJson: System.Text.Json.JsonSerializer.Serialize(new { request.UserDocumentId, request.LawyerId, request.Notes }),
            ct: ct);

        var review = await _lawyerRepository.GetReviewByIdAsync(reviewId, ct);
        return Result<LawyerReviewDto>.Success(review!, "Lawyer review requested successfully. An advocate will review your legal document.");
    }

    public async Task<Result<IReadOnlyList<LawyerReviewDto>>> GetUserReviewsAsync(int userId, CancellationToken ct = default)
    {
        var reviews = await _lawyerRepository.GetReviewsByUserAsync(userId, ct);
        return Result<IReadOnlyList<LawyerReviewDto>>.Success(reviews);
    }

    public async Task<Result<IReadOnlyList<LawyerReviewDto>>> GetLawyerAssignedReviewsAsync(int userId, CancellationToken ct = default)
    {
        var lawyer = await _lawyerRepository.GetLawyerByUserIdAsync(userId, ct);
        if (lawyer == null)
        {
            return Result<IReadOnlyList<LawyerReviewDto>>.Failure("Authenticated user is not a registered lawyer.");
        }

        var reviews = await _lawyerRepository.GetReviewsByLawyerAsync(lawyer.LawyerId, ct);
        return Result<IReadOnlyList<LawyerReviewDto>>.Success(reviews);
    }

    public async Task<Result<LawyerReviewDto>> GetReviewDetailsAsync(long reviewId, int userId, CancellationToken ct = default)
    {
        var review = await _lawyerRepository.GetReviewByIdAsync(reviewId, ct);
        if (review == null)
        {
            return Result<LawyerReviewDto>.Failure("Lawyer review record not found.");
        }

        return Result<LawyerReviewDto>.Success(review);
    }

    public async Task<Result<bool>> SubmitFeedbackAsync(long reviewId, int userId, SubmitLawyerReviewFeedbackRequest request, CancellationToken ct = default)
    {
        var review = await _lawyerRepository.GetReviewByIdAsync(reviewId, ct);
        if (review == null)
        {
            return Result<bool>.Failure("Lawyer review record not found.");
        }

        var statusId = request.Status.ToLowerInvariant() switch
        {
            "approved" => 4,
            "rejected" => 5,
            "changesrequested" => 3,
            _ => 6 // Completed
        };

        var updated = await _lawyerRepository.UpdateReviewFeedbackAsync(reviewId, statusId, request.Notes, request.AnnotatedPdfPath, ct);

        if (statusId == 4) // Lawyer Approved
        {
            await _documentRepository.UpdateStatusAsync(review.UserDocumentId, 6, ct: ct); // 6 = LawyerApproved
        }

        await _auditLogService.LogAsync(
            userId: userId,
            action: "LAWYER_REVIEW_FEEDBACK_SUBMITTED",
            entityName: "LawyerReviews",
            entityId: reviewId.ToString(),
            newValuesJson: System.Text.Json.JsonSerializer.Serialize(new { request.Status, request.Notes, request.AnnotatedPdfPath }),
            ct: ct);

        return Result<bool>.Success(true, "Lawyer feedback submitted successfully.");
    }
}
