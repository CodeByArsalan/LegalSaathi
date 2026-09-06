using LegalSaathi.Api.Application.Common.Interfaces;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services.Stubs;

public class StubEmailService : IEmailService
{
    private readonly ILogger<StubEmailService> _logger;

    public StubEmailService(ILogger<StubEmailService> logger)
    {
        _logger = logger;
    }

    public async Task<bool> SendEmailAsync(string toEmail, string subject, string bodyHtml, CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("[Email Stub] Sending email to {ToEmail}, Subject: {Subject}", toEmail, subject);
        await Task.CompletedTask;
        return true;
    }
}

public class StubSmsService : ISmsService
{
    private readonly ILogger<StubSmsService> _logger;

    public StubSmsService(ILogger<StubSmsService> logger)
    {
        _logger = logger;
    }

    public async Task<bool> SendSmsAsync(string phoneNumber, string message, CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("[SMS Stub] Sending SMS to {PhoneNumber}: {Message}", phoneNumber, message);
        await Task.CompletedTask;
        return true;
    }
}

