import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/buttons/ghost_button.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../../../core/widgets/inputs/app_text_field.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import 'auth_footer_link.dart';
import 'auth_scaffold.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _identifier = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    // The demo accounts live in the bundled mock backend only; against the
    // hosted API there is nothing to prefill and the hint would be a lie.
    if (AppConfig.useMockApi) {
      _identifier.text = AppConfig.demoEmail;
      _password.text = AppConfig.demoPassword;
    }
  }

  @override
  void dispose() {
    _identifier.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<LoginCubit>().submit(
      emailOrPhone: _identifier.text,
      password: _password.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool submitting =
        context.watch<LoginCubit>().state is LoginSubmitting;

    return AuthScaffold(
      title: tr('auth.welcome_back'),
      subtitle: tr('auth.sign_in_subtitle'),
      footnote: AuthFooterLink(
        question: tr('auth.no_account'),
        actionLabel: ' ${tr('auth.create_one')}',
        onTap: () => context.pushNamed(RouteNames.register),
      ),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppTextField(
                controller: _identifier,
                label: tr('auth.email_or_phone'),
                prefixIcon: Icons.person_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                enabled: !submitting,
                validator: Validators.emailOrPhone,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(
                controller: _password,
                label: tr('auth.password'),
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                textInputAction: TextInputAction.done,
                enabled: !submitting,
                validator: Validators.required,
                onSubmitted: (_) => _submit(),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: GhostButton(
                  label: tr('auth.forgot_password'),
                  onPressed: () =>
                      AppSnackBar.show(context, tr('common.coming_soon')),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: tr('auth.sign_in'),
                isLoading: submitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
        if (AppConfig.useMockApi) ...<Widget>[
          const SizedBox(height: AppSpacing.lg),
          Text(
            tr(
              'auth.demo_credentials',
              namedArgs: <String, String>{
                'email': AppConfig.demoEmail,
                'password': AppConfig.demoPassword,
              },
            ),
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textLight,
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }
}
