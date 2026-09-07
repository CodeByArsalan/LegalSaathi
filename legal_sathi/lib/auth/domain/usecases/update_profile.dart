import '../../../core/errors/result.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AppUser>> call({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  }) => _repository.updateProfile(
    fullName: fullName,
    phoneNumber: phoneNumber,
    cnic: cnic,
  );
}
