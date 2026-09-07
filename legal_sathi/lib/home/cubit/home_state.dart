import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../../../core/widgets/state_view.dart';
import '../domain/entities/home_feed.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.loading() = HomeLoading;

  const factory HomeState.ready(HomeFeed feed) = HomeReady;

  const factory HomeState.failure(Failure failure) = HomeFailure;
}

extension HomeStateX on HomeState {
  HomeFeed? get feed =>
      maybeWhen(ready: (HomeFeed value) => value, orElse: () => null);

  Failure? get failure =>
      maybeWhen(failure: (Failure value) => value, orElse: () => null);

  ViewState get viewState => when(
    loading: () => ViewState.loading,
    ready: (HomeFeed feed) => ViewState.ready,
    failure: (Failure failure) => ViewState.failure,
  );
}
