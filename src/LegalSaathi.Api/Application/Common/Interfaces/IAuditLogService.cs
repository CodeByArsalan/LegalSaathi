namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface IAuditLogService
{
    Task<long> LogAsync(
        int? userId,
        string action,
        string entityName,
        string? entityId = null,
        string? ipAddress = null,
        string? userAgent = null,
        string? oldValuesJson = null,
        string? newValuesJson = null,
        CancellationToken ct = default);
}
