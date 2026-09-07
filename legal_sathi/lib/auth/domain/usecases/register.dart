import '../../../core/errors/result.dart';
import '../entities/credentials.dart';
import '../entities/register_result.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<RegisterResult>> call(RegisterCredentials credentials) =>
      _repository.register(credentials);
}
