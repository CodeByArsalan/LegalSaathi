namespace LegalSaathi.Api.Domain.Entities;

public class AiQuery
{
    public long QueryID { get; set; }
    public int QueryId { get => (int)QueryID; set => QueryID = value; }
    public int? User_ID { get; set; }
    public int? UserId { get => User_ID; set => User_ID = value; }
    public int? Template_ID { get; set; }
    public int? TemplateId { get => Template_ID; set => Template_ID = value; }
    public int? UserDocument_ID { get; set; }
    public int? UserDocumentId { get => UserDocument_ID; set => UserDocument_ID = value; }
    public string Prompt { get; set; } = string.Empty;
    public string UserPrompt { get => Prompt; set => Prompt = value; }
    public string Response { get; set; } = string.Empty;
    public string AssistantResponse { get => Response; set => Response = value; }
    public string LanguageCode { get; set; } = "ur";
    public int PromptTokens { get; set; }
    public int CompletionTokens { get; set; }
    public int Tokens { get; set; }
    public int TotalTokens { get => Tokens; set => Tokens = value; }
    public string ModelUsed { get; set; } = "gpt-4o";
    public DateTime CreatedDateTime { get; set; } = DateTime.UtcNow;
    public DateTime CreatedAt { get => CreatedDateTime; set => CreatedDateTime = value; }
}
