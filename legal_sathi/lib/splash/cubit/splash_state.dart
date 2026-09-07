import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState.launching() = SplashLaunching;

  /// Session restored (or absent) and the minimum brand time elapsed.
  const factory SplashState.ready() = SplashReady;
}
