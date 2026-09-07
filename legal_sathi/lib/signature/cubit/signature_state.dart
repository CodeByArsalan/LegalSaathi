import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/document_signature.dart';
import '../domain/entities/signer_identity.dart';
import '../domain/entities/signing_otp.dart';

part 'signature_state.freezed.dart';

/// The two halves of signing: capture the ink and the signer's identity, then
/// enter the code that authorises it. The API only accepts a signature that
/// carries a code it issued, so the order cannot be swapped.
enum SignatureStep { capture, verify }

@freezed
abstract class SignatureState with _$SignatureState {
  const factory SignatureState({
    required int documentId,
    @Default(SignatureStep.capture) SignatureStep step,
    @Default(false) bool isSendingCode,
    @Default(false) bool isSigning,

    /// The identity the code was sent to. Submitting reuses it rather than
    /// re-reading the form, so the signature cannot name a different contact
    /// than the one the code was verified against.
    SignerIdentity? signer,
    SigningOtp? ticket,
    DocumentSignature? signed,
    Failure? failure,
  }) = _SignatureState;
}

extension SignatureStateX on SignatureState {
  bool get isBusy => isSendingCode || isSigning;
}
