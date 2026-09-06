namespace LegalSaathi.Api.Contracts.Lawyers;

public record LawyerDto(
    int LawyerId,
    int UserId,
    string FullName,
    string Email,
    string PhoneNumber,
    string BarCouncilNumber,
    string BarCouncilProvince,
    string Specialization,
    int YearsOfExperience,
    string? OfficeAddress,
    bool VerifiedStatus,
    decimal Rating,
    int TotalReviewsCompleted,
    DateTime CreatedDateTime);

public record RequestLawyerReviewRequest(
    int UserDocumentId,
    int? LawyerId = null,
    string? Notes = null);

public record LawyerReviewDto(
    long LawyerReviewId,
    int UserDocumentId,
    string DocumentTitle,
    string? TemplateName,
    int? LawyerId,
    string? LawyerName,
    string? LawyerSpecialization,
    string? BarCouncilProvince,
    string? Notes,
    string? AnnotatedPdfPath,
    decimal ReviewFee,
    string Status,
    int StatusId,
    DateTime RequestedDateTime,
    DateTime? AssignedDateTime,
    DateTime? CompletedDateTime);

public record SubmitLawyerReviewFeedbackRequest(
    string Status,
    string Notes,
    string? AnnotatedPdfPath = null);

public record AssignLawyerReviewRequest(
    int LawyerId);
