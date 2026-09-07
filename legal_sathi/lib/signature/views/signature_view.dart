import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderRepaintBoundary;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failure.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/extensions/context_x.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/buttons/ghost_button.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/feedback/app_snackbar.dart';
import '../../../core/widgets/inputs/app_dropdown_field.dart';
import '../../../core/widgets/inputs/app_otp_field.dart';
import '../../../core/widgets/inputs/app_text_field.dart';
import '../../../core/widgets/layout/app_card.dart';
import '../../../core/widgets/layout/app_scaffold.dart';
import '../cubit/signature_cubit.dart';
import '../cubit/signature_state.dart';
import '../domain/entities/signer_identity.dart';
import '../domain/entities/signing_otp.dart';
import '../widgets/signature_pad.dart';

/// Signing under the Pakistan Electronic Transactions Ordinance 2002: the signer
/// declares who they are, draws their signature, and proves control of a contact
/// with a one-time code. The API needs all three on the same request.
class SignatureView extends StatefulWidget {
  const SignatureView({required this.documentId, super.key});

  final int documentId;

  @override
  State<SignatureView> createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _inkBoundary = GlobalKey();
  final SignaturePadController _pad = SignaturePadController();
  final TextEditingController _otp = TextEditingController();
  late final TextEditingController _name;
  late final TextEditingController _cnic;
  late final TextEditingController _destination;

  SignerRole _role = SignerRole.deponent;
  bool _consented = false;

