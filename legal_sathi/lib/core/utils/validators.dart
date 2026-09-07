import 'package:easy_localization/easy_localization.dart';

import '../constants/app_constants.dart';

/// Field-level validators. Messages are resolved through easy_localization at
/// call time, so the same validator works in English and Urdu.
abstract final class Validators {
  static final RegExp _email = RegExp(r'^[\w.+-]+@([\w-]+\.)+[A-Za-z]{2,}$');
  static final RegExp _pakistanMobile = RegExp(r'^(?:\+92|0)?3[0-9]{9}$');
  static final RegExp _cnic = RegExp(r'^\d{5}-?\d{7}-?\d$');

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr('validation.required');
    }
    return null;
  }

  static String? requiredLabel(String? value, String labelKey) {
    if (value == null || value.trim().isEmpty) {
      return tr(
        'validation.field_required',
        namedArgs: <String, String>{'field': tr(labelKey)},
      );
    }
    return null;
  }

  static String? email(String? value) {
    final String? empty = required(value);
    if (empty != null) return empty;
    if (!_email.hasMatch(value!.trim())) return tr('validation.email_invalid');
    return null;
  }

  /// The login identifier the API accepts: either an email address or a
  /// Pakistani mobile number.
  static String? emailOrPhone(String? value) {
    final String? empty = required(value);
    if (empty != null) return empty;
    final String trimmed = value!.trim();
    if (_email.hasMatch(trimmed) || _pakistanMobile.hasMatch(trimmed)) {
      return null;
    }
    return tr('validation.email_or_phone_invalid');
  }

  static String? password(String? value) {
    final String? empty = required(value);
    if (empty != null) return empty;
    if (value!.length < AppConstants.minPasswordLength) {
      return tr(
        'validation.password_too_short',
        namedArgs: <String, String>{'min': '${AppConstants.minPasswordLength}'},
      );
    }
    if (!value.contains(RegExp('[A-Za-z]')) || !value.contains(RegExp(r'\d'))) {
      return tr('validation.password_weak');
    }
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    final String? empty = required(value);
    if (empty != null) return empty;
    if (value != original) return tr('validation.password_mismatch');
    return null;
  }

  static String? pakistanMobile(String? value) {
    final String? empty = required(value);
    if (empty != null) return empty;
    if (!_pakistanMobile.hasMatch(value!.trim())) {
      return tr('validation.phone_invalid');
    }
    return null;
  }

  static String? cnic(String? value) {
    final String? empty = required(value);
    if (empty != null) return empty;
    if (!_cnic.hasMatch(value!.trim().replaceAll(' ', ''))) {
      return tr('validation.cnic_invalid');
    }
    return null;
  }

  static String? maxLength(String? value, int max) {
    if (value != null && value.length > max) {
      return tr(
        'validation.too_long',
        namedArgs: <String, String>{'max': '$max'},
      );
    }
    return null;
  }
}
