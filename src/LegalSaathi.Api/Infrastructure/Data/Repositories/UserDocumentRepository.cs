using System.Data;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Documents;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Data.Repositories;

public class UserDocumentRepository : IUserDocumentRepository
{
    private readonly IDbConnectionFactory _connectionFactory;
    private readonly ILogger<UserDocumentRepository> _logger;

    public UserDocumentRepository(IDbConnectionFactory connectionFactory, ILogger<UserDocumentRepository> logger)
    {
        _connectionFactory = connectionFactory;
        _logger = logger;
    }

    public async Task<(int DocumentId, Guid DocumentGuid)> CreateAsync(int userId, int templateId, string title, string formAnswersJson, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserDocumentCreate;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@User_ID", SqlDbType.Int) { Value = userId });
        command.Parameters.Add(new SqlParameter("@Template_ID", SqlDbType.Int) { Value = templateId });
        command.Parameters.Add(new SqlParameter("@Title", SqlDbType.NVarChar, 250) { Value = title });
        command.Parameters.Add(new SqlParameter("@FormAnswers", SqlDbType.NVarChar, -1) { Value = string.IsNullOrWhiteSpace(formAnswersJson) ? "{}" : formAnswersJson });

        var docIdParam = new SqlParameter("@UserDocumentID", SqlDbType.Int) { Direction = ParameterDirection.Output };
        var docGuidParam = new SqlParameter("@DocumentGuid", SqlDbType.UniqueIdentifier) { Direction = ParameterDirection.Output };

        command.Parameters.Add(docIdParam);
        command.Parameters.Add(docGuidParam);

        await command.ExecuteNonQueryAsync(ct);

        var docId = (int)docIdParam.Value;
        var docGuid = (Guid)docGuidParam.Value;

        return (docId, docGuid);
    }

    public async Task<DocumentDetailDto?> GetByIdAsync(int documentId, int? userId = null, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserDocumentGetById;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserDocumentID", SqlDbType.Int) { Value = documentId });
        command.Parameters.Add(new SqlParameter("@User_ID", SqlDbType.Int) { Value = (object?)userId ?? DBNull.Value });

        await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
        if (await reader.ReadAsync(ct))
        {
            return new DocumentDetailDto(
                UserDocumentId: reader.GetInt32(reader.GetOrdinal("UserDocumentID")),
                DocumentGuid: reader.GetGuid(reader.GetOrdinal("DocumentGuid")),
                UserId: reader.GetInt32(reader.GetOrdinal("User_ID")),
                TemplateId: reader.GetInt32(reader.GetOrdinal("Template_ID")),
                TemplateTitleEn: reader.GetString(reader.GetOrdinal("TemplateTitleEn")),
                TemplateTitleUr: reader.GetString(reader.GetOrdinal("TemplateTitleUr")),
                Title: reader.GetString(reader.GetOrdinal("Title")),
                FormAnswersJson: reader.GetString(reader.GetOrdinal("FormAnswers")),
                Status: reader.IsDBNull(reader.GetOrdinal("Status")) ? "Draft" : reader.GetString(reader.GetOrdinal("Status")),
                StatusId: reader.IsDBNull(reader.GetOrdinal("DocumentStatus_ID")) ? 1 : reader.GetInt32(reader.GetOrdinal("DocumentStatus_ID")),
                StoragePath: reader.IsDBNull(reader.GetOrdinal("StoragePath")) ? null : reader.GetString(reader.GetOrdinal("StoragePath")),
                DocxStoragePath: reader.IsDBNull(reader.GetOrdinal("DocxStoragePath")) ? null : reader.GetString(reader.GetOrdinal("DocxStoragePath")),
                DocumentHash: reader.IsDBNull(reader.GetOrdinal("DocumentHash")) ? null : reader.GetString(reader.GetOrdinal("DocumentHash")),
                IsPaid: reader.GetBoolean(reader.GetOrdinal("IsPaid")),
                CreatedAt: reader.GetDateTime(reader.GetOrdinal("CreatedAt")),
                UpdatedAt: reader.IsDBNull(reader.GetOrdinal("UpdatedAt")) ? null : reader.GetDateTime(reader.GetOrdinal("UpdatedAt")),
                CompletedAt: reader.IsDBNull(reader.GetOrdinal("CompletedAt")) ? null : reader.GetDateTime(reader.GetOrdinal("CompletedAt"))
            );
        }

        return null;
    }

    public async Task<List<DocumentSummaryDto>> GetByUserAsync(int userId, CancellationToken ct = default)
    {
        var list = new List<DocumentSummaryDto>();
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserDocumentGetByUser;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@User_ID", SqlDbType.Int) { Value = userId });

        await using var reader = await command.ExecuteReaderAsync(ct);
        while (await reader.ReadAsync(ct))
        {
            list.Add(new DocumentSummaryDto(
                UserDocumentId: reader.GetInt32(reader.GetOrdinal("UserDocumentID")),
                DocumentGuid: reader.GetGuid(reader.GetOrdinal("DocumentGuid")),
                TemplateId: reader.GetInt32(reader.GetOrdinal("Template_ID")),
                TemplateTitleEn: reader.GetString(reader.GetOrdinal("TemplateTitleEn")),
                TemplateTitleUr: reader.GetString(reader.GetOrdinal("TemplateTitleUr")),
                Title: reader.GetString(reader.GetOrdinal("Title")),
                Status: reader.IsDBNull(reader.GetOrdinal("Status")) ? "Draft" : reader.GetString(reader.GetOrdinal("Status")),
                StatusId: reader.IsDBNull(reader.GetOrdinal("DocumentStatus_ID")) ? 1 : reader.GetInt32(reader.GetOrdinal("DocumentStatus_ID")),
                IsPaid: reader.GetBoolean(reader.GetOrdinal("IsPaid")),
                CreatedAt: reader.GetDateTime(reader.GetOrdinal("CreatedAt")),
                CompletedAt: reader.IsDBNull(reader.GetOrdinal("CompletedAt")) ? null : reader.GetDateTime(reader.GetOrdinal("CompletedAt"))
            ));
        }

        return list;
    }

    public async Task<bool> UpdateAnswersAsync(int documentId, int userId, string formAnswersJson, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserDocumentUpdateAnswers;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserDocumentID", SqlDbType.Int) { Value = documentId });
        command.Parameters.Add(new SqlParameter("@User_ID", SqlDbType.Int) { Value = userId });
        command.Parameters.Add(new SqlParameter("@FormAnswers", SqlDbType.NVarChar, -1) { Value = formAnswersJson });

        var rows = await command.ExecuteNonQueryAsync(ct);
        return rows > 0;
    }

    public async Task<bool> UpdateStatusAsync(int documentId, int statusId, string? storagePath = null, string? docxStoragePath = null, string? documentHash = null, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserDocumentUpdateStatus;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserDocumentID", SqlDbType.Int) { Value = documentId });
        command.Parameters.Add(new SqlParameter("@DocumentStatus_ID", SqlDbType.Int) { Value = statusId });
        command.Parameters.Add(new SqlParameter("@StoragePath", SqlDbType.NVarChar, 500) { Value = (object?)storagePath ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@DocxStoragePath", SqlDbType.NVarChar, 500) { Value = (object?)docxStoragePath ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@DocumentHash", SqlDbType.NVarChar, 128) { Value = (object?)documentHash ?? DBNull.Value });

        var rows = await command.ExecuteNonQueryAsync(ct);
        return rows > 0;
    }
}
