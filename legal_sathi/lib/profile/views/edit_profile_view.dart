import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../core/errors/failure.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../../../core/widgets/inputs/app_text_field.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../../../core/widgets/layout/max_width_body.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_state.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// The address is shown but never sent: `UpdateProfileRequest` has no field
  /// for it, and it is what the account was verified against.
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _cnic = TextEditingController();

  @override
  void initState() {
    super.initState();
    final AppUser? user = context.read<AuthCubit>().currentUser;
    _email.text = user?.email ?? '';
    _fullName.text = user?.fullName ?? '';
    _phone.text = user?.phoneNumber ?? '';
    _cnic.text = user?.cnic ?? '';
  }

  @override
  void dispose() {
    for (final TextEditingController controller in <TextEditingController>[
      _email,
      _fullName,
      _phone,
      _cnic,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _save(EditProfileCubit cubit) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final String cnic = _cnic.text.trim();
    cubit.save(
      fullName: _fullName.text.trim(),
      phoneNumber: _phone.text.trim(),
      // Sent as null when the field is blanked, and null clears the stored CNIC
      // — `UpdateProfileRequest.Cnic` is written straight through, DBNull and
      // all. An empty string would instead fail the server's format check, so
      // there is no third option to offer.
      cnic: cnic.isEmpty ? null : cnic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final EditProfileCubit cubit = context.read<EditProfileCubit>();

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listenWhen: (EditProfileState previous, EditProfileState current) =>
          current.saved ||
          (current.failure != null && previous.failure != current.failure),
      listener: (BuildContext context, EditProfileState state) {
        if (state.failure case final Failure failure) {
          AppSnackBar.failure(context, failure);
          return;
        }
        if (state.saved) {
          AppSnackBar.success(context, tr('profile.saved'));
          if (context.canPop()) context.pop();
        }
      },
      builder: (BuildContext context, EditProfileState state) {
        final bool enabled = !state.isSaving;

        return AppScaffold(
          title: tr('profile.edit_profile'),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                context.gutter,
                AppSpacing.md,
                context.gutter,
                AppSpacing.xxxl,
              ),
              children: <Widget>[
                MaxWidthBody(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AppTextField(
                          controller: _email,
                          label: tr('auth.email'),
                          prefixIcon: Icons.alternate_email_rounded,
                          enabled: false,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          tr('profile.email_note'),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppTextField(
                          controller: _fullName,
                          label: tr('auth.full_name'),
                          prefixIcon: Icons.person_outline_rounded,
                          textInputAction: TextInputAction.next,
                          enabled: enabled,
                          validator: Validators.required,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          controller: _phone,
                          label: tr('auth.phone'),
                          prefixIcon: Icons.phone_outlined,
                          hint: '03001234567',
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          enabled: enabled,
                          validator: Validators.pakistanMobile,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          controller: _cnic,
                          label:
                              '${tr('auth.cnic')} (${tr('common.optional')})',
                          prefixIcon: Icons.credit_card_rounded,
                          hint: '42101-1234567-1',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          enabled: enabled,
                          validator: (String? value) =>
                              value == null || value.trim().isEmpty
                              ? null
                              : Validators.cnic(value),
                          onSubmitted: (_) => _save(cubit),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomBar: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.gutter,
                AppSpacing.md,
                context.gutter,
                AppSpacing.md,
              ),
              child: MaxWidthBody(
                child: PrimaryButton(
                  label: tr('common.save'),
                  icon: Icons.check_rounded,
                  isLoading: state.isSaving,
                  onPressed: enabled ? () => _save(cubit) : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
