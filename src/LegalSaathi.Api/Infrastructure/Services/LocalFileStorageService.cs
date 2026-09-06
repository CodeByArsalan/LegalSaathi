using LegalSaathi.Api.Application.Common.Interfaces;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

public class LocalFileStorageService : IFileStorageService
{
    private readonly string _storageRoot;
    private readonly ILogger<LocalFileStorageService> _logger;

    public LocalFileStorageService(IWebHostEnvironment env, ILogger<LocalFileStorageService> logger)
    {
        _logger = logger;
        _storageRoot = Path.Combine(env.ContentRootPath, "storage", "vault");
        if (!Directory.Exists(_storageRoot))
        {
            Directory.CreateDirectory(_storageRoot);
        }
    }

    public async Task<string> SaveFileAsync(byte[] fileBytes, string relativePath, string contentType, CancellationToken cancellationToken = default)
    {
        var fullPath = Path.Combine(_storageRoot, relativePath);
        var dir = Path.GetDirectoryName(fullPath);
        if (!string.IsNullOrEmpty(dir) && !Directory.Exists(dir))
        {
            Directory.CreateDirectory(dir);
        }

        await File.WriteAllBytesAsync(fullPath, fileBytes, cancellationToken);
        _logger.LogInformation("Stored file at {Path} ({Size} bytes)", fullPath, fileBytes.Length);
        return relativePath.Replace('\\', '/');
    }

    public async Task<byte[]> GetFileAsync(string storagePath, CancellationToken cancellationToken = default)
    {
        var fullPath = Path.Combine(_storageRoot, storagePath.TrimStart('/', '\\'));
        if (!File.Exists(fullPath))
        {
            throw new FileNotFoundException($"File not found in vault: {storagePath}");
        }

        return await File.ReadAllBytesAsync(fullPath, cancellationToken);
    }

    public Task DeleteFileAsync(string storagePath, CancellationToken cancellationToken = default)
    {
        var fullPath = Path.Combine(_storageRoot, storagePath.TrimStart('/', '\\'));
        if (File.Exists(fullPath))
        {
            File.Delete(fullPath);
        }
        return Task.CompletedTask;
    }
}
