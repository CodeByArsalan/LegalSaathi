using System.Data;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Contracts.Templates;
using LegalSaathi.Api.Domain.Entities;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Data.Repositories;

public class TemplateRepository : ITemplateRepository
{
    private readonly IDbConnectionFactory _connectionFactory;
    private readonly ILogger<TemplateRepository> _logger;

    public TemplateRepository(IDbConnectionFactory connectionFactory, ILogger<TemplateRepository> logger)
    {
        _connectionFactory = connectionFactory;
        _logger = logger;
    }

    public async Task<List<CategoryDto>> GetAllCategoriesAsync(CancellationToken ct = default)
    {
        var list = new List<CategoryDto>();
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpCategoryGetAll;
        command.CommandType = CommandType.StoredProcedure;

        await using var reader = await command.ExecuteReaderAsync(ct);
        while (await reader.ReadAsync(ct))
        {
            list.Add(new CategoryDto(
                CategoryId: reader.GetInt32(reader.GetOrdinal("CategoryID")),
                NameEn: reader.GetString(reader.GetOrdinal("NameEn")),
                NameUr: reader.GetString(reader.GetOrdinal("NameUr")),
                DescriptionEn: reader.IsDBNull(reader.GetOrdinal("DescriptionEn")) ? null : reader.GetString(reader.GetOrdinal("DescriptionEn")),
                DescriptionUr: reader.IsDBNull(reader.GetOrdinal("DescriptionUr")) ? null : reader.GetString(reader.GetOrdinal("DescriptionUr")),
                Icon: reader.IsDBNull(reader.GetOrdinal("Icon")) ? null : reader.GetString(reader.GetOrdinal("Icon")),
                TemplateCount: reader.GetInt32(reader.GetOrdinal("TemplateCount"))
            ));
        }

        return list;
    }

    public async Task<List<TemplateSummaryDto>> GetAllTemplatesAsync(string? searchTerm = null, CancellationToken ct = default)
    {
        var list = new List<TemplateSummaryDto>();
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpTemplateGetAll;
        command.CommandType = CommandType.StoredProcedure;

        command.Parameters.Add(new SqlParameter("@SearchTerm", SqlDbType.NVarChar, 100)
        {
            Value = (object?)searchTerm ?? DBNull.Value
        });

        await using var reader = await command.ExecuteReaderAsync(ct);
        while (await reader.ReadAsync(ct))
        {
            list.Add(MapTemplateSummary(reader));
        }

        return list;
    }

    public async Task<List<TemplateSummaryDto>> GetTemplatesByCategoryAsync(int categoryId, CancellationToken ct = default)
    {
        var list = new List<TemplateSummaryDto>();
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpTemplateGetByCategory;
        command.CommandType = CommandType.StoredProcedure;

        command.Parameters.Add(new SqlParameter("@CategoryID", SqlDbType.Int) { Value = categoryId });

        await using var reader = await command.ExecuteReaderAsync(ct);
        while (await reader.ReadAsync(ct))
        {
            list.Add(MapTemplateSummary(reader));
        }

        return list;
    }

    public async Task<Template?> GetTemplateByIdAsync(int templateId, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpTemplateGetById;
        command.CommandType = CommandType.StoredProcedure;

        command.Parameters.Add(new SqlParameter("@TemplateID", SqlDbType.Int) { Value = templateId });

        await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
        if (await reader.ReadAsync(ct))
        {
            return MapTemplate(reader);
        }

        return null;
    }

    public async Task<Template?> GetTemplateBySlugAsync(string slug, CancellationToken ct = default)
    {
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpTemplateGetBySlug;
        command.CommandType = CommandType.StoredProcedure;

        command.Parameters.Add(new SqlParameter("@Slug", SqlDbType.NVarChar, 150) { Value = slug });

        await using var reader = await command.ExecuteReaderAsync(CommandBehavior.SingleRow, ct);
        if (await reader.ReadAsync(ct))
        {
            return MapTemplate(reader);
        }

        return null;
    }

