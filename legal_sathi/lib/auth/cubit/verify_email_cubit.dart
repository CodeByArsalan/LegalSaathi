import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/failure.dart';
import '../../core/errors/result.dart';
import '../domain/entities/auth_session.dart';
import '../domain/usecases/resend_verification_code.dart';
import '../domain/usecases/verify_email.dart';
import 'auth_cubit.dart';
import 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit({
    required String email,
    required VerifyEmailUseCase verifyEmail,
    required ResendVerificationCodeUseCase resendCode,
    required AuthCubit auth,
  }) : _verifyEmail = verifyEmail,
       _resendCode = resendCode,
       _auth = auth,
       super(VerifyEmailInitial(email: email));

  final VerifyEmailUseCase _verifyEmail;
  final ResendVerificationCodeUseCase _resendCode;
  final AuthCubit _auth;

  /// [email] is taken from the form rather than from the seeded state: the
  /// screen is also reached when a login was refused, and the identifier typed
  /// there may be a phone number while the OTP always goes to the address.
  Future<void> submit({required String email, required String code}) async {
    final String address = email.trim();
    emit(VerifyEmailSubmitting(email: address));

    final Result<AuthSession> result = await _verifyEmail(
      email: address,
      code: code,
    );
    if (isClosed) return;

    result.fold<void>(
      onSuccess: (AuthSession session) {
        // This is where the session is born — `/Auth/register` returns none.
        _auth.signIn(session);
        emit(VerifyEmailVerified(email: address));
      },
      onFailure: (Failure failure) =>
          emit(VerifyEmailFailure(email: address, failure: failure)),
    );
  }

  Future<void> resend(String email) async {
    final String address = email.trim();
    final Result<String> result = await _resendCode(address);
    if (isClosed) return;

    result.fold<void>(
      onSuccess: (String message) =>
          emit(VerifyEmailCodeSent(email: address, message: message)),
      onFailure: (Failure failure) =>
          emit(VerifyEmailFailure(email: address, failure: failure)),
    );
  }
}

extension VerifyEmailStateX on VerifyEmailState {
  String get email => maybeWhen(
    initial: (String value) => value,
    submitting: (String value) => value,
    codeSent: (String value, String _) => value,
    verified: (String value) => value,
    failure: (String value, Failure _) => value,
    orElse: () => '',
  );
}
