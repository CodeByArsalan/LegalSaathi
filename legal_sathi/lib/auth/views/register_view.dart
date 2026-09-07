import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';
import '../widgets/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (RegisterState previous, RegisterState current) =>
          current is RegisterFailureState || current is RegisterSuccess,
      listener: (BuildContext context, RegisterState state) {
        switch (state) {
          case RegisterFailureState(:final failure):
            AppSnackBar.failure(context, failure);
          case RegisterSuccess(:final email, :final message):
            _verify(context, email, message);
          default:
            break;
        }
      },
      child: const RegisterForm(),
    );
  }

  /// Registration is not a session: the API returns no tokens here, and it
  /// refuses to log the account in until the emailed code is entered. So the
  /// next screen is verification, carrying the server's own message — it names
  /// the address the code went to. The snackbar is raised first because it lives
  /// on the app-level messenger and outlives this route.
  void _verify(BuildContext context, String email, String message) {
    AppSnackBar.success(context, message);
    context.go(RoutePaths.verifyEmailLocation(email));
  }
}
