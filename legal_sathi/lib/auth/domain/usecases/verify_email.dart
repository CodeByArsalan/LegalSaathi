import '../../../core/errors/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class VerifyEmailUseCase {
  const VerifyEmailUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AuthSession>> call({
    required String email,
    required String code,
  }) => _repository.verifyEmail(email: email, code: code);
}
