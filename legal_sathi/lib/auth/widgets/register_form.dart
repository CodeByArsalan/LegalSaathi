import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/inputs/app_text_field.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';
import 'auth_footer_link.dart';
import 'auth_scaffold.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _cnic = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    for (final TextEditingController controller in <TextEditingController>[
      _fullName,
      _email,
      _phone,
      _cnic,
      _password,
      _confirmPassword,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<RegisterCubit>().submit(
      fullName: _fullName.text.trim(),
      email: _email.text.trim(),
      phoneNumber: _phone.text.trim(),
      password: _password.text,
      cnic: _cnic.text.trim().isEmpty ? null : _cnic.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool submitting =
        context.watch<RegisterCubit>().state is RegisterSubmitting;

    return AuthScaffold(
      title: tr('auth.register_title'),
      subtitle: tr('auth.register_subtitle'),
      footnote: AuthFooterLink(
        question: tr('auth.have_account'),
        actionLabel: ' ${tr('auth.sign_in')}',
        onTap: () => context.goNamed(RouteNames.login),
      ),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppTextField(
                controller: _fullName,
                label: tr('auth.full_name'),
                prefixIcon: Icons.person_outline_rounded,
                textInputAction: TextInputAction.next,
                enabled: !submitting,
                validator: Validators.required,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _email,
                label: tr('auth.email'),
                prefixIcon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                enabled: !submitting,
                validator: Validators.email,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _phone,
                label: tr('auth.phone'),
                prefixIcon: Icons.phone_outlined,
                hint: '03001234567',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                enabled: !submitting,
                validator: Validators.pakistanMobile,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _cnic,
                label: '${tr('auth.cnic')} (${tr('common.optional')})',
                prefixIcon: Icons.credit_card_rounded,
                hint: '42101-1234567-1',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                enabled: !submitting,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _password,
                label: tr('auth.password'),
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                textInputAction: TextInputAction.next,
                enabled: !submitting,
                validator: Validators.password,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _confirmPassword,
                label: tr('auth.confirm_password'),
                prefixIcon: Icons.lock_reset_rounded,
                isPassword: true,
                textInputAction: TextInputAction.done,
                enabled: !submitting,
                validator: (String? value) =>
                    Validators.confirmPassword(value, _password.text),
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: tr('auth.create_account'),
                isLoading: submitting,
                onPressed: _submit,
              ),
              const AuthTermsNote(),
            ],
          ),
        ),
      ],
    );
  }
}
