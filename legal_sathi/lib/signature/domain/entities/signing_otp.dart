import 'package:freezed_annotation/freezed_annotation.dart';

part 'signing_otp.freezed.dart';

/// Receipt for an authorisation code that has been sent.
///
/// The server masks the destination itself and never returns the code, so this
/// is all the app can tell the signer about where to look.
@freezed
abstract class SigningOtp with _$SigningOtp {
  const factory SigningOtp({
    required String destinationMasked,
    required DateTime expiresAt,
  }) = _SigningOtp;
}
