import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (LoginState previous, LoginState current) =>
          current is LoginFailureState || current is LoginUnverified,
      listener: (BuildContext context, LoginState state) {
        switch (state) {
          case LoginFailureState(:final failure):
            AppSnackBar.failure(context, failure);
          case LoginUnverified(:final email, :final message):
            _offerVerification(context, email, message);
          default:
            break;
        }
      },
      child: const LoginForm(),
    );
  }

  /// The server refuses the login *and* re-sends the code in the same response,
  /// so the useful reply is the screen where that code goes, not a dead-end
  /// error. Its message names the address it mailed, which matters because the
  /// identifier typed here may have been a phone number.
  ///
  /// The snackbar is dismissed before navigating: it outlives the route, so its
  /// action would otherwise fire against a context this route no longer owns.
  void _offerVerification(BuildContext context, String email, String? message) {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final GoRouter router = GoRouter.of(context);
    AppSnackBar.show(
      context,
      message ?? tr('errors.email_not_verified'),
      isError: true,
      duration: const Duration(seconds: 10),
      action: SnackBarAction(
        label: tr('auth.verify_now'),
        onPressed: () {
          messenger.hideCurrentSnackBar();
          router.go(RoutePaths.verifyEmailLocation(email));
        },
      ),
    );
  }
}
