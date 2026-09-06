using LegalSaathi.Api.Domain.Entities;

namespace LegalSaathi.Api.Application.Common.Interfaces;

public interface ISignatureRepository
{
    Task<long> CreateSignatureAsync(Signature signature, CancellationToken cancellationToken = default);
    Task<IReadOnlyList<Signature>> GetByDocumentIdAsync(int userDocumentId, CancellationToken cancellationToken = default);
}
