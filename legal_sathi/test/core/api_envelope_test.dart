import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/errors/app_exception.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/network/api_envelope.dart';
import 'package:legal_sathi/core/network/dio_error_mapper.dart';

import '../support/fixtures.dart';

/// Every assertion here runs against a response captured from the live API, so
/// the shapes are the server's rather than an assumption about them.
void main() {
  group('ApiEnvelope success', () {
    test('unwrapObject hands the parser the data payload', () {
      final Map<String, dynamic> data =
          ApiEnvelope.unwrapObject<Map<String, dynamic>>(
            fixtureResponse('auth_login', statusCode: 200),
            (Map<String, dynamic> json) => json,
          );

      expect(data['userId'], 3);
      expect(data['email'], 'lsgate66921159@uberip.com');
      expect(data['refreshToken'], isNotEmpty);
    });

    test('unwrapList reads a collection payload', () {
      final List<String> slugs = ApiEnvelope.unwrapList<String>(
        fixtureResponse('templates_list', statusCode: 200),
        (Map<String, dynamic> json) => json['slug']! as String,
      );

      expect(slugs, hasLength(7));
      expect(slugs, contains('general-affidavit'));
    });

    test('unwrapList accepts an empty collection', () {
      final List<Object?> items = ApiEnvelope.unwrapList<Object?>(
        fixtureResponse('documents_list_empty', statusCode: 200),
        (Map<String, dynamic> json) => json,
      );

      expect(items, isEmpty);
    });

    test(
      'a success with no payload is a server failure, not a parse crash',
      () {
        final Response<dynamic> response = Response<dynamic>(
          requestOptions: RequestOptions(path: '/Documents'),
          statusCode: 200,
          data: <String, dynamic>{'success': true, 'data': null},
        );

        expect(
          () => ApiEnvelope.unwrapObject<Map<String, dynamic>>(
            response,
            (Map<String, dynamic> json) => json,
          ),
          throwsA(
            isA<AppException>().having(
              (AppException e) => e.kind,
              'kind',
              AppExceptionKind.server,
            ),
          ),
        );
      },
    );

    test('ensureSuccess tolerates an envelope with no data at all', () {
      // `revoke-token` is answered by the backend's non-generic envelope.
      final Response<dynamic> response = Response<dynamic>(
        requestOptions: RequestOptions(path: '/Auth/revoke-token'),
        statusCode: 200,
        data: <String, dynamic>{
          'success': true,
          'message': 'Logged out successfully.',
        },
      );

      expect(() => ApiEnvelope.ensureSuccess(response), returnsNormally);
    });
  });

  group('ApiEnvelope failure', () {
    test('surfaces errors[0] instead of the generic message', () {
      expect(
        () => ApiEnvelope.unwrapObject<Map<String, dynamic>>(
          fixtureResponse('fail_login_invalid', statusCode: 400),
          (Map<String, dynamic> json) => json,
        ),
        throwsA(
          isA<AppException>()
              .having(
                (AppException e) => e.message,
                'message',
                'Invalid email/phone or password.',
              )
              .having(
                (AppException e) => e.kind,
                'kind',
                AppExceptionKind.validation,
              )
              .having((AppException e) => e.code, 'code', isNull),
        ),
      );
    });

    test(
      'carries EmailNotVerified as a code, keeping the text as the message',
      () {
        final AppException exception = _catchEnvelope('fail_login_unverified');

        expect(exception.code, 'EmailNotVerified');
        expect(exception.message, contains('has not been verified yet'));

        final Failure failure = Failure.fromAppException(exception);
        expect(failure, isA<EmailNotVerifiedFailure>());
        expect(failure.l10nKey, 'errors.email_not_verified');
        expect(failure.message, contains('has not been verified yet'));
      },
    );

    test('reads ProblemDetails, which has no envelope', () {
      final Map<String, dynamic> body = fixtureJson(
        'fail_validation_problemdetails',
      )!;

      expect(ApiEnvelope.codeOf(body), isNull);
      expect(ApiEnvelope.fieldErrorsOf(body), <String, String>{
        'EmailOrPhone': 'The EmailOrPhone field is required.',
      });
      expect(
        ApiEnvelope.messageOf(body),
        'The EmailOrPhone field is required.',
      );
    });

    test('a missing slug is a 400 carrying the reason, not a 404', () {
      final AppException exception = _catchEnvelope('fail_not_found');

      expect(
        exception.message,
        contains("Template with slug 'this-slug-does-not-exist' not found."),
      );
    });
  });

  group('DioErrorMapper', () {
    test('maps the business failure envelope to a validation failure', () {
      final Failure failure = Failure.from(
        DioErrorMapper.from(
          fixtureError(
            'fail_login_invalid',
            statusCode: 400,
            path: '/Auth/login',
          ),
        ),
      );

      expect(failure, isA<ValidationFailure>());
      expect(failure.message, 'Invalid email/phone or password.');
    });

    test('maps ProblemDetails and keeps the field name', () {
      final Failure failure = Failure.from(
        DioErrorMapper.from(
          fixtureError('fail_validation_problemdetails', statusCode: 400),
        ),
      );

      expect(failure, isA<ValidationFailure>());
      expect(
        (failure as ValidationFailure).fieldErrors['EmailOrPhone'],
        'The EmailOrPhone field is required.',
      );
    });

    test('maps the empty 401 body to a session expiry', () {
      // The API sends no content with a 401, so the status is the only signal.
      final Failure failure = Failure.from(
        DioErrorMapper.from(
          fixtureError(
            'fail_unauthorized',
            statusCode: 401,
            path: '/Documents',
          ),
        ),
      );

      expect(failure, isA<SessionExpiredFailure>());
      expect(failure.statusCode, 401);
      expect(failure.message, 'Session expired.');
    });

    test('maps a reused refresh token to a session expiry message', () {
      final AppException exception = DioErrorMapper.from(
        fixtureError(
          'fail_refresh_with_access_token',
          statusCode: 400,
          path: '/Auth/refresh-token',
        ),
      );

      expect(
        exception.message,
        'Invalid or expired refresh token. Please sign in again.',
      );
    });

    test('classifies transport failures without a response', () {
      expect(
        DioErrorMapper.from(
          DioException(
            requestOptions: RequestOptions(path: '/Templates'),
            type: DioExceptionType.connectionError,
          ),
        ).kind,
        AppExceptionKind.network,
      );
      expect(
        DioErrorMapper.from(
          DioException(
            requestOptions: RequestOptions(path: '/Templates'),
            type: DioExceptionType.receiveTimeout,
          ),
        ).kind,
        AppExceptionKind.timeout,
      );
    });
  });
}

/// Unwraps a captured failure envelope and returns the exception it raises.
AppException _catchEnvelope(String fixture) {
  try {
    ApiEnvelope.unwrapObject<Map<String, dynamic>>(
      fixtureResponse(fixture, statusCode: 400),
      (Map<String, dynamic> json) => json,
    );
  } on AppException catch (exception) {
    return exception;
  }
  throw StateError('$fixture did not fail');
}
