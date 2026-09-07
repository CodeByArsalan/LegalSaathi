import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/errors/app_exception.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';

void main() {
  group('Result', () {
    test('Success folds to the data branch', () {
      const result = Success<int>(7);

      expect(result.isSuccess, isTrue);
      expect(result.value, 7);
      expect(result.failure, isNull);
      expect(
        result.fold(onSuccess: (int v) => 'ok $v', onFailure: (_) => 'bad'),
        'ok 7',
      );
    });

    test('FailureResult folds to the failure branch', () {
      const result = FailureResult<int>(NetworkFailure());

      expect(result.isSuccess, isFalse);
      expect(result.value, isNull);
      expect(result.failure, isA<NetworkFailure>());
      expect(
        result.fold(
          onSuccess: (_) => 'bad',
          onFailure: (Failure f) => f.l10nKey,
        ),
        'errors.network',
      );
    });
  });

  group('Failure.from', () {
    test('maps each exception kind to its failure', () {
      const cases = <AppExceptionKind, String>{
        AppExceptionKind.network: 'errors.network',
        AppExceptionKind.timeout: 'errors.timeout',
        AppExceptionKind.unauthorized: 'errors.session_expired',
        AppExceptionKind.invalidCredentials: 'errors.invalid_credentials',
        AppExceptionKind.forbidden: 'errors.forbidden',
        AppExceptionKind.notFound: 'errors.not_found',
        AppExceptionKind.validation: 'errors.validation',
        AppExceptionKind.server: 'errors.server',
        AppExceptionKind.cache: 'errors.cache',
        AppExceptionKind.unknown: 'errors.unknown',
      };

      cases.forEach((AppExceptionKind kind, String key) {
        final failure = Failure.from(AppException('boom', kind: kind));
        expect(failure.l10nKey, key, reason: 'kind ${kind.name}');
      });
    });

    test('keeps server field errors for form display', () {
      final failure = Failure.from(
        const AppException(
          'invalid',
          kind: AppExceptionKind.validation,
          fieldErrors: <String, String>{'email': 'already_registered'},
        ),
      );

      expect(
        (failure as ValidationFailure).fieldErrors['email'],
        'already_registered',
      );
    });

    test('wraps an unexpected error rather than losing it', () {
      final failure = Failure.from(StateError('exploded'));

      expect(failure, isA<UnknownFailure>());
      expect(failure.message, contains('exploded'));
    });
  });
}
