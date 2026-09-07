import '../../../core/errors/result.dart';
import '../entities/signer_identity.dart';
import '../entities/signing_otp.dart';
import '../repositories/signature_repository.dart';

class RequestSigningOtpUseCase {
  const RequestSigningOtpUseCase(this._repository);

  final SignatureRepository _repository;

  Future<Result<SigningOtp>> call({
    required int documentId,
    required SignerIdentity signer,
  }) => _repository.requestOtp(documentId: documentId, signer: signer);
}
