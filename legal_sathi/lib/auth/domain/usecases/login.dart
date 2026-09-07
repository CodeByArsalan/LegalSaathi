import '../../../core/errors/result.dart';
import '../entities/auth_session.dart';
import '../entities/credentials.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AuthSession>> call(LoginCredentials credentials) =>
      _repository.login(credentials);
}
