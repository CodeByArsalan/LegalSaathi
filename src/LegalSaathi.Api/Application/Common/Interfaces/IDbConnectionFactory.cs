using System.Data;
using Microsoft.Data.SqlClient;

namespace LegalSaathi.Api.Application.Common.Interfaces;

/// <summary>
/// Managed ADO.NET connection factory for SQL Server
/// </summary>
public interface IDbConnectionFactory
{
    SqlConnection CreateConnection();
    Task<SqlConnection> CreateOpenConnectionAsync(CancellationToken cancellationToken = default);
}
