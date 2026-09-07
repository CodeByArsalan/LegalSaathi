import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_signature.freezed.dart';

/// A signature recorded against a document.
///
/// [signatureUri] is where the server stored the captured ink — a vault file
/// name, not a URL. No endpoint serves it, so it is shown as evidence that an
/// image was filed rather than rendered.
@freezed
abstract class DocumentSignature with _$DocumentSignature {
  const factory DocumentSignature({
    required int id,
    required int documentId,
    required String signerName,
    required String signerCnic,
    required String signerRole,
    required String signatureUri,
    required bool isOtpVerified,
    required DateTime signedAt,
    String? signerEmail,
    String? signerPhone,
    String? ipAddress,
  }) = _DocumentSignature;
}

extension DocumentSignatureX on DocumentSignature {
  /// The contact the code was verified against, for display.
  String get contact => signerEmail ?? signerPhone ?? '';
}
