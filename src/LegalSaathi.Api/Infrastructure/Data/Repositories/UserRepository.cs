using System.Data;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Domain.Entities;
using LegalSaathi.Api.Domain.Enums;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Data.Repositories;

public class UserRepository : IUserRepository
{
    private readonly IDbConnectionFactory _connectionFactory;
    private readonly ILogger<UserRepository> _logger;

    public UserRepository(IDbConnectionFactory connectionFactory, ILogger<UserRepository> logger)
    {
        _connectionFactory = connectionFactory;
        _logger = logger;
    }

    public async Task<int> CreateUserAsync(User user, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserCreate;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@Name", SqlDbType.NVarChar, 150) { Value = user.Name });
        command.Parameters.Add(new SqlParameter("@Email", SqlDbType.NVarChar, 256) { Value = user.Email });
        command.Parameters.Add(new SqlParameter("@Phone", SqlDbType.NVarChar, 20) { Value = user.Phone });
        command.Parameters.Add(new SqlParameter("@PasswordHash", SqlDbType.NVarChar, 500) { Value = user.PasswordHash });
        command.Parameters.Add(new SqlParameter("@Role_ID", SqlDbType.Int) { Value = user.Role_ID ?? (int)user.Role });
        command.Parameters.Add(new SqlParameter("@Cnic", SqlDbType.NVarChar, 20) { Value = (object?)user.Cnic ?? DBNull.Value });

        var userIdParam = new SqlParameter("@UserID", SqlDbType.Int)
        {
            Direction = ParameterDirection.Output
        };
        command.Parameters.Add(userIdParam);

        await command.ExecuteNonQueryAsync(ct);

        var newUserId = (int)userIdParam.Value;
        user.UserID = newUserId;
        return newUserId;
    }

    public async Task<User?> GetByIdAsync(int userId, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserGetById;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int) { Value = userId });

        await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
        if (await reader.ReadAsync(ct))
        {
            return MapUserFromReader(reader, includeCredentials: false);
        }

        return null;
    }

    public async Task<User?> GetByEmailAsync(string email, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserGetByEmail;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@Email", SqlDbType.NVarChar, 256) { Value = email });

        await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
        if (await reader.ReadAsync(ct))
        {
            return MapUserFromReader(reader, includeCredentials: false);
        }

        return null;
    }

    public async Task<User?> GetByEmailOrPhoneAsync(string identifier, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserGetByEmailOrPhone;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@Identifier", SqlDbType.NVarChar, 256) { Value = identifier });

        await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
        if (await reader.ReadAsync(ct))
        {
            return MapUserFromReader(reader, includeCredentials: true);
        }

        return null;
    }

    public async Task<bool> UpdateUserAsync(int userId, string name, string phone, string? cnic, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserUpdate;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int) { Value = userId });
        command.Parameters.Add(new SqlParameter("@Name", SqlDbType.NVarChar, 150) { Value = name });
        command.Parameters.Add(new SqlParameter("@Phone", SqlDbType.NVarChar, 20) { Value = phone });
        command.Parameters.Add(new SqlParameter("@Cnic", SqlDbType.NVarChar, 20) { Value = (object?)cnic ?? DBNull.Value });

        var rows = await command.ExecuteNonQueryAsync(ct);
        return rows > 0;
    }

    public async Task<bool> UpdateRefreshTokenAsync(int userId, string refreshToken, DateTime expiryTime, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserUpdateRefreshToken;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int) { Value = userId });
        command.Parameters.Add(new SqlParameter("@RefreshToken", SqlDbType.NVarChar, 500) { Value = refreshToken });
        command.Parameters.Add(new SqlParameter("@RefreshTokenExpiryDateTime", SqlDbType.DateTime2) { Value = expiryTime });

        var rows = await command.ExecuteNonQueryAsync(ct);
        return rows > 0;
    }

    public async Task<User?> GetByRefreshTokenAsync(string refreshToken, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = "SELECT TOP 1 * FROM dbo.Users WHERE RefreshToken = @RefreshToken";
        command.CommandType = CommandType.Text;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@RefreshToken", SqlDbType.NVarChar, 500) { Value = refreshToken });

        await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
        if (await reader.ReadAsync(ct))
        {
            return MapUserFromReader(reader, includeCredentials: true);
        }

        return null;
    }

    public async Task<bool> VerifyEmailAsync(int userId, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpUserVerifyEmail;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int) { Value = userId });

        var rows = await command.ExecuteNonQueryAsync(ct);
        return rows > 0;
    }

    private static User MapUserFromReader(SqlDataReader reader, bool includeCredentials)
    {
        var user = new User
        {
            UserID = reader.GetInt32(reader.GetOrdinal("UserID")),
            Name = reader.IsDBNull(reader.GetOrdinal("Name")) ? "" : reader.GetString(reader.GetOrdinal("Name")),
            Email = reader.IsDBNull(reader.GetOrdinal("Email")) ? "" : reader.GetString(reader.GetOrdinal("Email")),
            Phone = reader.IsDBNull(reader.GetOrdinal("Phone")) ? "" : reader.GetString(reader.GetOrdinal("Phone")),
            Role_ID = reader.IsDBNull(reader.GetOrdinal("Role_ID")) ? 2 : reader.GetInt32(reader.GetOrdinal("Role_ID")),
            Role = reader.IsDBNull(reader.GetOrdinal("Role_ID")) ? UserRole.EndUser : (UserRole)reader.GetInt32(reader.GetOrdinal("Role_ID")),
            Cnic = reader.IsDBNull(reader.GetOrdinal("Cnic")) ? null : reader.GetString(reader.GetOrdinal("Cnic")),
            IsEmailVerified = !reader.IsDBNull(reader.GetOrdinal("IsEmailVerified")) && reader.GetBoolean(reader.GetOrdinal("IsEmailVerified")),
            IsActive = reader.IsDBNull(reader.GetOrdinal("IsActive")) || reader.GetBoolean(reader.GetOrdinal("IsActive")),
            CreatedDateTime = reader.IsDBNull(reader.GetOrdinal("CreatedDateTime")) ? DateTime.UtcNow : reader.GetDateTime(reader.GetOrdinal("CreatedDateTime"))
        };

        if (HasColumn(reader, "UpdatedDateTime") && !reader.IsDBNull(reader.GetOrdinal("UpdatedDateTime")))
        {
            user.UpdatedDateTime = reader.GetDateTime(reader.GetOrdinal("UpdatedDateTime"));
        }

        if (includeCredentials)
        {
            if (HasColumn(reader, "PasswordHash") && !reader.IsDBNull(reader.GetOrdinal("PasswordHash")))
            {
                user.PasswordHash = reader.GetString(reader.GetOrdinal("PasswordHash"));
            }

            if (HasColumn(reader, "RefreshToken") && !reader.IsDBNull(reader.GetOrdinal("RefreshToken")))
            {
                user.RefreshToken = reader.GetString(reader.GetOrdinal("RefreshToken"));
            }

            if (HasColumn(reader, "RefreshTokenExpiryDateTime") && !reader.IsDBNull(reader.GetOrdinal("RefreshTokenExpiryDateTime")))
            {
                user.RefreshTokenExpiryDateTime = reader.GetDateTime(reader.GetOrdinal("RefreshTokenExpiryDateTime"));
            }
        }

        return user;
    }

    private static bool HasColumn(SqlDataReader reader, string columnName)
    {
        for (int i = 0; i < reader.FieldCount; i++)
        {
            if (reader.GetName(i).Equals(columnName, StringComparison.OrdinalIgnoreCase))
                return true;
        }
        return false;
    }
}
