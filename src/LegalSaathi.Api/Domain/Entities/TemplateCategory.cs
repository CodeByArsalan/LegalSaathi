namespace LegalSaathi.Api.Domain.Entities;

public class TemplateCategory
{
    public int TemplateCategoryID { get; set; }
    public int CategoryId { get => TemplateCategoryID; set => TemplateCategoryID = value; }
    public string NameEng { get; set; } = string.Empty;
    public string NameUrdu { get; set; } = string.Empty;
    public string? DescriptionEng { get; set; }
    public string? DescriptionUrdu { get; set; }
    public string? Icon { get; set; }
    public int SortOrder { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTime CreatedDateTime { get; set; } = DateTime.UtcNow;

    // Navigation
    public List<Template> Templates { get; set; } = new();
}
