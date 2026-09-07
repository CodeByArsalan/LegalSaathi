import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/home_feed.dart';
import '../domain/usecases/get_home_feed.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHomeFeed) : super(const HomeState.loading());

  final GetHomeFeedUseCase _getHomeFeed;

  Future<void> load() async {
    emit(const HomeState.loading());
    final result = await _getHomeFeed();
    if (isClosed) return;

    emit(
      result.fold<HomeState>(
        onSuccess: (HomeFeed feed) => HomeState.ready(feed),
        onFailure: (Failure failure) => HomeState.failure(failure),
      ),
    );
  }
}
