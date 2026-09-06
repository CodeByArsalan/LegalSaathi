namespace LegalSaathi.Api.Contracts.Admin;

public record PlatformStatsDto(
    int TotalUsers,
    int TotalDocuments,
    int TotalLawyers,
    int VerifiedLawyers,
    int TotalAiQueries,
    int TotalReviews,
    decimal TotalDutyEstimated
);

public record VerifyLawyerRequest(
    bool IsVerified,
    string? Notes = null
);

public record AuditLogDto(
    long AuditLogId,
    int? UserId,
    string Action,
    string EntityName,
    string? EntityId,
    string? IpAddress,
    string? UserAgent,
    string? IntegrityChecksum,
    DateTime CreatedAt
);

public record AiQuerySummaryDto(
    long QueryId,
    int? UserId,
    int? UserDocumentId,
    int? TemplateId,
    string Prompt,
    string Response,
    string LanguageCode,
    int Tokens,
    string ModelUsed,
    DateTime CreatedAt
);
