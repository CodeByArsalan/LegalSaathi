using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Domain.Entities;

public class LawyerReview
{
    public long LawyerReviewID { get; set; }
    public int ReviewId { get => (int)LawyerReviewID; set => LawyerReviewID = value; }
    public int UserDocument_ID { get; set; }
    public int UserDocumentId { get => UserDocument_ID; set => UserDocument_ID = value; }
    public int? Lawyer_ID { get; set; }
    public int? LawyerId { get => Lawyer_ID; set => Lawyer_ID = value; }
    public string? Notes { get; set; }
    public string? AnnotatedPdfPath { get; set; }
    public decimal ReviewFee { get; set; } = 1499.00m;
    public decimal LawyerShareAmount { get; set; } = 1049.30m;
    public decimal PlatformShareAmount { get; set; } = 449.70m;
    public int? LawyerReviewStatus_ID { get; set; } = 1;
    public LawyerReviewStatus Status { get; set; } = LawyerReviewStatus.Requested;
    public DateTime RequesteDateTime { get; set; } = DateTime.UtcNow;
    public DateTime RequestedAt { get => RequesteDateTime; set => RequesteDateTime = value; }
    public DateTime? AssignedDateTime { get; set; }
    public DateTime? AssignedAt { get => AssignedDateTime; set => AssignedDateTime = value; }
    public DateTime? CompletedDateTime { get; set; }
    public DateTime? CompletedAt { get => CompletedDateTime; set => CompletedDateTime = value; }

    // Navigation
    public UserDocument? UserDocument { get; set; }
    public Lawyer? Lawyer { get; set; }
}
