using System.Security.Cryptography;
using System.Text.Json;
using System.Text.RegularExpressions;
using LegalSaathi.Api.Application.Common.Interfaces;
using LegalSaathi.Api.Application.Common.Models;
using LegalSaathi.Api.Contracts.Documents;
using Microsoft.Extensions.Logging;

namespace LegalSaathi.Api.Infrastructure.Services;

public class DocumentGenerationService : IDocumentGenerationService
{
    private readonly IUserDocumentRepository _userDocumentRepository;
    private readonly ITemplateRepository _templateRepository;
    private readonly IPdfGenerator _pdfGenerator;
    private readonly IDocxGenerator _docxGenerator;
    private readonly IFileStorageService _fileStorageService;
    private readonly IAuditLogService _auditLogService;
    private readonly ILogger<DocumentGenerationService> _logger;

    public DocumentGenerationService(
        IUserDocumentRepository userDocumentRepository,
        ITemplateRepository templateRepository,
        IPdfGenerator pdfGenerator,
        IDocxGenerator docxGenerator,
        IFileStorageService fileStorageService,
        IAuditLogService auditLogService,
        ILogger<DocumentGenerationService> logger)
    {
        _userDocumentRepository = userDocumentRepository;
        _templateRepository = templateRepository;
        _pdfGenerator = pdfGenerator;
        _docxGenerator = docxGenerator;
        _fileStorageService = fileStorageService;
        _auditLogService = auditLogService;
        _logger = logger;
    }

    public async Task<Result<GenerateDocumentResponse>> GenerateAndSaveDocumentAsync(
        int documentId,
        int userId,
        string language = "bilingual",
        string? ipAddress = null,
        string? userAgent = null,
        CancellationToken ct = default)
    {
        var doc = await _userDocumentRepository.GetByIdAsync(documentId, userId, ct);
        if (doc == null)
        {
            return Result<GenerateDocumentResponse>.Failure("Document not found or access denied.");
        }

        var template = await _templateRepository.GetTemplateByIdAsync(doc.TemplateId, ct);
        if (template == null)
        {
            return Result<GenerateDocumentResponse>.Failure("Template not found.");
        }

        Dictionary<string, string> answers = new();
        try
        {
            if (!string.IsNullOrWhiteSpace(doc.FormAnswersJson))
            {
                answers = JsonSerializer.Deserialize<Dictionary<string, string>>(doc.FormAnswersJson) ?? new();
            }
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Failed to parse FormAnswersJson for document {DocumentId}", documentId);
        }

        // Interpolate content
        var contentEn = Interpolate(template.ContentTemplateEng, answers);
        var contentUr = Interpolate(template.ContentTemplateUrdu, answers);

        answers.TryGetValue("DeponentName", out var deponentName);
        if (string.IsNullOrEmpty(deponentName)) answers.TryGetValue("SellerName", out deponentName);
        if (string.IsNullOrEmpty(deponentName)) answers.TryGetValue("LandlordName", out deponentName);

        answers.TryGetValue("Cnic", out var cnic);

        // 1. Generate PDF with QuestPDF
        var pdfBytes = await _pdfGenerator.GeneratePdfAsync(
            titleEn: template.TitleEng,
            titleUr: template.TitleUrdu,
            contentEn: contentEn,
            contentUr: contentUr,
            documentGuid: doc.DocumentGuid,
            requiresStampPaper: template.RequiresStampPaper,
            estimatedStampDuty: template.EstimatedStampDuty,
            deponentName: deponentName,
            cnic: cnic,
            cancellationToken: ct
        );

        // 2. Generate DOCX with OpenXml
        var docxBytes = await _docxGenerator.GenerateDocxAsync(
            titleEn: template.TitleEng,
            titleUr: template.TitleUrdu,
            contentEn: contentEn,
            contentUr: contentUr,
            documentGuid: doc.DocumentGuid,
            deponentName: deponentName,
            cnic: cnic,
            cancellationToken: ct
        );

        // 3. Compute SHA-256 Checksum over PDF bytes
        var sha256Bytes = SHA256.HashData(pdfBytes);
        var documentHash = Convert.ToHexString(sha256Bytes).ToLowerInvariant();

        // 4. Save to Vault File Storage
        var pdfRelPath = $"documents/{doc.DocumentGuid}/{doc.DocumentGuid}.pdf";
        var docxRelPath = $"documents/{doc.DocumentGuid}/{doc.DocumentGuid}.docx";

        await _fileStorageService.SaveFileAsync(pdfBytes, pdfRelPath, "application/pdf", ct);
        await _fileStorageService.SaveFileAsync(docxBytes, docxRelPath, "application/vnd.openxmlformats-officedocument.wordprocessingml.document", ct);

        // 5. Update Status to Completed (ID: 2) in Database
        await _userDocumentRepository.UpdateStatusAsync(
            documentId: documentId,
            statusId: 2, // 2: Completed
            storagePath: pdfRelPath,
            docxStoragePath: docxRelPath,
            documentHash: documentHash,
            ct: ct
        );

        // 6. Audit Log
        await _auditLogService.LogAsync(
            userId: userId,
            action: "DOCUMENT_GENERATED",
            entityName: "UserDocuments",
            entityId: documentId.ToString(),
            ipAddress: ipAddress,
            userAgent: userAgent,
            newValuesJson: JsonSerializer.Serialize(new { DocumentGuid = doc.DocumentGuid, DocumentHash = documentHash, Status = "Completed" }),
            ct: ct
        );

        return Result<GenerateDocumentResponse>.Success(new GenerateDocumentResponse(
            UserDocumentId: documentId,
            DocumentGuid: doc.DocumentGuid,
            Status: "Completed",
            StoragePath: pdfRelPath,
            DocxStoragePath: docxRelPath,
            DocumentHash: documentHash,
            PdfDownloadUrl: $"/api/documents/{documentId}/download/pdf",
            DocxDownloadUrl: $"/api/documents/{documentId}/download/docx"
        ));
    }

    private static string Interpolate(string template, Dictionary<string, string> answers)
    {
        if (string.IsNullOrWhiteSpace(template)) return string.Empty;
        return Regex.Replace(template, @"{{([a-zA-Z0-9_]+)}}", match =>
        {
            var key = match.Groups[1].Value;
            if (answers.TryGetValue(key, out var val) && !string.IsNullOrWhiteSpace(val))
            {
                return val;
            }
            return $"[{key}]";
        });
    }
}
