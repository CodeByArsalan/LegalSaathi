import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/errors/failure.dart';
import '../domain/entities/app_user.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;

  const factory LoginState.submitting() = LoginSubmitting;

  const factory LoginState.success(AppUser user) = LoginSuccess;

  /// Login refused because the account exists but its email is still
  /// unverified. The server re-sends the OTP while rejecting the login, so the
  /// useful response is a route to the verification screen rather than a
  /// dead-end error — which is why this carries the address to verify.
  const factory LoginState.unverified({
    required String email,
    String? message,
  }) = LoginUnverified;

  const factory LoginState.failure(Failure failure) = LoginFailureState;
}
