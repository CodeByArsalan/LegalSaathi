import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/errors/failure.dart';

part 'verify_email_state.freezed.dart';

@freezed
abstract class VerifyEmailState with _$VerifyEmailState {
  const factory VerifyEmailState.initial({required String email}) =
      VerifyEmailInitial;

  const factory VerifyEmailState.submitting({required String email}) =
      VerifyEmailSubmitting;

  /// The OTP was re-sent. [message] is the server's own confirmation text.
  const factory VerifyEmailState.codeSent({
    required String email,
    required String message,
  }) = VerifyEmailCodeSent;

  /// The OTP was accepted and the session now exists — the router sends the
  /// user to the shell on its own.
  const factory VerifyEmailState.verified({required String email}) =
      VerifyEmailVerified;

  const factory VerifyEmailState.failure({
    required String email,
    required Failure failure,
  }) = VerifyEmailFailure;
}
