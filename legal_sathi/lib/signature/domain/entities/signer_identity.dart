import 'package:freezed_annotation/freezed_annotation.dart';

part 'signer_identity.freezed.dart';

/// The capacity the signer declares. The API stores the value verbatim, so
/// [wire] keeps the spelling its own web client sends.
enum SignerRole {
  deponent('Deponent'),
  firstParty('FirstParty'),
  secondParty('SecondParty'),
  landlord('Landlord'),
  tenant('Tenant'),
  buyer('Buyer'),
  seller('Seller'),
  witness('Witness');

  const SignerRole(this.wire);

  final String wire;

  String get l10nKey => 'signature.role_${wire.toLowerCase()}';

  /// `null` for a role this build does not know: the API stores the value it is
  /// sent, so an older client or the web app may have filed one of its own.
  static SignerRole? tryParse(String? value) {
    final String normalized = value?.trim() ?? '';
    for (final SignerRole role in values) {
      if (role.wire.toLowerCase() == normalized.toLowerCase()) return role;
    }
    return null;
  }
}

/// Who is signing, and the single contact the authorisation code goes to.
///
/// The API takes one destination string and tells email from phone by whether it
/// contains `@`; when the signature is submitted it verifies the code against
/// `signerPhone ?? signerEmail`. Sending both contacts, or a different one than
/// the code was sent to, therefore fails with "No OTP request found for this
/// destination" — so the contact is held once and the two request fields are
/// derived from it, where they cannot disagree.
@freezed
abstract class SignerIdentity with _$SignerIdentity {
  const factory SignerIdentity({
    required String name,
    required String cnic,
    required String destination,
    @Default(SignerRole.deponent) SignerRole role,
  }) = _SignerIdentity;
}

extension SignerIdentityX on SignerIdentity {
  bool get byEmail => destination.contains('@');

  /// Non-null only when [destination] is an email address.
  String? get signerEmail => byEmail ? destination : null;

  /// Non-null only when [destination] is a phone number.
  String? get signerPhone => byEmail ? null : destination;
}
