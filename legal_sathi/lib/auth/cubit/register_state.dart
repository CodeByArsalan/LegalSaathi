import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/errors/failure.dart';

part 'register_state.freezed.dart';

@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = RegisterInitial;

  const factory RegisterState.submitting() = RegisterSubmitting;

  /// The account exists but there is no session yet: the API emails an OTP and
  /// refuses login until it is redeemed. [email] is the address the server
  /// actually sent to, which is the one `/Auth/verify-email` must be given.
  const factory RegisterState.success({
    required String email,
    required String message,
  }) = RegisterSuccess;

  const factory RegisterState.failure(Failure failure) = RegisterFailureState;
}
