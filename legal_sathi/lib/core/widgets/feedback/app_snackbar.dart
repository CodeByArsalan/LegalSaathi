import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../errors/failure.dart';
import '../../theme/app_colors.dart';

abstract final class AppSnackBar {
  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
    SnackBarAction? action,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppColors.error : AppColors.text,
          duration: duration ?? Duration(seconds: isError ? 5 : 3),
          action: action,
        ),
      );
  }

  static void success(BuildContext context, String message) =>
      show(context, message);

  /// The translated key stays the headline so the snackbar reads correctly in
  /// Urdu; the server's own text is appended because it carries the specific
  /// reason ("An account with this phone number already exists.") that a
  /// generic key cannot.
  static void failure(BuildContext context, Failure failure) {
    final String title = tr(failure.l10nKey);
    final String? detail = failure.message;
    show(
      context,
      detail == null || detail.isEmpty ? title : '$title\n$detail',
      isError: true,
    );
  }
}
