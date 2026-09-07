import '../../../core/errors/result.dart';
import '../entities/document_signature.dart';
import '../entities/signer_identity.dart';
import '../repositories/signature_repository.dart';

class SignDocumentUseCase {
  const SignDocumentUseCase(this._repository);

  final SignatureRepository _repository;

  Future<Result<DocumentSignature>> call({
    required int documentId,
    required SignerIdentity signer,
    required String imageBase64,
    required String otp,
  }) => _repository.sign(
    documentId: documentId,
    signer: signer,
    imageBase64: imageBase64,
    otp: otp,
  );
}