  @override
  void initState() {
    super.initState();
    final AppUser? user = context.read<AuthCubit>().currentUser;
    _name = TextEditingController(text: user?.fullName ?? '');
    _cnic = TextEditingController(text: user?.cnic ?? '');
    // The account email by default: verification already proved it receives mail.
    _destination = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _pad.dispose();
    for (final TextEditingController controller in <TextEditingController>[
      _name,
      _cnic,
      _destination,
      _otp,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  SignerIdentity get _identity => SignerIdentity(
    name: _name.text.trim(),
    cnic: _cnic.text.trim(),
    destination: _destination.text.trim(),
    role: _role,
  );

  Future<void> _sendCode(SignatureCubit cubit) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_pad.hasInk) {
      AppSnackBar.show(context, tr('signature.ink_required'), isError: true);
      return;
    }
    if (!_consented) {
      AppSnackBar.show(
        context,
        tr('signature.consent_required'),
        isError: true,
      );
      return;
    }

    final String? image = await _exportInk();
    if (!mounted) return;
    if (image == null) {
      AppSnackBar.show(context, tr('signature.ink_required'), isError: true);
      return;
    }
    await cubit.sendCode(signer: _identity, imageBase64: image);
  }

  Future<void> _sign(SignatureCubit cubit) async {
    final String code = _otp.text.trim();
    if (code.length < AppConstants.otpLength) {
      AppSnackBar.show(context, tr('signature.otp_required'), isError: true);
      return;
    }
    await cubit.sign(code);
  }

  /// The pad's pixels as a PNG. It is taken before the pad leaves the screen —
  /// once the verify step replaces it there is nothing to export.
  Future<String?> _exportInk() async {
    final RenderRepaintBoundary? boundary =
        _inkBoundary.currentContext?.findRenderObject()
            as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final ui.Image image = await boundary.toImage(pixelRatio: 3);
    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    image.dispose();
    if (bytes == null) return null;
    return base64Encode(bytes.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    final SignatureCubit cubit = context.read<SignatureCubit>();

    return BlocConsumer<SignatureCubit, SignatureState>(
      listenWhen: (SignatureState previous, SignatureState current) =>
          previous.signed != current.signed ||
          (current.failure != null && previous.failure != current.failure),
      listener: (BuildContext context, SignatureState state) {
        if (state.failure case final Failure failure) {
          AppSnackBar.failure(context, failure);
          return;
        }
        if (state.signed != null) {
          AppSnackBar.success(context, tr('signature.saved'));
          if (context.canPop()) context.pop();
        }
      },
      builder: (BuildContext context, SignatureState state) {
        final bool capture = state.step == SignatureStep.capture;

        return AppScaffold(
          title: tr('signature.title'),
          body: SafeArea(
            child: capture
                ? _captureStep(cubit, state)
                : _verifyStep(cubit, state),
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
              child: capture
                  ? PrimaryButton(
                      label: tr('signature.send_code'),
                      icon: Icons.sms_rounded,
                      isLoading: state.isSendingCode,
                      onPressed: state.isBusy ? null : () => _sendCode(cubit),
                    )
                  : PrimaryButton(
                      label: tr('signature.verify_and_sign'),
                      icon: Icons.draw_rounded,
                      isLoading: state.isSigning,
                      onPressed: state.isBusy ? null : () => _sign(cubit),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _captureStep(SignatureCubit cubit, SignatureState state) {
    final bool enabled = !state.isBusy;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        context.gutter,
        AppSpacing.md,
        context.gutter,
        AppSpacing.xxxl,
      ),
      children: <Widget>[
        Text(
          tr('signature.subtitle'),
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppTextField(
                controller: _name,
                label: tr('signature.signer_name'),
                prefixIcon: Icons.person_outline_rounded,
                textInputAction: TextInputAction.next,
                enabled: enabled,
                validator: Validators.required,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _cnic,
                label: tr('signature.signer_cnic'),
                prefixIcon: Icons.credit_card_rounded,
                hint: '35201-1234567-1',
                keyboardType: TextInputType.number,
                maxLength: 15,
                textInputAction: TextInputAction.next,
                enabled: enabled,
                validator: Validators.cnic,
              ),
              const SizedBox(height: AppSpacing.md),
              AppDropdownField<SignerRole>(
                items: SignerRole.values,
                value: _role,
                itemLabel: (SignerRole role) => tr(role.l10nKey),
                label: tr('signature.signer_role'),
                enabled: enabled,
                onChanged: (SignerRole? role) =>
                    setState(() => _role = role ?? SignerRole.deponent),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _destination,
                label: tr('signature.destination'),
                prefixIcon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                enabled: enabled,
                validator: Validators.emailOrPhone,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        SignaturePadLabel(enabled: enabled, onClear: _pad.clear),
        const SizedBox(height: AppSpacing.sm),
        SignaturePad(controller: _pad, boundaryKey: _inkBoundary),
        const SizedBox(height: AppSpacing.lg),
        _EtoConsent(
          value: _consented,
          enabled: enabled,
          onChanged: (bool value) => setState(() => _consented = value),
        ),
      ],
    );
  }

  Widget _verifyStep(SignatureCubit cubit, SignatureState state) {
    final SigningOtp? ticket = state.ticket;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        context.gutter,
        AppSpacing.md,
        context.gutter,
        AppSpacing.xxxl,
      ),
      children: <Widget>[
        AppCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.verified_user_outlined, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tr(
                        'signature.code_sent_to',
                        namedArgs: <String, String>{
                          'destination': ticket?.destinationMasked ?? '',
                        },
                      ),
                      style: context.textTheme.bodyMedium,
                    ),
                    if (ticket case final SigningOtp sent) ...<Widget>[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        tr(
                          'signature.code_expires',
                          namedArgs: <String, String>{
                            'time': Formatters.time(sent.expiresAt.toLocal()),
                          },
                        ),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppOtpField(
          controller: _otp,
          label: tr('signature.otp'),
          enabled: !state.isBusy,
          onCompleted: (String code) {
            if (!state.isBusy) _sign(cubit);
          },
        ),
        const SizedBox(height: AppSpacing.md),
        GhostButton(
          label: tr('auth.resend_code'),
          icon: Icons.sms_failed_outlined,
          onPressed: state.isBusy ? null : cubit.resendCode,
        ),
        const SizedBox(height: AppSpacing.sm),
        GhostButton(
          label: tr('signature.back_to_pad'),
          icon: Icons.rotate_left_rounded,
          onPressed: state.isBusy ? null : cubit.backToCapture,
        ),
      ],
    );
  }
}

/// The declaration the API's own success message cites, so the signer accepts the
/// same ordinance the signature is filed under.
class _EtoConsent extends StatelessWidget {
  const _EtoConsent({
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.card,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: enabled
                ? (bool? next) => onChanged(next ?? false)
                : null,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                top: AppSpacing.md,
                bottom: AppSpacing.md,
                end: AppSpacing.sm,
              ),
              child: Text(
                tr('signature.consent'),
                style: context.textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
