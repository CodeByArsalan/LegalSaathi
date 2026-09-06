using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Domain.Entities;

public class UserDocument
{
    public int UserDocumentID { get; set; }
    public int UserDocumentId { get => UserDocumentID; set => UserDocumentID = value; }
    public Guid DocumentGuid { get; set; } = Guid.NewGuid();
    public int User_ID { get; set; }
    public int UserId { get => User_ID; set => User_ID = value; }
    public int Template_ID { get; set; }
    public int TemplateId { get => Template_ID; set => Template_ID = value; }
    public string Title { get; set; } = string.Empty;
    public string FormAnswers { get; set; } = "{}";
    public string FormAnswersJson { get => FormAnswers; set => FormAnswers = value; }
    public int? DocumentStatus_ID { get; set; } = 1;
    public string Status { get; set; } = "Draft";
    public string? StoragePath { get; set; }
    public string? PdfStoragePath { get => StoragePath; set => StoragePath = value; }
    public string? DocxStoragePath { get; set; }
    public string? DocumentHash { get; set; }
    public bool IsPaid { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
    public DateTime? CompletedAt { get; set; }

    // Navigation
    public User? User { get; set; }
    public Template? Template { get; set; }
    public List<Signature> Signatures { get; set; } = new();
    public List<Payment> Payments { get; set; } = new();
    public List<LawyerReview> LawyerReviews { get; set; } = new();
}
