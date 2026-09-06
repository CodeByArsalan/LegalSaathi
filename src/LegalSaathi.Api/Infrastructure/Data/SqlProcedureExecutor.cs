using System.Data;
using LegalSaathi.Api.Application.Common.Interfaces;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Data;

public class SqlProcedureExecutor : ISqlProcedureExecutor
{
    private readonly IDbConnectionFactory _connectionFactory;
    private readonly ILogger<SqlProcedureExecutor> _logger;

    public SqlProcedureExecutor(IDbConnectionFactory connectionFactory, ILogger<SqlProcedureExecutor> logger)
    {
        _connectionFactory = connectionFactory;
        _logger = logger;
    }

    public async Task<T?> ExecuteSingleAsync<T>(
        string procedureName, 
        Func<SqlDataReader, T> map, 
        SqlParameter[]? parameters = null, 
        CancellationToken cancellationToken = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(cancellationToken);
        await using var command = CreateCommand(connection, procedureName, parameters);

        try
        {
            await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, cancellationToken);
            if (await reader.ReadAsync(cancellationToken))
            {
                return map(reader);
            }

            return default;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error executing stored procedure {ProcedureName}", procedureName);
            throw;
        }
    }

    public async Task<List<T>> ExecuteListAsync<T>(
        string procedureName, 
        Func<SqlDataReader, T> map, 
        SqlParameter[]? parameters = null, 
        CancellationToken cancellationToken = default)
    {
        var results = new List<T>();
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(cancellationToken);
        await using var command = CreateCommand(connection, procedureName, parameters);

        try
        {
            await using var reader = await command.ExecuteReaderAsync(cancellationToken);
            while (await reader.ReadAsync(cancellationToken))
            {
                results.Add(map(reader));
            }

            return results;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error executing stored procedure list query {ProcedureName}", procedureName);
            throw;
        }
    }

    public async Task<int> ExecuteNonQueryAsync(
        string procedureName, 
        SqlParameter[]? parameters = null, 
        CancellationToken cancellationToken = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(cancellationToken);
        await using var command = CreateCommand(connection, procedureName, parameters);

        try
        {
            return await command.ExecuteNonQueryAsync(cancellationToken);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error executing stored procedure non-query {ProcedureName}", procedureName);
            throw;
        }
    }

    public async Task<object?> ExecuteScalarAsync(
        string procedureName, 
        SqlParameter[]? parameters = null, 
        CancellationToken cancellationToken = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(cancellationToken);
        await using var command = CreateCommand(connection, procedureName, parameters);

        try
        {
            return await command.ExecuteScalarAsync(cancellationToken);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error executing stored procedure scalar {ProcedureName}", procedureName);
            throw;
        }
    }

    private static SqlCommand CreateCommand(SqlConnection connection, string procedureName, SqlParameter[]? parameters)
    {
        var command = connection.CreateCommand();
        command.CommandText = procedureName;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30; // 30s timeout

        if (parameters != null && parameters.Length > 0)
        {
            foreach (var parameter in parameters)
            {
                if (parameter.Value == null)
                {
                    parameter.Value = DBNull.Value;
                }
                command.Parameters.Add(parameter);
            }
        }

        return command;
    }
}
