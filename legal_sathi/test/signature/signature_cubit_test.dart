import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/config/app_config.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/mock/mock_session_store.dart';
import 'package:legal_sathi/signature/cubit/signature_cubit.dart';
import 'package:legal_sathi/signature/cubit/signature_state.dart';
import 'package:legal_sathi/signature/data/datasources/signature_remote_data_source_mock.dart';
import 'package:legal_sathi/signature/data/repositories/signature_repository_impl.dart';
import 'package:legal_sathi/signature/domain/entities/signer_identity.dart';
import 'package:legal_sathi/signature/domain/repositories/signature_repository.dart';
import 'package:legal_sathi/signature/domain/usecases/request_signing_otp.dart';
import 'package:legal_sathi/signature/domain/usecases/sign_document.dart';

/// The cubit owns the two things the flow cannot afford to lose between its
/// steps: the captured ink, which the pad can no longer supply once the verify
/// step replaces it, and the contact the code was issued to.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const int documentId = 1;
  const String ink = 'iVBORw0KGgoAAAANSUhEUg==';

  const SignerIdentity signer = SignerIdentity(
    name: 'Muhammad Ali',
    cnic: '35201-1234567-1',
    destination: 'ali@example.com',
  );

  late SignatureCubit cubit;

  SignatureCubit build({int id = documentId}) {
    final SignatureRepository repository = SignatureRepositoryImpl(
      SignatureRemoteDataSourceMock(MockSessionStore()),
    );
    return SignatureCubit(
      requestOtp: RequestSigningOtpUseCase(repository),
      signDocument: SignDocumentUseCase(repository),
      documentId: id,
    );
  }

  setUp(() => cubit = build());
  tearDown(() async => cubit.close());

  test('opens on the pad with nothing to submit yet', () {
    expect(cubit.state.step, SignatureStep.capture);
    expect(cubit.state.documentId, documentId);
    expect(cubit.state.signer, isNull);
    expect(cubit.state.ticket, isNull);
    expect(cubit.state.isBusy, isFalse);
  });

  test(
    'a code moves on to the verify step with the masked destination',
    () async {
      await cubit.sendCode(signer: signer, imageBase64: ink);

      final SignatureState state = cubit.state;
      expect(state.step, SignatureStep.verify);
      expect(state.failure, isNull);
      expect(state.ticket?.destinationMasked, 'al***@example.com');
      // The identity travels with the state so the signature cannot name another.
      expect(state.signer, signer);
    },
  );

  test('a refused code stays on the pad and says why', () async {
    await cubit.close();
    cubit = build(id: 9999);

    await cubit.sendCode(signer: signer, imageBase64: ink);

    expect(cubit.state.step, SignatureStep.capture);
    expect(cubit.state.isSendingCode, isFalse);
    expect(cubit.state.failure, isA<NotFoundFailure>());
  });

  test('the code signs the document', () async {
    await cubit.sendCode(signer: signer, imageBase64: ink);

    await cubit.sign(AppConfig.demoOtp);

    expect(cubit.state.failure, isNull);
    expect(cubit.state.isSigning, isFalse);
    expect(cubit.state.signed?.documentId, documentId);
    expect(cubit.state.signed?.signerName, signer.name);
    expect(cubit.state.signed?.isOtpVerified, isTrue);
  });

  test('a wrong code reports the failure and keeps the step', () async {
    await cubit.sendCode(signer: signer, imageBase64: ink);

    await cubit.sign('000000');

    expect(cubit.state.signed, isNull);
    expect(cubit.state.failure, isA<ValidationFailure>());
    expect(cubit.state.step, SignatureStep.verify);
  });

  test('there is nothing to file before a code was requested', () async {
    await cubit.sign(AppConfig.demoOtp);

    expect(cubit.state.signed, isNull);
    expect(cubit.state.failure, isNull);
    expect(cubit.state.step, SignatureStep.capture);
  });

  test(
    'going back to the pad keeps the ink, so a new code costs no redraw',
    () async {
      await cubit.sendCode(signer: signer, imageBase64: ink);

      cubit.backToCapture();
      expect(cubit.state.step, SignatureStep.capture);
      expect(cubit.state.signer, signer);

      // The pad is what the user sees again, but the ink already taken is what
      // gets filed: `resendCode` has nothing left to export.
      await cubit.resendCode();
      expect(cubit.state.step, SignatureStep.verify);

      await cubit.sign(AppConfig.demoOtp);
      expect(cubit.state.signed?.documentId, documentId);
    },
  );
}
