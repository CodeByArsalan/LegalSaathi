import '../models/signature_detail_dto.dart';
import '../models/signing_otp_dto.dart';

/// `/Documents/{id}/signatures` endpoints. Implementations throw `AppException`.
abstract class SignatureRemoteDataSource {
  Future<SigningOtpDto> requestOtp({
    required int documentId,
    required String signerName,
    required String signerCnic,
    required String destination,
  });

  /// Exactly one of [signerEmail] and [signerPhone] may be set: the server
  /// verifies the code against `signerPhone ?? signerEmail`, so a signature that
  /// carries both is checked against the phone number only.
  Future<SignatureDetailDto> sign({
    required int documentId,
    required String signerName,
    required String signerCnic,
    required String signerRole,
    required String signatureImageBase64,
    required String otp,
    String? signerEmail,
    String? signerPhone,
  });

  Future<List<SignatureDetailDto>> getSignatures(int documentId);
}
