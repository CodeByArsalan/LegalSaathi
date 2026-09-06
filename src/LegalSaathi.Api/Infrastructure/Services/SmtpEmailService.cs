using System.Net;
using System.Net.Mail;
using LegalSaathi.Api.Application.Common.Interfaces;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace LegalSaathi.Api.Infrastructure.Services;

public class SmtpEmailService : IEmailService
{
    private readonly EmailSettings _settings;
    private readonly ILogger<SmtpEmailService> _logger;

    public SmtpEmailService(IOptions<EmailSettings> settings, ILogger<SmtpEmailService> logger)
    {
        _settings = settings.Value;
        _logger = logger;
    }

    public async Task<bool> SendEmailAsync(string toEmail, string subject, string bodyHtml, CancellationToken cancellationToken = default)
    {
        var host = _settings.GetEffectiveHost();
        var port = _settings.GetEffectivePort();
        var enableSsl = _settings.GetEffectiveEnableSsl();
        var username = _settings.GetEffectiveUsername();
        var password = _settings.GetEffectivePassword();
        var senderEmail = _settings.GetEffectiveSenderEmail();
        var senderName = _settings.SenderName;

        var isPlaceholder = string.IsNullOrWhiteSpace(username) ||
                            username.Contains("your-email@gmail.com", StringComparison.OrdinalIgnoreCase) ||
                            string.IsNullOrWhiteSpace(password) ||
                            password.Contains("your-16-character-app-password", StringComparison.OrdinalIgnoreCase);

        if (isPlaceholder)
        {
            _logger.LogInformation("==================================================");
            _logger.LogInformation("[Email Service: Placeholder Mode]");
            _logger.LogInformation("To: {ToEmail}", toEmail);
            _logger.LogInformation("From: {SenderName} <{SenderEmail}>", senderName, senderEmail);
            _logger.LogInformation("Subject: {Subject}", subject);
            _logger.LogInformation("Notice: To dispatch real emails to inboxes, provide real SMTP credentials in appsettings.json -> EmailSettings.");
            _logger.LogInformation("==================================================");
            return true;
        }

        try
        {
            using var message = new MailMessage
            {
                From = new MailAddress(senderEmail, senderName),
                Subject = subject,
                Body = bodyHtml,
                IsBodyHtml = true
            };
            message.To.Add(new MailAddress(toEmail));

            using var client = new SmtpClient(host, port)
            {
                EnableSsl = enableSsl,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(username, password),
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Timeout = 15000
            };

            await client.SendMailAsync(message, cancellationToken);
            _logger.LogInformation("Successfully sent email to {ToEmail} via {Host}:{Port} from {From}", toEmail, host, port, senderEmail);
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send email to {ToEmail} via SMTP ({Host}:{Port}). Falling back gracefully.", toEmail, host, port);
            return false;
        }
    }
}
