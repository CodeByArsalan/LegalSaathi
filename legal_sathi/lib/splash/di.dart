import 'package:get_it/get_it.dart';

import '../splash/cubit/splash_cubit.dart';

void configureSplash(GetIt getIt) {
  getIt.registerFactory<SplashCubit>(() => SplashCubit(getIt()));
}
