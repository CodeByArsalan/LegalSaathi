import '../../../core/errors/result.dart';
import '../repositories/auth_repository.dart';

class ResendVerificationCodeUseCase {
  const ResendVerificationCodeUseCase(this._repository);

  final AuthRepository _repository;

  /// Resolves to the server's confirmation message.
  Future<Result<String>> call(String email) =>
      _repository.resendVerificationCode(email);
}
