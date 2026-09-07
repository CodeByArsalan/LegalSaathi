import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../domain/entities/document_signature.dart';
import '../../domain/entities/signer_identity.dart';
import '../../domain/entities/signing_otp.dart';
import '../../domain/repositories/signature_repository.dart';
import '../datasources/signature_remote_data_source.dart';
import '../models/signature_detail_dto.dart';
import '../models/signing_otp_dto.dart';

class SignatureRepositoryImpl implements SignatureRepository {
  SignatureRepositoryImpl(this._remote);

  final SignatureRemoteDataSource _remote;

  @override
  Future<Result<SigningOtp>> requestOtp({
    required int documentId,
    required SignerIdentity signer,
  }) async {
    try {
      return Success<SigningOtp>(
        (await _remote.requestOtp(
          documentId: documentId,
          signerName: signer.name,
          signerCnic: signer.cnic,
          destination: signer.destination,
        )).toEntity(),
      );
    } on Object catch (error) {
      return FailureResult<SigningOtp>(Failure.from(error));
    }
  }

  @override
  Future<Result<DocumentSignature>> sign({
    required int documentId,
    required SignerIdentity signer,
    required String imageBase64,
    required String otp,
  }) async {
    try {
      return Success<DocumentSignature>(
        (await _remote.sign(
          documentId: documentId,
          signerName: signer.name,
          signerCnic: signer.cnic,
          signerRole: signer.role.wire,
          signatureImageBase64: imageBase64,
          otp: otp,
          // Only ever one of the two: see `SignerIdentity`.
          signerEmail: signer.signerEmail,
          signerPhone: signer.signerPhone,
        )).toEntity(),
      );
    } on Object catch (error) {
      return FailureResult<DocumentSignature>(Failure.from(error));
    }
  }

  @override
  Future<Result<List<DocumentSignature>>> getSignatures(int documentId) async {
    try {
      return Success<List<DocumentSignature>>(
        (await _remote.getSignatures(documentId))
            .map((SignatureDetailDto dto) => dto.toEntity())
            .toList(growable: false),
      );
    } on Object catch (error) {
      return FailureResult<List<DocumentSignature>>(Failure.from(error));
    }
  }
}
