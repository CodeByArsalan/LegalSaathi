import '../../../core/errors/result.dart';
import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class LoadSettingsUseCase {
  const LoadSettingsUseCase(this._repository);

  final SettingsRepository _repository;

  Result<AppSettings> call() => _repository.load();
}
