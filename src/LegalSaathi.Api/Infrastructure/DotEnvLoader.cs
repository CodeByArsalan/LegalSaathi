using System;
using System.IO;
using Microsoft.Extensions.Configuration;

namespace LegalSaathi.Api.Infrastructure;

/// <summary>
/// Lightweight, zero-dependency .env loader that populates both system environment variables
/// and ASP.NET Core IConfigurationManager.
/// </summary>
public static class DotEnvLoader
{
    public static void Load(string? contentRootPath, ConfigurationManager configuration)
    {
        var possiblePaths = new[]
        {
            Path.Combine(contentRootPath ?? Directory.GetCurrentDirectory(), ".env"),
            Path.Combine(Directory.GetCurrentDirectory(), ".env"),
            Path.Combine(contentRootPath ?? Directory.GetCurrentDirectory(), "..", ".env"),
            Path.Combine(contentRootPath ?? Directory.GetCurrentDirectory(), "..", "..", ".env")
        };

        foreach (var path in possiblePaths)
        {
            if (File.Exists(path))
            {
                try
                {
                    var lines = File.ReadAllLines(path);
                    foreach (var line in lines)
                    {
                        var trimmed = line.Trim();
                        if (string.IsNullOrWhiteSpace(trimmed) || trimmed.StartsWith("#"))
                            continue;

                        var separatorIndex = trimmed.IndexOf('=');
                        if (separatorIndex <= 0)
                            continue;

                        var key = trimmed.Substring(0, separatorIndex).Trim();
                        var value = trimmed.Substring(separatorIndex + 1).Trim();

                        // Remove surrounding quotes if present
                        if ((value.StartsWith("\"") && value.EndsWith("\"")) ||
                            (value.StartsWith("'") && value.EndsWith("'")))
                        {
                            if (value.Length >= 2)
                                value = value.Substring(1, value.Length - 2);
                        }

                        if (string.IsNullOrEmpty(key))
                            continue;

                        // 1. Set environment variable in the process
                        Environment.SetEnvironmentVariable(key, value);

                        // 2. Set hierarchical key in configuration builder (e.g., Section__SubKey -> Section:SubKey)
                        var configKey = key.Replace("__", ":");
                        configuration[configKey] = value;

                        // 3. Map common friendly alias keys
                        switch (key.ToUpperInvariant())
                        {
                            case "DATABASE_URL":
                            case "DEFAULT_CONNECTION":
                            case "DB_CONNECTION_STRING":
                                configuration["ConnectionStrings:DefaultConnection"] = value;
                                break;
                            case "JWT_SECRET":
                            case "JWT_SECRET_KEY":
                                configuration["JwtSettings:SecretKey"] = value;
                                break;
                            case "GROQ_API_KEY":
                            case "AI_API_KEY":
                                configuration["AiSettings:ApiKey"] = value;
                                break;
                            case "EMAIL_USERNAME":
                            case "SMTP_USER":
                                configuration["EmailSettings:Username"] = value;
                                break;
                            case "EMAIL_PASSWORD":
                            case "SMTP_PASS":
                                configuration["EmailSettings:Password"] = value;
                                break;
                        }
                    }
                }
                catch
                {
                    // Fail gracefully if .env cannot be read
                }
                break;
            }
        }
    }
}
