using LegalSaathi.Api.Contracts.Documents;
using LegalSaathi.Api.Domain.Entities;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface IUserDocumentRepository
{
    Task<(int DocumentId, Guid DocumentGuid)> CreateAsync(int userId, int templateId, string title, string formAnswersJson, CancellationToken ct = default);
    Task<DocumentDetailDto?> GetByIdAsync(int documentId, int? userId = null, CancellationToken ct = default);
    Task<List<DocumentSummaryDto>> GetByUserAsync(int userId, CancellationToken ct = default);
    Task<bool> UpdateAnswersAsync(int documentId, int userId, string formAnswersJson, CancellationToken ct = default);
    Task<bool> UpdateStatusAsync(int documentId, int statusId, string? storagePath = null, string? docxStoragePath = null, string? documentHash = null, CancellationToken ct = default);
}
