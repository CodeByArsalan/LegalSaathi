import '../../../core/errors/result.dart';
import '../entities/app_settings.dart';

abstract class SettingsRepository {
  Result<AppSettings> load();

  Future<Result<bool>> save(AppSettings settings);
}
