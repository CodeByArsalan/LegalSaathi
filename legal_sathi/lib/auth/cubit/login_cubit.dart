import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/failure.dart';
import '../../core/errors/result.dart';
import '../domain/entities/auth_session.dart';
import '../domain/entities/credentials.dart';
import '../domain/usecases/login.dart';
import 'auth_cubit.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required LoginUseCase login, required AuthCubit auth})
    : _login = login,
      _auth = auth,
      super(const LoginState.initial());

  final LoginUseCase _login;
  final AuthCubit _auth;

  Future<void> submit({
    required String emailOrPhone,
    required String password,
  }) async {
    emit(const LoginState.submitting());

    final String identifier = emailOrPhone.trim();
    final Result<AuthSession> result = await _login(
      LoginCredentials(emailOrPhone: identifier, password: password),
    );

    if (isClosed) return;

    result.fold<void>(
      onSuccess: (AuthSession session) {
        emit(LoginState.success(session.user));
        _auth.signIn(session);
      },
      onFailure: (Failure failure) {
        // A wrong password and an unverified account both arrive as HTTP 400, so
        // only the failure type separates them — and the unverified one has a
        // next step rather than just a message.
        if (failure is EmailNotVerifiedFailure) {
          emit(
            LoginState.unverified(email: identifier, message: failure.message),
          );
          return;
        }
        emit(LoginState.failure(failure));
      },
    );
  }

  /// Clears a previous failure so the retry button starts from a clean form.
  void reset() {
    if (isClosed || state is LoginInitial) return;
    emit(const LoginState.initial());
  }
}
