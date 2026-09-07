import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._local);

  final SettingsLocalDataSource _local;

  @override
  Result<AppSettings> load() {
    try {
      return Success<AppSettings>(_local.read());
    } on Object catch (error) {
      return FailureResult<AppSettings>(Failure.from(error));
    }
  }

  @override
  Future<Result<bool>> save(AppSettings settings) async {
    try {
      await _local.write(settings);
      return const Success<bool>(true);
    } on Object catch (error) {
      return FailureResult<bool>(Failure.from(error));
    }
  }
}
