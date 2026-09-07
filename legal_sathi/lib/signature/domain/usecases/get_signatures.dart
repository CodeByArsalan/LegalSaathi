import '../../../core/errors/result.dart';
import '../entities/document_signature.dart';
import '../repositories/signature_repository.dart';

class GetSignaturesUseCase {
  const GetSignaturesUseCase(this._repository);

  final SignatureRepository _repository;

  Future<Result<List<DocumentSignature>>> call(int documentId) =>
      _repository.getSignatures(documentId);
}