    public async Task<List<FormFieldDto>> GetFormFieldsByTemplateIdAsync(int templateId, CancellationToken ct = default)
    {
        var list = new List<FormFieldDto>();
        await using var connection = await _connectionFactory.CreateOpenConnectionAsync(ct);
        await using var command = connection.CreateCommand();
        command.CommandText = DbConstants.Procedures.SpFormFieldGetByTemplate;
        command.CommandType = CommandType.StoredProcedure;

        command.Parameters.Add(new SqlParameter("@TemplateID", SqlDbType.Int) { Value = templateId });

        await using var reader = await command.ExecuteReaderAsync(ct);
        while (await reader.ReadAsync(ct))
        {
            list.Add(new FormFieldDto(
                FieldId: reader.GetInt32(reader.GetOrdinal("FieldId")),
                TemplateId: reader.GetInt32(reader.GetOrdinal("TemplateId")),
                FieldKey: reader.GetString(reader.GetOrdinal("FieldKey")),
                FieldType: reader.GetString(reader.GetOrdinal("FieldType")),
                LabelEn: reader.GetString(reader.GetOrdinal("LabelEn")),
                LabelUr: reader.GetString(reader.GetOrdinal("LabelUr")),
                PlaceholderEn: reader.IsDBNull(reader.GetOrdinal("PlaceholderEn")) ? null : reader.GetString(reader.GetOrdinal("PlaceholderEn")),
                PlaceholderUr: reader.IsDBNull(reader.GetOrdinal("PlaceholderUr")) ? null : reader.GetString(reader.GetOrdinal("PlaceholderUr")),
                HelpTextEn: reader.IsDBNull(reader.GetOrdinal("HelpTextEn")) ? null : reader.GetString(reader.GetOrdinal("HelpTextEn")),
                HelpTextUr: reader.IsDBNull(reader.GetOrdinal("HelpTextUr")) ? null : reader.GetString(reader.GetOrdinal("HelpTextUr")),
                IsRequired: reader.GetBoolean(reader.GetOrdinal("IsRequired")),
                ValidationRegex: reader.IsDBNull(reader.GetOrdinal("ValidationRegex")) ? null : reader.GetString(reader.GetOrdinal("ValidationRegex")),
                OptionsJson: reader.IsDBNull(reader.GetOrdinal("OptionsJson")) ? null : reader.GetString(reader.GetOrdinal("OptionsJson")),
                ConditionalLogicJson: reader.IsDBNull(reader.GetOrdinal("ConditionalLogicJson")) ? null : reader.GetString(reader.GetOrdinal("ConditionalLogicJson")),
                StepNumber: reader.GetInt32(reader.GetOrdinal("StepNumber")),
                SortOrder: reader.GetInt32(reader.GetOrdinal("SortOrder"))
            ));
        }

        return list;
    }

    private static TemplateSummaryDto MapTemplateSummary(SqlDataReader reader)
    {
        return new TemplateSummaryDto(
            TemplateId: reader.GetInt32(reader.GetOrdinal("TemplateID")),
            CategoryId: reader.GetInt32(reader.GetOrdinal("CategoryID")),
            CategoryNameEn: reader.GetString(reader.GetOrdinal("CategoryNameEn")),
            CategoryNameUr: reader.GetString(reader.GetOrdinal("CategoryNameUr")),
            Slug: reader.GetString(reader.GetOrdinal("Slug")),
            TitleEn: reader.GetString(reader.GetOrdinal("TitleEn")),
            TitleUr: reader.GetString(reader.GetOrdinal("TitleUr")),
            DescriptionEn: reader.IsDBNull(reader.GetOrdinal("DescriptionEn")) ? null : reader.GetString(reader.GetOrdinal("DescriptionEn")),
            DescriptionUr: reader.IsDBNull(reader.GetOrdinal("DescriptionUr")) ? null : reader.GetString(reader.GetOrdinal("DescriptionUr")),
            BasePrice: reader.GetDecimal(reader.GetOrdinal("BasePrice")),
            Tier: reader.GetString(reader.GetOrdinal("Tier")),
            RequiresStampPaper: reader.GetBoolean(reader.GetOrdinal("RequiresStampPaper")),
            EstimatedStampDuty: reader.GetDecimal(reader.GetOrdinal("EstimatedStampDuty"))
        );
    }

    private static Template MapTemplate(SqlDataReader reader)
    {
        return new Template
        {
            TemplateID = reader.GetInt32(reader.GetOrdinal("TemplateID")),
            Category_ID = reader.GetInt32(reader.GetOrdinal("CategoryID")),
            Slug = reader.GetString(reader.GetOrdinal("Slug")),
            TitleEng = reader.GetString(reader.GetOrdinal("TitleEn")),
            TitleUrdu = reader.GetString(reader.GetOrdinal("TitleUr")),
            DescriptionEng = reader.IsDBNull(reader.GetOrdinal("DescriptionEn")) ? null : reader.GetString(reader.GetOrdinal("DescriptionEn")),
            DescriptionUrdu = reader.IsDBNull(reader.GetOrdinal("DescriptionUr")) ? null : reader.GetString(reader.GetOrdinal("DescriptionUr")),
            BasePrice = reader.GetDecimal(reader.GetOrdinal("BasePrice")),
            Tier = reader.GetString(reader.GetOrdinal("Tier")),
            ContentTemplateEng = reader.GetString(reader.GetOrdinal("ContentTemplateEn")),
            ContentTemplateUrdu = reader.GetString(reader.GetOrdinal("ContentTemplateUr")),
            ApplicableLaws = reader.IsDBNull(reader.GetOrdinal("ApplicableLaws")) ? null : reader.GetString(reader.GetOrdinal("ApplicableLaws")),
            RequiresStampPaper = reader.GetBoolean(reader.GetOrdinal("RequiresStampPaper")),
            EstimatedStampDuty = reader.GetDecimal(reader.GetOrdinal("EstimatedStampDuty"))
        };
    }
}
