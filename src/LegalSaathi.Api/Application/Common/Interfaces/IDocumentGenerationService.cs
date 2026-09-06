using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Contracts.Documents;

namespace LegalSaathi.Api.Application.Common.Interfaces;

/// <summary>
/// QuestPDF generator abstraction for court-ready PDFs with Nastaliq RTL support
/// </summary>
public interface IPdfGenerator
{
    Task<byte[]> GeneratePdfAsync(
        string titleEn,
        string titleUr,
        string contentEn,
        string contentUr,
        Guid documentGuid,
        bool requiresStampPaper,
        decimal estimatedStampDuty,
        string? deponentName = null,
        string? cnic = null,
        CancellationToken cancellationToken = default);
}

/// <summary>
/// OpenXML SDK generator abstraction for Microsoft Word DOCX generation
/// </summary>
public interface IDocxGenerator
{
    Task<byte[]> GenerateDocxAsync(
        string titleEn,
        string titleUr,
        string contentEn,
        string contentUr,
        Guid documentGuid,
        string? deponentName = null,
        string? cnic = null,
        CancellationToken cancellationToken = default);
}

/// <summary>
/// Orchestrator for compiling, hashing, and storing documents in the secure vault
/// </summary>
public interface IDocumentGenerationService
{
    Task<Result<GenerateDocumentResponse>> GenerateAndSaveDocumentAsync(
        int documentId,
        int userId,
        string language = "bilingual",
        string? ipAddress = null,
        string? userAgent = null,
        CancellationToken ct = default);
}

