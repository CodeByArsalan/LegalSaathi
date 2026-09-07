import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../domain/entities/document_signature.dart';
import '../domain/entities/signer_identity.dart';
import '../domain/entities/signing_otp.dart';
import '../domain/usecases/request_signing_otp.dart';
import '../domain/usecases/sign_document.dart';
import 'signature_state.dart';

/// Drives signing as the API requires it: a code requested for one contact, then
/// the captured ink submitted against that same contact.
class SignatureCubit extends Cubit<SignatureState> {
  SignatureCubit({
    required RequestSigningOtpUseCase requestOtp,
    required SignDocumentUseCase signDocument,
    required int documentId,
  }) : _requestOtp = requestOtp,
       _signDocument = signDocument,
       super(SignatureState(documentId: documentId));

  final RequestSigningOtpUseCase _requestOtp;
  final SignDocumentUseCase _signDocument;

  /// The captured PNG, held here rather than in the state: it is hundreds of
  /// kilobytes of base64 that nothing renders, and every emit would print it.
  String? _inkBase64;

  /// Freezes [imageBase64] as the signature to file and asks the server for a
  /// code. Capturing here, while the pad is still on screen, is what makes the
  /// ink available at submit time — the verify step replaces it.
  Future<void> sendCode({
    required SignerIdentity signer,
    required String imageBase64,
  }) async {
    _inkBase64 = imageBase64;
    emit(
      state.copyWith(
        isSendingCode: true,
        failure: null,
        signer: signer,
        signed: null,
      ),
    );

    final Result<SigningOtp> result = await _requestOtp(
      documentId: state.documentId,
      signer: signer,
    );
    if (isClosed) return;

    emit(
      result.fold<SignatureState>(
        onSuccess: (SigningOtp ticket) => state.copyWith(
          isSendingCode: false,
          ticket: ticket,
          step: SignatureStep.verify,
          failure: null,
        ),
        onFailure: (Failure failure) =>
            state.copyWith(isSendingCode: false, failure: failure),
      ),
    );
  }

  /// Asks for a fresh code against the identity and ink the last one was issued
  /// for. The pad is off screen by now, so there is nothing to export again.
  Future<void> resendCode() async {
    final SignerIdentity? signer = state.signer;
    final String? imageBase64 = _inkBase64;
    if (signer == null || imageBase64 == null) return;
    await sendCode(signer: signer, imageBase64: imageBase64);
  }

  /// Files the ink captured for the current code. [otp] is verified against the
  /// contact in [SignatureState.signer].
  Future<void> sign(String otp) async {
    final SignerIdentity? signer = state.signer;
    final String? imageBase64 = _inkBase64;
    if (signer == null || imageBase64 == null) return;

    emit(state.copyWith(isSigning: true, failure: null));

    final Result<DocumentSignature> result = await _signDocument(
      documentId: state.documentId,
      signer: signer,
      imageBase64: imageBase64,
      otp: otp,
    );
    if (isClosed) return;

    emit(
      result.fold<SignatureState>(
        onSuccess: (DocumentSignature signature) =>
            state.copyWith(isSigning: false, signed: signature, failure: null),
        onFailure: (Failure failure) =>
            state.copyWith(isSigning: false, failure: failure),
      ),
    );
  }

  /// Back to the pad, keeping the ink and the identity so a wrong code costs
  /// nothing but a new one.
  void backToCapture() =>
      emit(state.copyWith(step: SignatureStep.capture, failure: null));
}
