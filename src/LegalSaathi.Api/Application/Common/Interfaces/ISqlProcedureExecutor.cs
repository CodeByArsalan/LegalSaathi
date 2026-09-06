using System.Data;
using Microsoft.Data.SqlClient;

namespace LegalSaathi.Api.Application.Common.Interfaces;

/// <summary>
/// Parameterized ADO.NET Stored Procedure Execution Abstraction
/// </summary>
public interface ISqlProcedureExecutor
{
    Task<T?> ExecuteSingleAsync<T>(
        string procedureName, 
        Func<SqlDataReader, T> map, 
        SqlParameter[]? parameters = null, 
        CancellationToken cancellationToken = default);

    Task<List<T>> ExecuteListAsync<T>(
        string procedureName, 
        Func<SqlDataReader, T> map, 
        SqlParameter[]? parameters = null, 
        CancellationToken cancellationToken = default);

    Task<int> ExecuteNonQueryAsync(
        string procedureName, 
        SqlParameter[]? parameters = null, 
        CancellationToken cancellationToken = default);

    Task<object?> ExecuteScalarAsync(
        string procedureName, 
        SqlParameter[]? parameters = null, 
        CancellationToken cancellationToken = default);
}
