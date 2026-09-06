namespace LegalSaathi.Api.Domain.Entities;

public class AuditLog
{
    public long AuditLogID { get; set; }
    public long AuditLogId { get => AuditLogID; set => AuditLogID = value; }
    public int? User_ID { get; set; }
    public int? UserId { get => User_ID; set => User_ID = value; }
    public string Action { get; set; } = string.Empty;
    public string EntityName { get; set; } = string.Empty;
    public string? EntityID { get; set; }
    public string? EntityId { get => EntityID; set => EntityID = value; }
    public string? IpAddress { get; set; }
    public string? UserAgent { get; set; }
    public string? OldValuesJson { get; set; }
    public string? NewValuesJson { get; set; }
    public string? IntegrityChecksum { get; set; }
    public DateTime? CreatedDateTime { get; set; } = DateTime.UtcNow;
    public DateTime TimestampUtc { get => CreatedDateTime ?? DateTime.UtcNow; set => CreatedDateTime = value; }
}
