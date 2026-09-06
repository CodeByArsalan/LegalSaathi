namespace LegalSaathi.Api.Domain.Enums;

/// <summary>
/// Lifecycle status of a user-generated legal document
/// </summary>
public enum DocumentStatus
{
    Draft = 1,
    Completed = 2,
    PendingSignature = 3,
    Signed = 4,
    UnderLawyerReview = 5,
    LawyerApproved = 6,
    Archived = 7
}
