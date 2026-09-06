namespace LegalSaathi.Api.Domain.Entities;

public class Lawyer
{
    public int LawyerID { get; set; }
    public int LawyerId { get => LawyerID; set => LawyerID = value; }
    public int User_ID { get; set; }
    public int UserId { get => User_ID; set => User_ID = value; }
    public string BarCouncilNumber { get; set; } = string.Empty;
    public string BarCouncilProvince { get; set; } = string.Empty;
    public string Specialization { get; set; } = string.Empty;
    public int YearsOfExperience { get; set; }
    public string? OfficeAddress { get; set; }
    public string? LicenseDocumentUri { get; set; }
    public bool VerifiedStatus { get; set; }
    public bool IsVerified { get => VerifiedStatus; set => VerifiedStatus = value; }
    public DateTime? VerifiedDateTime { get; set; }
    public DateTime? VerifiedAt { get => VerifiedDateTime; set => VerifiedDateTime = value; }
    public int? VerifiedByUserID { get; set; }
    public int? VerifiedByUserId { get => VerifiedByUserID; set => VerifiedByUserID = value; }
    public decimal Rating { get; set; } = 5.0m;
    public int TotalReviewsCompleted { get; set; }
    public DateTime CreatedDateTime { get; set; } = DateTime.UtcNow;
    public DateTime CreatedAt { get => CreatedDateTime; set => CreatedDateTime = value; }

    // Navigation
    public User? User { get; set; }
    public List<LawyerReview> LawyerReviews { get; set; } = new();
}
