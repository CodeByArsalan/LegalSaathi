using LegalSaathi.Api.Domain.Enums;

namespace LegalSaathi.Api.Domain.Entities;

public class FormField
{
    public int FormFieldID { get; set; }
    public int FieldId { get => FormFieldID; set => FormFieldID = value; }
    public int Template_ID { get; set; }
    public int TemplateId { get => Template_ID; set => Template_ID = value; }
    public string FieldKey { get; set; } = string.Empty;
    public string FieldType { get; set; } = "Text";
    public string LabelEng { get; set; } = string.Empty;
    public string LabelUrdu { get; set; } = string.Empty;
    public string LabelEn { get => LabelEng; set => LabelEng = value; }
    public string LabelUr { get => LabelUrdu; set => LabelUrdu = value; }
    public string? PlaceholderEng { get; set; }
    public string? PlaceholderUrdu { get; set; }
    public string? PlaceholderEn { get => PlaceholderEng; set => PlaceholderEng = value; }
    public string? PlaceholderUr { get => PlaceholderUrdu; set => PlaceholderUrdu = value; }
    public string? HelpTextEng { get; set; }
    public string? HelpTextUrdu { get; set; }
    public string? HelpTextEn { get => HelpTextEng; set => HelpTextEng = value; }
    public string? HelpTextUr { get => HelpTextUrdu; set => HelpTextUrdu = value; }
    public bool IsRequired { get; set; } = true;
    public string? ValidationRegex { get; set; }
    public string? OptionsJson { get; set; }
    public string? ConditionalLogicJson { get; set; }
    public int StepNumber { get; set; } = 1;
    public int SortOrder { get; set; }
    public DateTime CreatedDateTime { get; set; } = DateTime.UtcNow;
}
