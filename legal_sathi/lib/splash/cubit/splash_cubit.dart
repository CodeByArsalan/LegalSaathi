import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth_cubit.dart';
import 'splash_state.dart';

/// Runs the cold-start sequence: read the stored session, and hold the brand
/// screen for a beat so the router redirect does not look like a flash.
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._auth) : super(const SplashState.launching());

  final AuthCubit _auth;

  static const Duration _minimumDisplay = Duration(milliseconds: 900);

  Future<void> begin() async {
    await Future.wait(<Future<void>>[
      _auth.start(),
      Future<void>.delayed(_minimumDisplay),
    ]);
    if (isClosed) return;
    emit(const SplashState.ready());
  }
}
