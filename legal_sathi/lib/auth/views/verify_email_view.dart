import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/feedback/app_snackbar.dart';
import '../cubit/verify_email_cubit.dart';
import '../cubit/verify_email_state.dart';
import '../widgets/verify_email_form.dart';

/// Reached after registration, or from a login the server refused because the
/// email is still unverified. Verification is what creates the session, so once
/// it lands the router's refresh listener carries the user to Home — this view
/// navigates nowhere itself.
class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyEmailCubit, VerifyEmailState>(
      listenWhen: (VerifyEmailState previous, VerifyEmailState current) =>
          current is VerifyEmailFailure ||
          current is VerifyEmailCodeSent ||
          current is VerifyEmailVerified,
      listener: (BuildContext context, VerifyEmailState state) {
        switch (state) {
          case VerifyEmailFailure(:final failure):
            AppSnackBar.failure(context, failure);
          case VerifyEmailCodeSent(:final message):
            // The server's own text names the address the code went to.
            AppSnackBar.success(context, message);
          case VerifyEmailVerified():
            AppSnackBar.success(context, tr('auth.email_verified'));
          default:
            break;
        }
      },
      child: const VerifyEmailForm(),
    );
  }
}
