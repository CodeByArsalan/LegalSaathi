using System.Data;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Lawyers;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Data.Repositories;

public class LawyerRepository : ILawyerRepository
{
    private readonly IDbConnectionFactory _connectionFactory;
    private readonly ILogger<LawyerRepository> _logger;

    private static readonly List<LawyerDto> SeedLawyers = new()
    {
        new LawyerDto(
            LawyerId: 1,
            UserId: 101,
            FullName: "Advocate Muhammad Arsalan Khan",
            Email: "arsalan.lawyer@legalsaathi.pk",
            PhoneNumber: "03001234567",
            BarCouncilNumber: "LHC-18492/2016",
            BarCouncilProvince: "Punjab",
            Specialization: "Corporate, Commercial Contracts & Property Law",
            YearsOfExperience: 9,
            OfficeAddress: "Chamber 14, Turner Road, Lahore High Court, Lahore",
            VerifiedStatus: true,
            Rating: 4.95m,
            TotalReviewsCompleted: 142,
            CreatedDateTime: DateTime.UtcNow.AddYears(-3)),
        new LawyerDto(
            LawyerId: 2,
            UserId: 102,
            FullName: "Advocate Fatima Noor Shah",
            Email: "fatima.shah@legalsaathi.pk",
            PhoneNumber: "03219876543",
            BarCouncilNumber: "SHC-93821/2018",
            BarCouncilProvince: "Sindh",
            Specialization: "Tenancy, Real Estate & Rental Disputes",
            YearsOfExperience: 7,
            OfficeAddress: "High Court Road, Saddar, Karachi",
            VerifiedStatus: true,
            Rating: 4.88m,
            TotalReviewsCompleted: 98,
            CreatedDateTime: DateTime.UtcNow.AddYears(-2)),
        new LawyerDto(
            LawyerId: 3,
            UserId: 103,
            FullName: "Advocate Tariq Mehmood Chaudhry",
            Email: "tariq.mehmood@legalsaathi.pk",
            PhoneNumber: "03335554433",
            BarCouncilNumber: "IHC-55420/2014",
            BarCouncilProvince: "Islamabad",
            Specialization: "Affidavits, Power of Attorney & Civil Litigation",
            YearsOfExperience: 12,
            OfficeAddress: "Sector G-10/4, Islamabad High Court Bar, Islamabad",
            VerifiedStatus: true,
            Rating: 4.92m,
            TotalReviewsCompleted: 215,
            CreatedDateTime: DateTime.UtcNow.AddYears(-4)),
        new LawyerDto(
            LawyerId: 4,
            UserId: 104,
            FullName: "Advocate Ayesha Jahangir",
            Email: "ayesha.jahangir@legalsaathi.pk",
            PhoneNumber: "03456677889",
            BarCouncilNumber: "KPBC-44109/2019",
            BarCouncilProvince: "KPK",
            Specialization: "Employment, NDAs & Service Contracts",
            YearsOfExperience: 6,
            OfficeAddress: "Khyber Pass Chambers, Peshawar High Court, Peshawar",
            VerifiedStatus: true,
            Rating: 4.85m,
            TotalReviewsCompleted: 76,
            CreatedDateTime: DateTime.UtcNow.AddYears(-2))
    };

    public LawyerRepository(IDbConnectionFactory connectionFactory, ILogger<LawyerRepository> logger)
    {
        _connectionFactory = connectionFactory;
        _logger = logger;
    }

    public async Task<IReadOnlyList<LawyerDto>> GetVerifiedLawyersAsync(string? province = null, string? specialization = null, CancellationToken ct = default)
    {
        try
        {
            await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
            await using var command = connection.CreateCommand();
            command.CommandText = @"
                SELECT l.LawyerID, l.User_ID, u.Name AS FullName, u.Email, u.Phone AS PhoneNumber,
                       l.BarCouncilNumber, l.BarCouncilProvince, l.Specialization, l.YearsOfExperience,
                       l.OfficeAddress, l.VerifiedStatus, l.Rating, l.TotalReviewsCompleted, l.CreatedDateTime
                FROM dbo.Lawyers l
                INNER JOIN dbo.Users u ON l.User_ID = u.UserID
                WHERE l.VerifiedStatus = 1";
            command.CommandType = CommandType.Text;
            command.CommandTimeout = 30;

            var list = new List<LawyerDto>();
            await using var reader = await command.ExecuteReaderAsync(ct);
            while (await reader.ReadAsync(ct))
            {
                list.Add(MapLawyerFromReader(reader));
            }

            if (list.Count > 0)
            {
                var filtered = list.AsEnumerable();
                if (!string.IsNullOrWhiteSpace(province))
                    filtered = filtered.Where(l => l.BarCouncilProvince.Equals(province, StringComparison.OrdinalIgnoreCase));
                if (!string.IsNullOrWhiteSpace(specialization))
                    filtered = filtered.Where(l => l.Specialization.Contains(specialization, StringComparison.OrdinalIgnoreCase));
                return filtered.ToList();
            }
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Failed to query database for lawyers. Falling back to verified seed registry.");
        }

        var result = SeedLawyers.AsEnumerable();
        if (!string.IsNullOrWhiteSpace(province))
            result = result.Where(l => l.BarCouncilProvince.Equals(province, StringComparison.OrdinalIgnoreCase));
        if (!string.IsNullOrWhiteSpace(specialization))
            result = result.Where(l => l.Specialization.Contains(specialization, StringComparison.OrdinalIgnoreCase));
        return result.ToList();
    }

