import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/config/app_config.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';
import 'package:legal_sathi/core/mock/mock_session_store.dart';
import 'package:legal_sathi/signature/data/datasources/signature_remote_data_source.dart';
import 'package:legal_sathi/signature/data/datasources/signature_remote_data_source_mock.dart';
import 'package:legal_sathi/signature/data/models/signature_detail_dto.dart';
import 'package:legal_sathi/signature/data/models/signing_otp_dto.dart';
import 'package:legal_sathi/signature/data/repositories/signature_repository_impl.dart';
import 'package:legal_sathi/signature/domain/entities/document_signature.dart';
import 'package:legal_sathi/signature/domain/entities/signer_identity.dart';
import 'package:legal_sathi/signature/domain/entities/signing_otp.dart';
import 'package:legal_sathi/signature/domain/repositories/signature_repository.dart';

/// Signing as the API requires it: a code for one contact, then a signature that
/// names that same contact.
///
/// The second half is the one worth pinning down. The server verifies the code
/// against `signerPhone ?? signerEmail` and refuses with "No OTP request found
/// for this destination" when the two disagree, so a client that filled both
/// fields — or filled a different one at each step — would fail at the last
/// button press with a message that does not say what went wrong.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const int documentId = 1;
  const String ink = 'iVBORw0KGgoAAAANSUhEUg==';

  const SignerIdentity byEmail = SignerIdentity(
    name: 'Muhammad Ali',
    cnic: '35201-1234567-1',
    destination: 'ali@example.com',
    role: SignerRole.deponent,
  );

  late MockSessionStore session;
  late SignatureRepository repository;

  setUp(() {
    session = MockSessionStore();
    repository = SignatureRepositoryImpl(
      SignatureRemoteDataSourceMock(session),
    );
  });

  group('requesting a code', () {
    test('masks the destination the way the server does', () async {
      final Result<SigningOtp> result = await repository.requestOtp(
        documentId: documentId,
        signer: byEmail,
      );

      final SigningOtp ticket = result.value!;
      expect(ticket.destinationMasked, 'al***@example.com');
      expect(ticket.expiresAt.isAfter(DateTime.now()), isTrue);
    });

    test('a document that is not the user\'s is not found', () async {
      final Result<SigningOtp> result = await repository.requestOtp(
        documentId: 9999,
        signer: byEmail,
      );

      expect(result.value, isNull);
      expect(result.failure, isA<NotFoundFailure>());
    });
  });

  group('signing', () {
    test('files the signature and marks the document signed', () async {
      await repository.requestOtp(documentId: documentId, signer: byEmail);

      final Result<DocumentSignature> result = await repository.sign(
        documentId: documentId,
        signer: byEmail,
        imageBase64: ink,
        otp: AppConfig.demoOtp,
      );

      final DocumentSignature signature = result.value!;
      expect(signature.documentId, documentId);
      expect(signature.signerName, byEmail.name);
      expect(signature.signerCnic, byEmail.cnic);
      expect(signature.signerRole, 'Deponent');
      expect(signature.isOtpVerified, isTrue);
      expect(signature.signatureUri, endsWith('.png'));

      final Map<String, dynamic>? stored = session.document(documentId);
      expect(stored!['status'], 'Signed');
      expect(stored['statusId'], 4);
    });

    test('the recorded signature can be read back', () async {
      await repository.requestOtp(documentId: documentId, signer: byEmail);
      await repository.sign(
        documentId: documentId,
        signer: byEmail,
        imageBase64: ink,
        otp: AppConfig.demoOtp,
      );

      final List<DocumentSignature> signatures =
          (await repository.getSignatures(documentId)).value!;

      expect(signatures, hasLength(1));
      expect(signatures.single.contact, byEmail.destination);
    });

    test('a wrong code is refused', () async {
      await repository.requestOtp(documentId: documentId, signer: byEmail);

      final Result<DocumentSignature> result = await repository.sign(
        documentId: documentId,
        signer: byEmail,
        imageBase64: ink,
        otp: '000000',
      );

      expect(result.value, isNull);
      expect(result.failure, isA<ValidationFailure>());
      expect(
        result.failure!.message,
        contains('No OTP request found for this destination'),
      );
      // Nothing was filed, so the document is still what it was.
      expect(session.document(documentId)!['status'], isNot('Signed'));
    });

    test('blank ink is refused rather than filed as a placeholder', () async {
      await repository.requestOtp(documentId: documentId, signer: byEmail);

      final Result<DocumentSignature> result = await repository.sign(
        documentId: documentId,
        signer: byEmail,
        imageBase64: '',
        otp: AppConfig.demoOtp,
      );

      expect(result.failure, isA<ValidationFailure>());
    });

    test('only the contact the identity names is sent', () async {
      final _RecordingSource recorder = _RecordingSource();
      final SignatureRepository recording = SignatureRepositoryImpl(recorder);

      await recording.sign(
        documentId: documentId,
        signer: byEmail,
        imageBase64: ink,
        otp: AppConfig.demoOtp,
      );

      expect(recorder.signerEmail, 'ali@example.com');
      expect(recorder.signerPhone, isNull);

      await recording.sign(
        documentId: documentId,
        signer: byEmail.copyWith(destination: '03001234567'),
        imageBase64: ink,
        otp: AppConfig.demoOtp,
      );

      expect(recorder.signerEmail, isNull);
      expect(recorder.signerPhone, '03001234567');
    });
  });

  group('a signature that names a different contact', () {
    test(
      'is refused, which is why the identity holds one destination',
      () async {
        await repository.requestOtp(documentId: documentId, signer: byEmail);

        final Result<DocumentSignature> result = await repository.sign(
          documentId: documentId,
          signer: byEmail.copyWith(destination: '03001234567'),
          imageBase64: ink,
          otp: AppConfig.demoOtp,
        );

        expect(result.value, isNull);
        expect(result.failure, isA<ValidationFailure>());
      },
    );
  });
}

/// Records what the repository actually puts on the wire, because the single
/// destination rule is only visible there.
final class _RecordingSource implements SignatureRemoteDataSource {
  String? signerEmail;
  String? signerPhone;

  @override
  Future<SignatureDetailDto> sign({
    required int documentId,
    required String signerName,
    required String signerCnic,
    required String signerRole,
    required String signatureImageBase64,
    required String otp,
    String? signerEmail,
    String? signerPhone,
  }) async {
    this.signerEmail = signerEmail;
    this.signerPhone = signerPhone;
    return SignatureDetailDto(
      signatureId: 1,
      userDocumentId: documentId,
      signerName: signerName,
      signerCnic: signerCnic,
      signerRole: signerRole,
      signatureUri: 'sig_recorded.png',
      isOtpVerified: true,
      signerEmail: signerEmail,
      signerPhone: signerPhone,
      signedAt: DateTime.utc(2026, 9, 7),
    );
  }

  @override
  Future<SigningOtpDto> requestOtp({
    required int documentId,
    required String signerName,
    required String signerCnic,
    required String destination,
  }) => throw UnimplementedError();

  @override
  Future<List<SignatureDetailDto>> getSignatures(int documentId) =>
      throw UnimplementedError();
}
