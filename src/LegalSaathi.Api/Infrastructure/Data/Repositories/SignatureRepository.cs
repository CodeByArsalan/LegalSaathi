using System.Data;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Domain.Entities;
using Microsoft.Data.SqlClient;

namespace LegalSaathi.Api.Infrastructure.Data.Repositories;

public class SignatureRepository : ISignatureRepository
{
    private readonly IDbConnectionFactory _connectionFactory;

    public SignatureRepository(IDbConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<long> CreateSignatureAsync(Signature signature, CancellationToken cancellationToken = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(cancellationToken);
        await using var command = connection.CreateCommand();
        command.CommandText = "dbo.CreateSignature";
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserDocument_ID", SqlDbType.Int) { Value = signature.UserDocument_ID });
        command.Parameters.Add(new SqlParameter("@SignerName", SqlDbType.NVarChar, 150) { Value = signature.SignerName });
        command.Parameters.Add(new SqlParameter("@SignerCnic", SqlDbType.NVarChar, 20) { Value = signature.SignerCnic });
        command.Parameters.Add(new SqlParameter("@SignerRole", SqlDbType.NVarChar, 100) { Value = signature.SignerRole });
        command.Parameters.Add(new SqlParameter("@SignerEmail", SqlDbType.NVarChar, 256) { Value = (object?)signature.SignerEmail ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@SignerPhone", SqlDbType.NVarChar, 20) { Value = (object?)signature.SignerPhone ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@SignatureUri", SqlDbType.NVarChar, 500) { Value = signature.SignatureUri });
        command.Parameters.Add(new SqlParameter("@OtpVerified", SqlDbType.Bit) { Value = signature.OtpVerified });
        command.Parameters.Add(new SqlParameter("@OtpCodeHash", SqlDbType.NVarChar, 256) { Value = (object?)signature.OtpCodeHash ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@IpAddress", SqlDbType.NVarChar, 50) { Value = (object?)signature.IpAddress ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@UserAgent", SqlDbType.NVarChar, 500) { Value = (object?)signature.UserAgent ?? DBNull.Value });

        var signatureIdParam = new SqlParameter("@SignatureID", SqlDbType.BigInt)
        {
            Direction = ParameterDirection.Output
        };
        command.Parameters.Add(signatureIdParam);

        await command.ExecuteNonQueryAsync(cancellationToken);

        if (signatureIdParam.Value != null && signatureIdParam.Value != DBNull.Value)
        {
            signature.SignatureID = (long)signatureIdParam.Value;
            return signature.SignatureID;
        }

        return 0;
    }

    public async Task<IReadOnlyList<Signature>> GetByDocumentIdAsync(int userDocumentId, CancellationToken cancellationToken = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(cancellationToken);
        await using var command = connection.CreateCommand();
        command.CommandText = "dbo.GetSignatureByDocumentId";
        command.CommandType = CommandType.StoredProcedure;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserDocument_ID", SqlDbType.Int) { Value = userDocumentId });

        var list = new List<Signature>();
        await using var reader = await command.ExecuteReaderAsync(cancellationToken);
        while (await reader.ReadAsync(cancellationToken))
        {
            list.Add(new Signature
            {
                SignatureID = reader.GetInt64(reader.GetOrdinal("SignatureID")),
                UserDocument_ID = reader.GetInt32(reader.GetOrdinal("UserDocument_ID")),
                SignerName = reader.GetString(reader.GetOrdinal("SignerName")),
                SignerCnic = reader.GetString(reader.GetOrdinal("SignerCnic")),
                SignerRole = reader.GetString(reader.GetOrdinal("SignerRole")),
                SignerEmail = reader.IsDBNull(reader.GetOrdinal("SignerEmail")) ? null : reader.GetString(reader.GetOrdinal("SignerEmail")),
                SignerPhone = reader.IsDBNull(reader.GetOrdinal("SignerPhone")) ? null : reader.GetString(reader.GetOrdinal("SignerPhone")),
                SignatureUri = reader.GetString(reader.GetOrdinal("SignatureUri")),
                OtpVerified = reader.GetBoolean(reader.GetOrdinal("OtpVerified")),
                IpAddress = reader.IsDBNull(reader.GetOrdinal("IpAddress")) ? null : reader.GetString(reader.GetOrdinal("IpAddress")),
                SignedDateTime = reader.GetDateTime(reader.GetOrdinal("SignedAt"))
            });
        }
        return list;
    }
}
