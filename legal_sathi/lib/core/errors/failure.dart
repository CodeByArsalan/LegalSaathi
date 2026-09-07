import '../constants/api_error_codes.dart';
import 'app_exception.dart';

/// A resolved, user-presentable problem. Data sources raise [AppException];
/// repositories map it into a [Failure] so nothing but this type crosses the
/// domain boundary.
///
/// [l10nKey] is an easy_localization key (`errors:*`) so presentation stays
/// translatable; [message] carries the technical/server detail.
sealed class Failure {
  const Failure(this.l10nKey, {this.message, this.statusCode});

  final String l10nKey;
  final String? message;
  final int? statusCode;

  factory Failure.from(Object error) {
    if (error is Failure) return error;
    if (error is AppException) return Failure.fromAppException(error);
    return UnknownFailure(message: error.toString());
  }

  factory Failure.fromAppException(AppException exception) {
    // Every business failure arrives as HTTP 400, so the status cannot tell an
    // unverified account apart from a wrong password — the envelope's code can.
    if (exception.code == ApiErrorCodes.emailNotVerified) {
      return EmailNotVerifiedFailure(message: exception.message);
    }

    return switch (exception.kind) {
      AppExceptionKind.network => NetworkFailure(message: exception.message),
      AppExceptionKind.timeout => TimeoutFailure(message: exception.message),
      AppExceptionKind.unauthorized => SessionExpiredFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      ),
      AppExceptionKind.forbidden => ForbiddenFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      ),
      AppExceptionKind.notFound => NotFoundFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      ),
      AppExceptionKind.invalidCredentials => InvalidCredentialsFailure(
        message: exception.message,
      ),
      AppExceptionKind.validation => ValidationFailure(
        message: exception.message,
        fieldErrors: exception.fieldErrors,
      ),
      AppExceptionKind.unknown => UnknownFailure(message: exception.message),
      AppExceptionKind.server => ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      ),
      AppExceptionKind.cache => CacheFailure(message: exception.message),
    };
  }
}

final class NetworkFailure extends Failure {
  const NetworkFailure({String? message})
    : super('errors.network', message: message);
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure({String? message})
    : super('errors.timeout', message: message);
}

/// 401 — the session is gone and the router sends the user back to login.
final class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure({String? message, int? statusCode})
    : super('errors.session_expired', message: message, statusCode: statusCode);
}

final class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({String? message})
    : super('errors.invalid_credentials', message: message);
}

/// Login refused because the account exists but its email is still unverified.
/// The server re-sends the OTP while rejecting the login, so the right response
/// is to route to the verification screen, not to show a dead-end error.
final class EmailNotVerifiedFailure extends Failure {
  const EmailNotVerifiedFailure({String? message})
    : super('errors.email_not_verified', message: message);
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure({String? message, int? statusCode})
    : super('errors.forbidden', message: message, statusCode: statusCode);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({String? message, int? statusCode})
    : super('errors.not_found', message: message, statusCode: statusCode);
}

final class ValidationFailure extends Failure {
  const ValidationFailure({
    String? message,
    int? statusCode,
    this.fieldErrors = const <String, String>{},
  }) : super('errors.validation', message: message, statusCode: statusCode);

  /// Server-side field errors keyed by form field name.
  final Map<String, String> fieldErrors;
}

final class ServerFailure extends Failure {
  const ServerFailure({String? message, int? statusCode})
    : super('errors.server', message: message, statusCode: statusCode);
}

final class CacheFailure extends Failure {
  const CacheFailure({String? message})
    : super('errors.cache', message: message);
}

final class UnknownFailure extends Failure {
  const UnknownFailure({String? message})
    : super('errors.unknown', message: message);
}
