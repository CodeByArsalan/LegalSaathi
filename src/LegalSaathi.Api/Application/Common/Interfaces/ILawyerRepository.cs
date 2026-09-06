using LegalSaathi.Api.Domain.Entities;
using LegalSaathi.Api.Contracts.Lawyers;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface ILawyerRepository
{
    Task<IReadOnlyList<LawyerDto>> GetVerifiedLawyersAsync(string? province = null, string? specialization = null, CancellationToken ct = default);
    Task<LawyerDto?> GetLawyerByIdAsync(int lawyerId, CancellationToken ct = default);
    Task<LawyerDto?> GetLawyerByUserIdAsync(int userId, CancellationToken ct = default);
    Task<long> CreateLawyerReviewAsync(int userDocumentId, int? lawyerId, string? notes, decimal fee, CancellationToken ct = default);
    Task<LawyerReviewDto?> GetReviewByIdAsync(long reviewId, CancellationToken ct = default);
    Task<IReadOnlyList<LawyerReviewDto>> GetReviewsByUserAsync(int userId, CancellationToken ct = default);
    Task<IReadOnlyList<LawyerReviewDto>> GetReviewsByLawyerAsync(int lawyerId, CancellationToken ct = default);
    Task<IReadOnlyList<LawyerReviewDto>> GetReviewsByDocumentAsync(int documentId, CancellationToken ct = default);
    Task<bool> AssignLawyerAsync(long reviewId, int lawyerId, CancellationToken ct = default);
    Task<bool> UpdateReviewFeedbackAsync(long reviewId, int statusId, string notes, string? annotatedPdfPath, CancellationToken ct = default);
}
