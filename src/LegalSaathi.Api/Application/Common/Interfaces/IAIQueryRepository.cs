using LegalSaathi.Api.Domain.Entities;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface IAIQueryRepository
{
    Task<long> CreateQueryAsync(AiQuery query, CancellationToken cancellationToken = default);
    Task<IReadOnlyList<AiQuery>> GetByDocumentIdAsync(int userDocumentId, CancellationToken cancellationToken = default);
}