    public async Task<LawyerDto?> GetLawyerByIdAsync(int lawyerId, CancellationToken ct = default)
    {
        try
        {
            await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
            await using var command = connection.CreateCommand();
            command.CommandText = @"
                SELECT l.LawyerID, l.User_ID, u.Name AS FullName, u.Email, u.Phone AS PhoneNumber,
                       l.BarCouncilNumber, l.BarCouncilProvince, l.Specialization, l.YearsOfExperience,
                       l.OfficeAddress, l.VerifiedStatus, l.Rating, l.TotalReviewsCompleted, l.CreatedDateTime
                FROM dbo.Lawyers l
                INNER JOIN dbo.Users u ON l.User_ID = u.UserID
                WHERE l.LawyerID = @LawyerID";
            command.CommandType = CommandType.Text;
            command.Parameters.Add(new SqlParameter("@LawyerID", SqlDbType.Int) { Value = lawyerId });

            await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
            if (await reader.ReadAsync(ct))
            {
                return MapLawyerFromReader(reader);
            }
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Failed to query lawyer by ID from DB. Falling back to seed registry.");
        }

        return SeedLawyers.FirstOrDefault(l => l.LawyerId == lawyerId);
    }

    public async Task<LawyerDto?> GetLawyerByUserIdAsync(int userId, CancellationToken ct = default)
    {
        try
        {
            await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
            await using var command = connection.CreateCommand();
            command.CommandText = @"
                SELECT l.LawyerID, l.User_ID, u.Name AS FullName, u.Email, u.Phone AS PhoneNumber,
                       l.BarCouncilNumber, l.BarCouncilProvince, l.Specialization, l.YearsOfExperience,
                       l.OfficeAddress, l.VerifiedStatus, l.Rating, l.TotalReviewsCompleted, l.CreatedDateTime
                FROM dbo.Lawyers l
                INNER JOIN dbo.Users u ON l.User_ID = u.UserID
                WHERE l.User_ID = @UserID";
            command.CommandType = CommandType.Text;
            command.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int) { Value = userId });

