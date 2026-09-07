import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

/// Device-local preferences. Language is applied through easy_localization.
/// The notification preference is stored but nothing acts on it: the API has no
/// push channel, so there is nothing to subscribe to yet.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('en') String localeCode,
    @Default(true) bool notificationsEnabled,
  }) = _AppSettings;
}
