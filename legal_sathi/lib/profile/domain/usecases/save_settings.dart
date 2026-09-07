import '../../../core/errors/result.dart';
import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class SaveSettingsUseCase {
  const SaveSettingsUseCase(this._repository);

  final SettingsRepository _repository;

  Future<Result<bool>> call(AppSettings settings) => _repository.save(settings);
}
