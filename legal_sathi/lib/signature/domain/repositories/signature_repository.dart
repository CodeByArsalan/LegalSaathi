import '../../../core/errors/result.dart';
import '../entities/document_signature.dart';
import '../entities/signer_identity.dart';
import '../entities/signing_otp.dart';

abstract class SignatureRepository {
  /// Sends the signing code to [signer]'s contact.
  Future<Result<SigningOtp>> requestOtp({
    required int documentId,
    required SignerIdentity signer,
  });

  /// Files the signature and moves the document to `Signed`.
  Future<Result<DocumentSignature>> sign({
    required int documentId,
    required SignerIdentity signer,
    required String imageBase64,
    required String otp,
  });

  /// Every signature recorded against the document, newest last.
  Future<Result<List<DocumentSignature>>> getSignatures(int documentId);
}
