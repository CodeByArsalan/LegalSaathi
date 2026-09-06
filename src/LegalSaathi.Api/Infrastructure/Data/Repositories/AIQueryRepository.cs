using System.Data;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Domain.Entities;
using Microsoft.Data.SqlClient;

namespace LegalSaathi.Api.Infrastructure.Data.Repositories;

public class AIQueryRepository : IAIQueryRepository
{
    private readonly IDbConnectionFactory _connectionFactory;

    public AIQueryRepository(IDbConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<long> CreateQueryAsync(AiQuery query, CancellationToken cancellationToken = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(cancellationToken);
        await using var command = connection.CreateCommand();
        command.CommandText = "dbo.CreateAIQuery";
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@User_ID", SqlDbType.Int) { Value = (object?)query.User_ID ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@UserDocument_ID", SqlDbType.Int) { Value = (object?)query.UserDocument_ID ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@Template_ID", SqlDbType.Int) { Value = (object?)query.Template_ID ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@Prompt", SqlDbType.NVarChar, -1) { Value = query.Prompt });
        command.Parameters.Add(new SqlParameter("@Response", SqlDbType.NVarChar, -1) { Value = query.Response });
        command.Parameters.Add(new SqlParameter("@LanguageCode", SqlDbType.NVarChar, 10) { Value = query.LanguageCode ?? "ur" });
        command.Parameters.Add(new SqlParameter("@Tokens", SqlDbType.Int) { Value = query.Tokens });
        command.Parameters.Add(new SqlParameter("@PromptTokens", SqlDbType.Int) { Value = query.PromptTokens });
        command.Parameters.Add(new SqlParameter("@CompletionTokens", SqlDbType.Int) { Value = query.CompletionTokens });
        command.Parameters.Add(new SqlParameter("@ModelUsed", SqlDbType.NVarChar, 50) { Value = query.ModelUsed ?? "free-llm" });

        var queryIdParam = new SqlParameter("@QueryID", SqlDbType.BigInt)
        {
            Direction = ParameterDirection.Output
        };
        command.Parameters.Add(queryIdParam);

        await command.ExecuteNonQueryAsync(cancellationToken);

        if (queryIdParam.Value != null && queryIdParam.Value != DBNull.Value)
        {
            query.QueryID = (long)queryIdParam.Value;
            return query.QueryID;
        }

        return 0;
    }

    public async Task<IReadOnlyList<AiQuery>> GetByDocumentIdAsync(int userDocumentId, CancellationToken cancellationToken = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(cancellationToken);
        await using var command = connection.CreateCommand();
        command.CommandText = "dbo.GetAIQueryByDocument";
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserDocument_ID", SqlDbType.Int) { Value = userDocumentId });

        var list = new List<AiQuery>();
        await using var reader = await command.ExecuteReaderAsync(cancellationToken);
        while (await reader.ReadAsync(cancellationToken))
        {
            list.Add(new AiQuery
            {
                QueryID = reader.GetInt64(reader.GetOrdinal("QueryID")),
                User_ID = reader.IsDBNull(reader.GetOrdinal("User_ID")) ? null : reader.GetInt32(reader.GetOrdinal("User_ID")),
                UserDocument_ID = reader.IsDBNull(reader.GetOrdinal("UserDocument_ID")) ? null : reader.GetInt32(reader.GetOrdinal("UserDocument_ID")),
                Prompt = reader.GetString(reader.GetOrdinal("Prompt")),
                Response = reader.GetString(reader.GetOrdinal("Response")),
                LanguageCode = reader.GetString(reader.GetOrdinal("LanguageCode")),
                Tokens = reader.GetInt32(reader.GetOrdinal("Tokens")),
                ModelUsed = reader.GetString(reader.GetOrdinal("ModelUsed")),
                CreatedDateTime = reader.GetDateTime(reader.GetOrdinal("CreatedDateTime"))
            });
        }
        return list;
    }
}
