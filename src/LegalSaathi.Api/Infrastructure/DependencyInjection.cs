using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Infrastructure.Data;
using LegalSaathi.Api.Infrastructure.Data.Repositories;
using LegalSaathi.Api.Infrastructure.Services;
using LegalSaathi.Api.Infrastructure.Services.Stubs;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace LegalSaathi.Api.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
    {
        // 1. Data Access (ADO.NET)
        services.AddSingleton<IDbConnectionFactory, SqlConnectionFactory>();
        services.AddScoped<ISqlProcedureExecutor, SqlProcedureExecutor>();
        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<ITemplateRepository, TemplateRepository>();
        services.AddScoped<IUserDocumentRepository, UserDocumentRepository>();
        services.AddScoped<ISignatureRepository, SignatureRepository>();
        services.AddScoped<IAIQueryRepository, AIQueryRepository>();

        // 2. Authentication & Identity
        services.AddSingleton<IPasswordHasher, Pbkdf2PasswordHasher>();
        services.AddScoped<IJwtTokenGenerator, JwtTokenGenerator>();
        services.AddScoped<IOtpService, MemoryOtpService>();
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<IAuditLogService, AuditLogService>();
        services.AddScoped<ITemplateService, TemplateService>();

        // 3. User Context
        services.AddHttpContextAccessor();
        services.AddScoped<ICurrentUserService, CurrentUserService>();

        // 4. AI Service (Free LLMs: Gemini / Groq / Pakistani Knowledge Engine)
        services.AddHttpClient<IAiLegalAssistantService, AIAssistantService>();
        services.AddScoped<IAiLegalAssistantService, AIAssistantService>();

        // 5. Payment Gateways (Stubs for zero-dependency operation)
        services.AddScoped<IPaymentGateway, JazzCashPaymentGateway>();
        services.AddScoped<IPaymentGateway, EasyPaisaPaymentGateway>();
        services.AddScoped<IPaymentGateway, PayFastPaymentGateway>();
        services.AddScoped<IPaymentGatewayFactory, PaymentGatewayFactory>();

        // 6. Document Engines & Storage Vault
        services.AddSingleton<IFileStorageService, LocalFileStorageService>();
        services.AddSingleton<IPdfGenerator, QuestPdfGenerator>();
        services.AddSingleton<IDocxGenerator, OpenXmlDocxGenerator>();
        services.AddScoped<IDocumentGenerationService, DocumentGenerationService>();

        // 7. Security, Signature & Notifications
        services.Configure<EmailSettings>(configuration.GetSection(EmailSettings.SectionName));
        services.AddScoped<ISignatureService, SignatureService>();
        services.AddScoped<IEmailService, SmtpEmailService>();
        services.AddScoped<ISmsService, StubSmsService>();

        return services;
    }
}
