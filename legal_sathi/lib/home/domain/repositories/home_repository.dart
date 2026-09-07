import '../../../core/errors/result.dart';
import '../entities/home_feed.dart';

abstract class HomeRepository {
  Future<Result<HomeFeed>> getHomeFeed();
}
