namespace LegalSaathi.Api.Infrastructure.Services;

public class EmailSettings
{
    public const string SectionName = "EmailSettings";

    public string Provider { get; set; } = "Smtp"; // "Smtp", "SendGrid", "Console"
    public string? Host { get; set; }
    public int Port { get; set; } = 587;
    public bool EnableSsl { get; set; } = true;
    public string? Username { get; set; }
    public string? Password { get; set; }
    public string? SenderEmail { get; set; }
    public string SenderName { get; set; } = "Legal Saathi | لیگل ساتھی";
    public SmtpConfig Smtp { get; set; } = new();
    public SendGridConfig SendGrid { get; set; } = new();

    public string GetEffectiveHost() =>
        !string.IsNullOrWhiteSpace(Host) ? Host.Trim() : (!string.IsNullOrWhiteSpace(Smtp.Host) ? Smtp.Host.Trim() : "smtp.gmail.com");

    public int GetEffectivePort() =>
        Port > 0 ? Port : (Smtp.Port > 0 ? Smtp.Port : 587);

    public bool GetEffectiveEnableSsl() =>
        EnableSsl || Smtp.EnableSsl;

    public string GetEffectiveUsername() =>
        !string.IsNullOrWhiteSpace(Username) ? Username.Trim() : (!string.IsNullOrWhiteSpace(Smtp.Username) ? Smtp.Username.Trim() : "");

    public string GetEffectivePassword()
    {
        var raw = !string.IsNullOrWhiteSpace(Password) ? Password : Smtp.Password;
        if (string.IsNullOrWhiteSpace(raw)) return "";
        // Clean Google 16-character app password spaces if present
        return raw.Replace(" ", "").Trim();
    }

    public string GetEffectiveSenderEmail()
    {
        if (!string.IsNullOrWhiteSpace(SenderEmail) && !SenderEmail.Contains("no-reply@legalsaathi.pk", StringComparison.OrdinalIgnoreCase))
            return SenderEmail.Trim();

        var username = GetEffectiveUsername();
        if (!string.IsNullOrWhiteSpace(username) && username.Contains('@'))
            return username;

        return "no-reply@legalsaathi.pk";
    }
}

public class SmtpConfig
{
    public string Host { get; set; } = "smtp.gmail.com";
    public int Port { get; set; } = 587;
    public bool EnableSsl { get; set; } = true;
    public string Username { get; set; } = "";
    public string Password { get; set; } = "";
}

public class SendGridConfig
{
    public string ApiKey { get; set; } = "SG.placeholder_sendgrid_api_key";
}
