import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/buttons/ghost_button.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/inputs/app_otp_field.dart';
import '../../../core/widgets/inputs/app_text_field.dart';
import '../cubit/verify_email_cubit.dart';
import '../cubit/verify_email_state.dart';
import 'auth_scaffold.dart';

class VerifyEmailForm extends StatefulWidget {
  const VerifyEmailForm({super.key});

  @override
  State<VerifyEmailForm> createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _code = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Seeded from the route, then left alone: this field is editable, so
    // re-syncing it from later states would fight the user's typing.
    _email.text = context.read<VerifyEmailCubit>().state.email;
  }

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<VerifyEmailCubit>().submit(
      email: _email.text,
      code: _code.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final VerifyEmailState state = context.watch<VerifyEmailCubit>().state;
    final bool submitting = state is VerifyEmailSubmitting;

    return AuthScaffold(
      title: tr('auth.verify_email_title'),
      subtitle: tr('auth.verify_email_body'),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppTextField(
                controller: _email,
                label: tr('auth.email'),
                hint: tr('auth.verify_email_hint'),
                prefixIcon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                enabled: !submitting,
                validator: Validators.email,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppOtpField(
                controller: _code,
                label: tr('auth.verify_email'),
                validator: Validators.required,
                onCompleted: (_) => _submit(),
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: tr('auth.verify_email'),
                isLoading: submitting,
                onPressed: _submit,
              ),
              GhostButton(
                label: tr('auth.resend_code'),
                onPressed: submitting
                    ? null
                    : () =>
                          context.read<VerifyEmailCubit>().resend(_email.text),
              ),
              GhostButton(
                label: tr('auth.back_to_login'),
                // There is no session on this screen to sign out of: the API
                // issues its first tokens only when the code is accepted.
                onPressed: () => context.go(RoutePaths.login),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
