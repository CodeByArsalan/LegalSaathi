using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Contracts.Lawyers;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface ILawyerReviewService
{
    Task<Result<IReadOnlyList<LawyerDto>>> GetVerifiedLawyersAsync(string? province = null, string? specialization = null, CancellationToken ct = default);
    Task<Result<LawyerDto>> GetLawyerByIdAsync(int lawyerId, CancellationToken ct = default);
    Task<Result<LawyerReviewDto>> RequestReviewAsync(int userId, RequestLawyerReviewRequest request, CancellationToken ct = default);
    Task<Result<IReadOnlyList<LawyerReviewDto>>> GetUserReviewsAsync(int userId, CancellationToken ct = default);
    Task<Result<IReadOnlyList<LawyerReviewDto>>> GetLawyerAssignedReviewsAsync(int userId, CancellationToken ct = default);
    Task<Result<LawyerReviewDto>> GetReviewDetailsAsync(long reviewId, int userId, CancellationToken ct = default);
    Task<Result<bool>> SubmitFeedbackAsync(long reviewId, int userId, SubmitLawyerReviewFeedbackRequest request, CancellationToken ct = default);
}
