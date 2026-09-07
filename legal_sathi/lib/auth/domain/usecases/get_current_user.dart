import '../../../core/errors/result.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AppUser>> call() => _repository.currentUser();
}
