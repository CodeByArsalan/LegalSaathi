using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Domain.Entities;

public class Payment
{
    public long PaymentID { get; set; }
    public int PaymentId { get => (int)PaymentID; set => PaymentID = value; }
    public Guid PaymentGuid { get; set; } = Guid.NewGuid();
    public int User_ID { get; set; }
    public int UserId { get => User_ID; set => User_ID = value; }
    public int? UserDocument_ID { get; set; }
    public int? UserDocumentId { get => UserDocument_ID; set => UserDocument_ID = value; }
    public decimal Amount { get; set; }
    public string Currency { get; set; } = "PKR";
    public int PaymentGateway_ID { get; set; } = 1;
    public PaymentGatewayType Gateway { get; set; } = PaymentGatewayType.Free;
    public int PaymentStatus_ID { get; set; } = 1;
    public PaymentStatus Status { get; set; } = PaymentStatus.Pending;
    public string? TxnRef { get; set; }
    public string? TransactionReference { get => TxnRef; set => TxnRef = value; }
    public string? GatewayTxnId { get; set; }
    public string? GatewayPayload { get; set; }
    public DateTime CreatedDateTime { get; set; } = DateTime.UtcNow;
    public DateTime CreatedAt { get => CreatedDateTime; set => CreatedDateTime = value; }
    public DateTime? CompletedDateTime { get; set; }
    public DateTime? CompletedAt { get => CompletedDateTime; set => CompletedDateTime = value; }

    // Navigation
    public User? User { get; set; }
    public UserDocument? UserDocument { get; set; }
}
