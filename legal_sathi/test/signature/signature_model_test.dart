import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/network/api_envelope.dart';
import 'package:legal_sathi/signature/data/models/signature_detail_dto.dart';
import 'package:legal_sathi/signature/data/models/signing_otp_dto.dart';
import 'package:legal_sathi/signature/domain/entities/document_signature.dart';
import 'package:legal_sathi/signature/domain/entities/signer_identity.dart';

import '../support/fixtures.dart';

/// The signing payloads as the live API returns them, and the two rules the flow
/// is built around: which contact a code goes to, and what the server records.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('live payloads', () {
    test('the code receipt carries the masked destination and its expiry', () {
      final SigningOtpDto dto = ApiEnvelope.unwrapObject<SigningOtpDto>(
        fixtureResponse('signature_request_otp', statusCode: 200),
        SigningOtpDto.fromJson,
      );

      expect(dto.destinationMasked, 'ls***@uberip.com');
      expect(dto.expiresAt.isUtc, isTrue);
      expect(
        dto.expiresAt.toIso8601String(),
        startsWith('2026-09-07T08:46:10'),
      );
    });

    test(
      'a filed signature reads back as the evidence the server recorded',
      () {
        final DocumentSignature signature =
            ApiEnvelope.unwrapObject<SignatureDetailDto>(
              fixtureResponse('signature_submit', statusCode: 200),
              SignatureDetailDto.fromJson,
            ).toEntity();

        expect(signature.id, 3);
        expect(signature.documentId, 4);
        expect(signature.signerName, 'Gate Check');
        expect(signature.signerCnic, '35201-1234567-1');
        expect(signature.signerRole, 'Deponent');
        expect(signature.isOtpVerified, isTrue);
        expect(signature.signedAt.isUtc, isTrue);
        // The vault file the ink was written to — a name, not a URL to fetch.
        expect(signature.signatureUri, endsWith('.png'));
        expect(signature.ipAddress, '223.123.41.4');
        expect(signature.contact, 'lsgate66921159@uberip.com');
      },
    );

    test(
      'the list route sends no timezone designator and still reads as UTC',
      () {
        final List<DocumentSignature> signatures =
            ApiEnvelope.unwrapList<SignatureDetailDto>(
                  fixtureResponse('signature_list', statusCode: 200),
                  SignatureDetailDto.fromJson,
                )
                .map((SignatureDetailDto dto) => dto.toEntity())
                .toList(growable: false);

        expect(signatures, hasLength(2));
        expect(
          signatures.map((DocumentSignature signature) => signature.id),
          <int>[2, 3],
        );
        for (final DocumentSignature signature in signatures) {
          expect(signature.signedAt.isUtc, isTrue);
          expect(signature.documentId, 4);
        }
      },
    );

    test('a code presented for the wrong contact is refused by name', () {
      // The failure the whole single-destination design exists to avoid.
      final Map<String, dynamic>? body = fixtureJson(
        'fail_signature_otp_destination_mismatch',
      );

      expect(
        ApiEnvelope.messageOf(body!),
        'No OTP request found for this destination or OTP has expired.',
      );
    });
  });

  group('signer identity', () {
    test('an email contact fills only the email field', () {
      const SignerIdentity signer = SignerIdentity(
        name: 'Muhammad Ali',
        cnic: '35201-1234567-1',
        destination: 'ali@example.com',
      );

      expect(signer.byEmail, isTrue);
      expect(signer.signerEmail, 'ali@example.com');
      expect(signer.signerPhone, isNull);
    });

    test('a phone contact fills only the phone field', () {
      const SignerIdentity signer = SignerIdentity(
        name: 'Muhammad Ali',
        cnic: '35201-1234567-1',
        destination: '03001234567',
      );

      expect(signer.byEmail, isFalse);
      expect(signer.signerPhone, '03001234567');
      expect(signer.signerEmail, isNull);
    });

    test('the role defaults to the one an affidavit is sworn by', () {
      const SignerIdentity signer = SignerIdentity(
        name: 'A',
        cnic: '1',
        destination: 'a@b.c',
      );

      expect(signer.role, SignerRole.deponent);
      expect(signer.role.wire, 'Deponent');
    });
  });

  group('signer roles', () {
    test('every role the API accepts has a translation key', () async {
      final Set<String> english = await _signatureKeys('en-US');
      final Set<String> urdu = await _signatureKeys('ur-PK');

      for (final SignerRole role in SignerRole.values) {
        expect(english, contains(role.l10nKey), reason: role.wire);
        expect(urdu, contains(role.l10nKey), reason: role.wire);
      }
    });

    test('both locales carry the same signature keys', () async {
      expect(await _signatureKeys('ur-PK'), await _signatureKeys('en-US'));
    });

    test('a recorded role reads back whatever its spelling', () {
      expect(SignerRole.tryParse('Deponent'), SignerRole.deponent);
      expect(SignerRole.tryParse(' firstparty '), SignerRole.firstParty);
      expect(SignerRole.tryParse('Guarantor'), isNull);
      expect(SignerRole.tryParse(null), isNull);
    });
  });
}

/// The `signature.*` keys of one locale, so the two can be compared and the roles
/// checked against them.
Future<Set<String>> _signatureKeys(String locale) async {
  final Map<String, dynamic> decoded =
      jsonDecode(
            await rootBundle.loadString('assets/translations/$locale.json'),
          )
          as Map<String, dynamic>;
  final Map<String, dynamic> group =
      decoded['signature']! as Map<String, dynamic>;
  return group.keys.map((String key) => 'signature.$key').toSet();
}