            await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
            if (await reader.ReadAsync(ct))
            {
                return MapLawyerFromReader(reader);
            }
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Failed to query lawyer by User_ID from DB.");
        }

        return SeedLawyers.FirstOrDefault(l => l.UserId == userId);
    }

    public async Task<long> CreateLawyerReviewAsync(int userDocumentId, int? lawyerId, string? notes, decimal fee, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = @"
            INSERT INTO dbo.LawyerReviews (
                UserDocument_ID, Lawyer_ID, Notes, AnnotatedPdfPath, ReviewFee,
                LawyerShareAmount, PlatformShareAmount, LawyerReviewStatus_ID,
                RequesteDateTime, AssignedDateTime, CompletedDateTime
            )
            OUTPUT INSERTED.LawyerReviewID
            VALUES (
                @UserDocument_ID, @Lawyer_ID, @Notes, NULL, @ReviewFee,
                0, 0, @Status_ID,
                SYSUTCDATETIME(), @AssignedDateTime, NULL
            )";
        command.CommandType = CommandType.Text;
        command.CommandTimeout = 30;

        command.Parameters.Add(new SqlParameter("@UserDocument_ID", SqlDbType.Int) { Value = userDocumentId });
        command.Parameters.Add(new SqlParameter("@Lawyer_ID", SqlDbType.Int) { Value = (object?)lawyerId ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@Notes", SqlDbType.NVarChar, -1) { Value = (object?)notes ?? DBNull.Value });
        command.Parameters.Add(new SqlParameter("@ReviewFee", SqlDbType.Decimal) { Value = fee });
        command.Parameters.Add(new SqlParameter("@Status_ID", SqlDbType.Int) { Value = lawyerId.HasValue ? 2 : 1 }); // 1=Requested, 2=Assigned
        command.Parameters.Add(new SqlParameter("@AssignedDateTime", SqlDbType.DateTime2) { Value = lawyerId.HasValue ? DateTime.UtcNow : DBNull.Value });

        var newId = await command.ExecuteScalarAsync(ct);
        return newId != null ? Convert.ToInt64(newId) : 0L;
    }

    public async Task<LawyerReviewDto?> GetReviewByIdAsync(long reviewId, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = GetReviewQuerySql("WHERE r.LawyerReviewID = @ReviewID");
        command.Parameters.Add(new SqlParameter("@ReviewID", SqlDbType.BigInt) { Value = reviewId });

        await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
        if (await reader.ReadAsync(ct))
        {
            return MapReviewFromReader(reader);
        }
        return null;
    }

    public async Task<IReadOnlyList<LawyerReviewDto>> GetReviewsByUserAsync(int userId, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = GetReviewQuerySql("WHERE d.User_ID = @UserID ORDER BY r.RequesteDateTime DESC");
        command.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int) { Value = userId });

        var list = new List<LawyerReviewDto>();
        await using var reader = await command.ExecuteReaderAsync(ct);
        while (await reader.ReadAsync(ct))
        {
            list.Add(MapReviewFromReader(reader));
        }
        return list;
    }

    public async Task<IReadOnlyList<LawyerReviewDto>> GetReviewsByLawyerAsync(int lawyerId, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = GetReviewQuerySql("WHERE r.Lawyer_ID = @LawyerID ORDER BY r.RequesteDateTime DESC");
        command.Parameters.Add(new SqlParameter("@LawyerID", SqlDbType.Int) { Value = lawyerId });

        var list = new List<LawyerReviewDto>();
        await using var reader = await command.ExecuteReaderAsync(ct);
        while (await reader.ReadAsync(ct))
        {
            list.Add(MapReviewFromReader(reader));
        }
        return list;
    }

    public async Task<IReadOnlyList<LawyerReviewDto>> GetReviewsByDocumentAsync(int documentId, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = GetReviewQuerySql("WHERE r.UserDocument_ID = @DocumentID ORDER BY r.RequesteDateTime DESC");
        command.Parameters.Add(new SqlParameter("@DocumentID", SqlDbType.Int) { Value = documentId });

        var list = new List<LawyerReviewDto>();
        await using var reader = await command.ExecuteReaderAsync(ct);
        while (await reader.ReadAsync(ct))
        {
            list.Add(MapReviewFromReader(reader));
        }
        return list;
    }

    public async Task<bool> AssignLawyerAsync(long reviewId, int lawyerId, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = @"
            UPDATE dbo.LawyerReviews
            SET Lawyer_ID = @LawyerID,
                LawyerReviewStatus_ID = 2,
                AssignedDateTime = SYSUTCDATETIME()
            WHERE LawyerReviewID = @ReviewID";
        command.Parameters.Add(new SqlParameter("@ReviewID", SqlDbType.BigInt) { Value = reviewId });
        command.Parameters.Add(new SqlParameter("@LawyerID", SqlDbType.Int) { Value = lawyerId });

        var rows = await command.ExecuteNonQueryAsync(ct);
        return rows > 0;
    }

    public async Task<bool> UpdateReviewFeedbackAsync(long reviewId, int statusId, string notes, string? annotatedPdfPath, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = @"
            UPDATE dbo.LawyerReviews
            SET LawyerReviewStatus_ID = @StatusID,
                Notes = @Notes,
                AnnotatedPdfPath = ISNULL(@AnnotatedPdfPath, AnnotatedPdfPath),
                CompletedDateTime = SYSUTCDATETIME()
            WHERE LawyerReviewID = @ReviewID";
        command.Parameters.Add(new SqlParameter("@ReviewID", SqlDbType.BigInt) { Value = reviewId });
        command.Parameters.Add(new SqlParameter("@StatusID", SqlDbType.Int) { Value = statusId });
        command.Parameters.Add(new SqlParameter("@Notes", SqlDbType.NVarChar, -1) { Value = notes });
        command.Parameters.Add(new SqlParameter("@AnnotatedPdfPath", SqlDbType.NVarChar, 500) { Value = (object?)annotatedPdfPath ?? DBNull.Value });

        var rows = await command.ExecuteNonQueryAsync(ct);
        return rows > 0;
    }

    private static string GetReviewQuerySql(string filter) => $@"
        SELECT r.LawyerReviewID, r.UserDocument_ID, d.Title AS DocumentTitle, t.TitleEng AS TemplateName,
               r.Lawyer_ID, lu.Name AS LawyerName, l.Specialization AS LawyerSpecialization,
               l.BarCouncilProvince, r.Notes, r.AnnotatedPdfPath, r.ReviewFee,
               ISNULL(s.LawyerReviewStatuse, 'Requested') AS StatusName,
               ISNULL(r.LawyerReviewStatus_ID, 1) AS StatusId,
               r.RequesteDateTime, r.AssignedDateTime, r.CompletedDateTime
        FROM dbo.LawyerReviews r
        INNER JOIN dbo.UserDocuments d ON r.UserDocument_ID = d.UserDocumentID
        LEFT JOIN dbo.Templates t ON d.Template_ID = t.TemplateID
        LEFT JOIN dbo.Lawyers l ON r.Lawyer_ID = l.LawyerID
        LEFT JOIN dbo.Users lu ON l.User_ID = lu.UserID
        LEFT JOIN dbo.LawyerReviewStatuses s ON r.LawyerReviewStatus_ID = s.LawyerReviewStatuseID
        {filter}";

    private static LawyerDto MapLawyerFromReader(SqlDataReader reader) => new(
        LawyerId: reader.GetInt32(reader.GetOrdinal("LawyerID")),
        UserId: reader.GetInt32(reader.GetOrdinal("User_ID")),
        FullName: reader.GetString(reader.GetOrdinal("FullName")),
        Email: reader.GetString(reader.GetOrdinal("Email")),
        PhoneNumber: reader.GetString(reader.GetOrdinal("PhoneNumber")),
        BarCouncilNumber: reader.GetString(reader.GetOrdinal("BarCouncilNumber")),
        BarCouncilProvince: reader.GetString(reader.GetOrdinal("BarCouncilProvince")),
        Specialization: reader.GetString(reader.GetOrdinal("Specialization")),
        YearsOfExperience: reader.GetInt32(reader.GetOrdinal("YearsOfExperience")),
        OfficeAddress: reader.IsDBNull(reader.GetOrdinal("OfficeAddress")) ? null : reader.GetString(reader.GetOrdinal("OfficeAddress")),
        VerifiedStatus: reader.GetBoolean(reader.GetOrdinal("VerifiedStatus")),
        Rating: reader.GetDecimal(reader.GetOrdinal("Rating")),
        TotalReviewsCompleted: reader.GetInt32(reader.GetOrdinal("TotalReviewsCompleted")),
        CreatedDateTime: reader.GetDateTime(reader.GetOrdinal("CreatedDateTime")));

    private static LawyerReviewDto MapReviewFromReader(SqlDataReader reader) => new(
        LawyerReviewId: reader.GetInt64(reader.GetOrdinal("LawyerReviewID")),
        UserDocumentId: reader.GetInt32(reader.GetOrdinal("UserDocument_ID")),
        DocumentTitle: reader.GetString(reader.GetOrdinal("DocumentTitle")),
        TemplateName: reader.IsDBNull(reader.GetOrdinal("TemplateName")) ? null : reader.GetString(reader.GetOrdinal("TemplateName")),
        LawyerId: reader.IsDBNull(reader.GetOrdinal("Lawyer_ID")) ? null : reader.GetInt32(reader.GetOrdinal("Lawyer_ID")),
        LawyerName: reader.IsDBNull(reader.GetOrdinal("LawyerName")) ? null : reader.GetString(reader.GetOrdinal("LawyerName")),
        LawyerSpecialization: reader.IsDBNull(reader.GetOrdinal("LawyerSpecialization")) ? null : reader.GetString(reader.GetOrdinal("LawyerSpecialization")),
        BarCouncilProvince: reader.IsDBNull(reader.GetOrdinal("BarCouncilProvince")) ? null : reader.GetString(reader.GetOrdinal("BarCouncilProvince")),
        Notes: reader.IsDBNull(reader.GetOrdinal("Notes")) ? null : reader.GetString(reader.GetOrdinal("Notes")),
        AnnotatedPdfPath: reader.IsDBNull(reader.GetOrdinal("AnnotatedPdfPath")) ? null : reader.GetString(reader.GetOrdinal("AnnotatedPdfPath")),
        ReviewFee: reader.GetDecimal(reader.GetOrdinal("ReviewFee")),
        Status: reader.GetString(reader.GetOrdinal("StatusName")),
        StatusId: reader.GetInt32(reader.GetOrdinal("StatusId")),
        RequestedDateTime: reader.GetDateTime(reader.GetOrdinal("RequesteDateTime")),
        AssignedDateTime: reader.IsDBNull(reader.GetOrdinal("AssignedDateTime")) ? null : reader.GetDateTime(reader.GetOrdinal("AssignedDateTime")),
        CompletedDateTime: reader.IsDBNull(reader.GetOrdinal("CompletedDateTime")) ? null : reader.GetDateTime(reader.GetOrdinal("CompletedDateTime")));
}
