using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Domain.Entities;

public class Template
{
    public int TemplateID { get; set; }
    public int TemplateId { get => TemplateID; set => TemplateID = value; }
    public int Category_ID { get; set; }
    public int CategoryId { get => Category_ID; set => Category_ID = value; }
    public string Slug { get; set; } = string.Empty;
    public string TitleEng { get; set; } = string.Empty;
    public string TitleUrdu { get; set; } = string.Empty;
    public string TitleEn { get => TitleEng; set => TitleEng = value; }
    public string TitleUr { get => TitleUrdu; set => TitleUrdu = value; }
    public string? DescriptionEng { get; set; }
    public string? DescriptionUrdu { get; set; }
    public string DescriptionEn { get => DescriptionEng ?? string.Empty; set => DescriptionEng = value; }
    public string DescriptionUr { get => DescriptionUrdu ?? string.Empty; set => DescriptionUrdu = value; }
    public decimal BasePrice { get; set; }
    public string Tier { get; set; } = "Free";
    public string ContentTemplateEng { get; set; } = string.Empty;
    public string ContentTemplateUrdu { get; set; } = string.Empty;
    public string ContentTemplateEn { get => ContentTemplateEng; set => ContentTemplateEng = value; }
    public string ContentTemplateUr { get => ContentTemplateUrdu; set => ContentTemplateUrdu = value; }
    public string? ApplicableLaws { get; set; }
    public bool RequiresStampPaper { get; set; }
    public decimal EstimatedStampDuty { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTime CreatedDateTime { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedDateTime { get; set; }

    // Navigation
    public TemplateCategory? Category { get; set; }
    public List<FormField> FormFields { get; set; } = new();
}
