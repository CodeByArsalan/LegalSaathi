namespace LegalSaathi.Api.Domain.Enums;

/// <summary>
/// Status of an on-demand advocate review request
/// </summary>
public enum LawyerReviewStatus
{
    Requested = 1,
    Assigned = 2,
    InProgress = 3,
    ChangesSuggested = 4,
    ApprovedAndStamped = 5,
    Rejected = 6
}
