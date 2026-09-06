using System.Data;
using System.Security.Cryptography;
using System.Text;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Infrastructure.Data;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

public class AuditLogService : IAuditLogService
{
    private readonly IDbConnectionFactory _connectionFactory;
    private readonly ILogger<AuditLogService> _logger;

    public AuditLogService(IDbConnectionFactory connectionFactory, ILogger<AuditLogService> logger)
    {
        _connectionFactory = connectionFactory;
        _logger = logger;
    }

    public async Task<long> LogAsync(
        int? userId,
        string action,
        string entityName,
        string? entityId = null,
        string? ipAddress = null,
        string? userAgent = null,
        string? oldValuesJson = null,
        string? newValuesJson = null,
        CancellationToken ct = default)
    {
        try
        {
            var rawData = $"{userId}:{action}:{entityName}:{entityId}:{ipAddress}:{oldValuesJson}:{newValuesJson}:{DateTime.UtcNow:yyyyMMddHHmmss}";
            var checksum = ComputeSha256Hash(rawData);

            await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
            await using var command = connection.CreateCommand();
            command.CommandText = DbConstants.Procedures.SpAuditLogCreate;
            command.CommandType = CommandType.StoredProcedure;
            command.CommandTimeout = 30;

            command.Parameters.Add(new SqlParameter("@User_ID", SqlDbType.Int) { Value = (object?)userId ?? DBNull.Value });
            command.Parameters.Add(new SqlParameter("@Action", SqlDbType.NVarChar, 100) { Value = action });
            command.Parameters.Add(new SqlParameter("@EntityName", SqlDbType.NVarChar, 100) { Value = entityName });
            command.Parameters.Add(new SqlParameter("@EntityID", SqlDbType.NVarChar, 100) { Value = (object?)entityId ?? DBNull.Value });
            command.Parameters.Add(new SqlParameter("@IpAddress", SqlDbType.NVarChar, 50) { Value = (object?)ipAddress ?? DBNull.Value });
            command.Parameters.Add(new SqlParameter("@UserAgent", SqlDbType.NVarChar, 500) { Value = (object?)userAgent ?? DBNull.Value });
            command.Parameters.Add(new SqlParameter("@OldValuesJson", SqlDbType.NVarChar, -1) { Value = (object?)oldValuesJson ?? DBNull.Value });
            command.Parameters.Add(new SqlParameter("@NewValuesJson", SqlDbType.NVarChar, -1) { Value = (object?)newValuesJson ?? DBNull.Value });
            command.Parameters.Add(new SqlParameter("@IntegrityChecksum", SqlDbType.NVarChar, 128) { Value = checksum });

            var auditLogIdParam = new SqlParameter("@AuditLogID", SqlDbType.BigInt)
            {
                Direction = ParameterDirection.Output
            };
            command.Parameters.Add(auditLogIdParam);

            await command.ExecuteNonQueryAsync(ct);

            return auditLogIdParam.Value is long id ? id : (long)Convert.ToInt64(auditLogIdParam.Value);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to write audit log for {Action} on {EntityName}", action, entityName);
            return 0;
        }
    }

    private static string ComputeSha256Hash(string rawData)
    {
        var bytes = SHA256.HashData(Encoding.UTF8.GetBytes(rawData));
        return Convert.ToHexString(bytes).ToLowerInvariant();
    }
}
