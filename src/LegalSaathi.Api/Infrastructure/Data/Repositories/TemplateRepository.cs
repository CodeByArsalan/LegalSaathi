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
        try
        {
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
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Failed to load form fields from database for TemplateId {TemplateId}, falling back to built-in dictionary.", templateId);
        }

        if (list.Count == 0)
        {
            list = GetFallbackFormFields(templateId);
        }

        return list;
    }

    private static List<FormFieldDto> GetFallbackFormFields(int templateId)
    {
        return templateId switch
        {
            1 => new List<FormFieldDto>
            {
                new(1, 1, "DeponentName", "Text", "Deponent Full Name", "بیان دہندہ کا پورا نام", "e.g. Muhammad Ali", "مثال: محمد علی", "Enter legal name as per CNIC", "شناختی کارڈ کے مطابق نام درج کریں", true, null, null, null, 1, 1),
                new(2, 1, "FatherName", "Text", "Father / Husband Name", "والد / شوہر کا نام", "e.g. Ahmad Khan", "مثال: احمد خان", null, null, true, null, null, null, 1, 2),
                new(3, 1, "Cnic", "Cnic", "CNIC Number", "قومی شناختی کارڈ نمبر", "35201-1234567-1", "35201-1234567-1", "13-digit Pakistani CNIC", "13 ہندسوں کا شناختی کارڈ نمبر", true, @"^[0-9]{5}-[0-9]{7}-[0-9]$", null, null, 1, 3),
                new(4, 1, "Address", "Address", "Residential Address", "رہائشی پتہ", "House #, Street, City", "مکان نمبر، گلی، شہر", null, null, true, null, null, null, 1, 4),
                new(5, 1, "AffidavitStatement", "TextArea", "Sworn Statement / Facts", "بیان حلفی کی تفصیل / حقائق", "State the facts clearly...", "اپنے بیانات اور حقائق واضح طور پر تحریر کریں...", "Write clearly without assumptions", "صرف مصدقہ حقائق بیان کریں", true, null, null, null, 2, 1)
            },
            2 => new List<FormFieldDto>
            {
                new(6, 2, "AgreementDate", "Date", "Agreement Date", "معاہدے کی تاریخ", "YYYY-MM-DD", "YYYY-MM-DD", "Date of tenancy execution", "معاہدے کی تاریخ", true, null, null, null, 1, 1),
                new(7, 2, "LandlordName", "Text", "Landlord Full Name", "مالک مکان کا پورا نام", "e.g. Tariq Mehmood", "مثال: طارق محمود", "As per CNIC", "شناختی کارڈ کے مطابق نام", true, null, null, null, 1, 2),
                new(8, 2, "LandlordCnic", "Cnic", "Landlord CNIC", "مالک مکان کا شناختی کارڈ نمبر", "35201-1111111-1", "35201-1111111-1", "13-digit Pakistani CNIC", "13 ہندسوں کا شناختی کارڈ نمبر", true, @"^[0-9]{5}-[0-9]{7}-[0-9]$", null, null, 1, 3),
                new(9, 2, "TenantName", "Text", "Tenant Full Name", "کرایہ دار کا پورا نام", "e.g. Usman Ali", "مثال: عثمان علی", "As per CNIC", "شناختی کارڈ کے مطابق نام", true, null, null, null, 1, 4),
                new(10, 2, "TenantCnic", "Cnic", "Tenant CNIC", "کرایہ دار کا شناختی کارڈ نمبر", "35201-2222222-2", "35201-2222222-2", "13-digit Pakistani CNIC", "13 ہندسوں کا شناختی کارڈ نمبر", true, @"^[0-9]{5}-[0-9]{7}-[0-9]$", null, null, 1, 5),
                new(11, 2, "PropertyAddress", "Address", "Rental Property Address", "کرایہ کی جائیداد کا پتہ", "House #, Street, Phase, City", "مکان نمبر، گلی، فیز، شہر", "Complete physical address of premises", "جائیداد کا مکمل پتہ", true, null, null, null, 2, 1),
                new(12, 2, "MonthlyRent", "Text", "Monthly Rent (PKR)", "ماہانہ کرایہ (روپے)", "e.g. 45000", "مثال: 45000", "Agreed monthly rent in PKR", "طے شدہ ماہانہ کرایہ", true, null, null, null, 2, 2),
                new(13, 2, "SecurityDeposit", "Text", "Security Deposit (PKR)", "سیکیورٹی ڈپازٹ (روپے)", "e.g. 90000", "مثال: 90000", "Refundable security advance amount", "قابل واپسی ایڈوانس سیکیورٹی رقم", true, null, null, null, 2, 3),
                new(14, 2, "DurationMonths", "Text", "Tenancy Duration (Months)", "مدت کرایہ داری (ماہ)", "e.g. 11", "مثال: 11", "Tenancy period in months", "کرایہ داری کی مدت", true, null, null, null, 2, 4)
            },
            3 => new List<FormFieldDto>
            {
                new(15, 3, "SellerName", "Text", "Seller Full Name", "فروخت کنندہ کا پورا نام", "e.g. Kamran Ashraf", "مثال: کامران اشرف", "As per vehicle registration & CNIC", "شناختی کارڈ و رجسٹریشن کے مطابق نام", true, null, null, null, 1, 1),
                new(16, 3, "SellerCnic", "Cnic", "Seller CNIC", "فروخت کنندہ کا شناختی کارڈ نمبر", "35201-3333333-3", "35201-3333333-3", "13-digit Pakistani CNIC", "13 ہندسوں کا شناختی کارڈ نمبر", true, @"^[0-9]{5}-[0-9]{7}-[0-9]$", null, null, 1, 2),
                new(17, 3, "BuyerName", "Text", "Buyer Full Name", "خریدار کا پورا نام", "e.g. Bilal Ahmed", "مثال: بلال احمد", "Purchaser name as per CNIC", "خریدار کا شناختی کارڈ کے مطابق نام", true, null, null, null, 1, 3),
                new(18, 3, "BuyerCnic", "Cnic", "Buyer CNIC", "خریدار کا شناختی کارڈ نمبر", "35201-4444444-4", "35201-4444444-4", "13-digit Pakistani CNIC", "13 ہندسوں کا شناختی کارڈ نمبر", true, @"^[0-9]{5}-[0-9]{7}-[0-9]$", null, null, 1, 4),
                new(19, 3, "RegNumber", "Text", "Registration Number", "گاڑی کا رجسٹریشن نمبر", "e.g. LEB-21-4567", "مثال: LEB-21-4567", "Vehicle registration number", "گاڑی کا ایکسائز نمبر", true, null, null, null, 2, 1),
                new(20, 3, "MakeModel", "Text", "Make / Model / Year", "گاڑی کی قسم / ماڈل / سال", "e.g. Toyota Corolla 2021", "مثال: ٹویوٹا کرولا 2021", "Vehicle make, model and manufacturing year", "گاڑی کی کمپنی، ماڈل اور سال", true, null, null, null, 2, 2),
                new(21, 3, "EngineNumber", "Text", "Engine Number", "انجن نمبر", "e.g. 1NZ-5893214", "مثال: 1NZ-5893214", "As printed in vehicle registration book", "رجسٹریشن بک کے مطابق انجن نمبر", true, null, null, null, 2, 3),
                new(22, 3, "ChassisNumber", "Text", "Chassis / Frame Number", "چیسس نمبر", "e.g. NZE140-9012345", "مثال: NZE140-9012345", "Frame chassis number", "گاڑی کا چیسس نمبر", true, null, null, null, 2, 4),
                new(23, 3, "SaleAmount", "Text", "Total Sale Price (PKR)", "کل قیمت فروخت (روپے)", "e.g. 3500000", "مثال: 3500000", "Total agreed sale consideration", "طے شدہ کل رقم برائے فروخت", true, null, null, null, 2, 5)
            },
            4 => new List<FormFieldDto>
            {
                new(24, 4, "DisclosingParty", "Text", "Disclosing Party Name", "معلومات ظاہر کرنے والے فریق کا نام", "Company / Individual Name", "کمپنی یا فرد کا نام", "Party disclosing confidential information", "فریق اول کا قانونی نام", true, null, null, null, 1, 1),
                new(25, 4, "ReceivingParty", "Text", "Receiving Party Name", "معلومات وصول کرنے والے فریق کا نام", "Company / Individual Name", "کمپنی یا فرد کا نام", "Party receiving proprietary information", "فریق دوم کا قانونی نام", true, null, null, null, 1, 2),
                new(26, 4, "ProjectScope", "TextArea", "Confidential Purpose / Project Scope", "خفیہ معلومات کا دائرہ کار / منصوبہ", "Describe the project or confidential domain...", "منصوبے یا کاروباری راز کی وضاحت کریں...", "Scope of protected information", "خفیہ معلومات کا دائرہ کار", true, null, null, null, 2, 1),
                new(27, 4, "DurationYears", "Text", "Confidentiality Term (Years)", "رازداری کی مدت (سال)", "e.g. 3", "مثال: 3", "Non-disclosure duration in years", "معاہدے کی مدت سالوں میں", true, null, null, null, 2, 2)
            },
            5 => new List<FormFieldDto>
            {
                new(28, 5, "EmployerName", "Text", "Employer / Company Name", "مالک / ادارے کا نام", "e.g. Saathi Technologies Pvt Ltd", "مثال: ساتھی ٹیکنالوجیز پرائیویٹ لمیٹڈ", "Official registered employer entity", "ادارے کا رجسٹرڈ نام", true, null, null, null, 1, 1),
                new(29, 5, "EmployeeName", "Text", "Employee Full Name", "ملازم کا پورا نام", "e.g. Zaid Khan", "مثال: زید خان", "As per CNIC", "شناختی کارڈ کے مطابق ملازم کا نام", true, null, null, null, 1, 2),
                new(30, 5, "EmployeeCnic", "Cnic", "Employee CNIC", "ملازم کا شناختی کارڈ نمبر", "35201-5555555-5", "35201-5555555-5", "13-digit Pakistani CNIC", "13 ہندسوں کا شناختی کارڈ نمبر", true, @"^[0-9]{5}-[0-9]{7}-[0-9]$", null, null, 1, 3),
                new(31, 5, "JobTitle", "Text", "Job Designation / Title", "عہدہ / جاب ٹائٹل", "e.g. Senior Software Engineer", "مثال: سینئر سافٹ ویئر انجینئر", "Position title", "ملازمت کا عہدہ", true, null, null, null, 2, 1),
                new(32, 5, "MonthlySalary", "Text", "Monthly Salary (PKR)", "ماہانہ تنخواہ (روپے)", "e.g. 150000", "مثال: 150000", "Monthly remuneration", "ماہانہ مشاہرہ", true, null, null, null, 2, 2),
                new(33, 5, "JoiningDate", "Date", "Joining Date", "شمولیت کی تاریخ", "YYYY-MM-DD", "YYYY-MM-DD", "First day of employment", "ملازمت کے آغاز کی تاریخ", true, null, null, null, 2, 3)
            },
            6 => new List<FormFieldDto>
            {
                new(34, 6, "PartyA", "Text", "First Party / Entity", "فریق اول / ادارہ", "e.g. Alpha Solutions Pvt Ltd", "مثال: الفا سلوشنز پرائیویٹ لمیٹڈ", "First collaborating organization", "پہلا فریق", true, null, null, null, 1, 1),
                new(35, 6, "PartyB", "Text", "Second Party / Entity", "فریق دوم / ادارہ", "e.g. Beta Services Ltd", "مثال: بیٹا سروسز لمیٹڈ", "Second collaborating organization", "دوسرا فریق", true, null, null, null, 1, 2),
                new(36, 6, "CollaborationPurpose", "TextArea", "Collaboration Purpose", "باہمی تعاون کا مقصد", "Describe strategic cooperation areas...", "باہمی تعاون اور اشتراک کے مقاصد تحریر کریں...", "Strategic goals of agreement", "مشترکہ مقاصد", true, null, null, null, 2, 1)
            },
            7 => new List<FormFieldDto>
            {
                new(37, 7, "FirmName", "Text", "Partnership Firm Name", "شراکت داری فرم کا نام", "e.g. Prime Agro Enterprises", "مثال: پرائم ایگرو انٹرپرائزز", "Business trade name", "کاروباری فرم کا نام", true, null, null, null, 1, 1),
                new(38, 7, "DeedDate", "Date", "Deed Execution Date", "معاہدے کی تاریخ", "YYYY-MM-DD", "YYYY-MM-DD", "Date of partnership signing", "شراکت نامہ کی تاریخ", true, null, null, null, 1, 2),
                new(39, 7, "ProfitRatio", "Text", "Profit / Loss Ratio", "نفع و نقصان کا تناسب", "e.g. 50:50 or 60:40", "مثال: 50:50 یا 60:40", "Agreed distribution ratio", "نفع و نقصان کا تناسب", true, null, null, null, 2, 1)
            },
            _ => new List<FormFieldDto>()
        };
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
