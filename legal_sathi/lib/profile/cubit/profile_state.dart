import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/profile_stats.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = ProfileLoading;

  const factory ProfileState.ready(ProfileStats stats) = ProfileReady;

  const factory ProfileState.failure(Failure failure) = ProfileFailure;
}

extension ProfileStateX on ProfileState {
  /// `null` while loading and after a failure, which the screen reads as "no
  /// counts yet" rather than as a page worth taking away: the identity above it
  /// comes from the session and is still there.
  ProfileStats? get stats =>
      maybeWhen(ready: (ProfileStats value) => value, orElse: () => null);

  Failure? get failure =>
      maybeWhen(failure: (Failure value) => value, orElse: () => null);
}
