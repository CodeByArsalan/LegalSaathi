import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_result.freezed.dart';

/// What `POST /Auth/register` gives back: an account was created, but **no
/// tokens**. The API emails a 6-digit OTP and refuses login until
/// `POST /Auth/verify-email` succeeds, so registration is not a session and the
/// next screen has to be the verification one.
@freezed
abstract class RegisterResult with _$RegisterResult {
  const factory RegisterResult({
    required int userId,
    required String email,
    required bool requiresEmailVerification,

    /// The server's own confirmation text, which names the address the OTP went
    /// to. Worth showing verbatim.
    required String message,
  }) = _RegisterResult;
}
