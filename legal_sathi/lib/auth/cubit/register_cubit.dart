import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/failure.dart';
import '../../core/errors/result.dart';
import '../domain/entities/credentials.dart';
import '../domain/entities/register_result.dart';
import '../domain/usecases/register.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required RegisterUseCase register})
    : _register = register,
      super(const RegisterState.initial());

  final RegisterUseCase _register;

  /// Registration does not sign anyone in: the API creates the account, emails a
  /// 6-digit OTP and refuses login until `/Auth/verify-email` redeems it. The
  /// view's job on success is therefore to navigate, not to wait for a session.
  Future<void> submit({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? cnic,
  }) async {
    emit(const RegisterState.submitting());

    final Result<RegisterResult> result = await _register(
      RegisterCredentials(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        cnic: cnic,
      ),
    );

    if (isClosed) return;

    result.fold<void>(
      onSuccess: (RegisterResult value) => emit(
        RegisterState.success(email: value.email, message: value.message),
      ),
      onFailure: (Failure failure) => emit(RegisterState.failure(failure)),
    );
  }

  void reset() {
    if (isClosed || state is RegisterInitial) return;
    emit(const RegisterState.initial());
  }
}
