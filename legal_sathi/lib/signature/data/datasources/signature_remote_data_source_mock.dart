import '../../../core/config/app_config.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/mock/mock_data_source.dart';
import '../../../core/mock/mock_session_store.dart';
import '../models/signature_detail_dto.dart';
import '../models/signing_otp_dto.dart';
import 'signature_remote_data_source.dart';

/// Stands in for `/Documents/{id}/signatures`.
///
/// It keeps the two rules the real service enforces and that the app has to be
/// built around: a code is only valid for the destination it was sent to, and
/// signing moves the document to `Signed`.
class SignatureRemoteDataSourceMock extends MockDataSource
    implements SignatureRemoteDataSource {
  SignatureRemoteDataSourceMock(this._session);

  final MockSessionStore _session;

  final Map<int, List<SignatureDetailDto>> _byDocument =
      <int, List<SignatureDetailDto>>{};

  /// The contact the last code was sent to, which is the only one a signature
  /// can be verified against.
  String? _codeSentTo;
  int _nextSignatureId = 1;

  static const int _expirySeconds = 300;

  @override
  Future<SigningOtpDto> requestOtp({
    required int documentId,
    required String signerName,
    required String signerCnic,
    required String destination,
  }) async {
    await _ensureSeeded();
    _requireDocument(documentId);

    _codeSentTo = destination;
    return withLatency(
      SigningOtpDto(
        destinationMasked: _mask(destination),
        expiresAt: DateTime.now().add(const Duration(seconds: _expirySeconds)),
      ),
    );
  }

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
    await _ensureSeeded();
    _requireDocument(documentId);

    final String destination = signerPhone ?? signerEmail ?? '';
    if (destination != _codeSentTo || otp.trim() != AppConfig.demoOtp) {
      throw const AppException(
        'No OTP request found for this destination or OTP has expired.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
      );
    }
    if (signatureImageBase64.trim().isEmpty) {
      throw const AppException(
        'Please draw your electronic signature on the canvas.',
        kind: AppExceptionKind.validation,
        statusCode: 400,
      );
    }

    final SignatureDetailDto dto = SignatureDetailDto(
      signatureId: _nextSignatureId++,
      userDocumentId: documentId,
      signerName: signerName,
      signerCnic: signerCnic,
      signerRole: signerRole,
      signatureUri: 'sig_${_newSuffix()}.png',
      isOtpVerified: true,
      signerEmail: signerEmail,
      signerPhone: signerPhone,
      ipAddress: '127.0.0.1',
      signedAt: DateTime.now(),
    );
    (_byDocument[documentId] ??= <SignatureDetailDto>[]).add(dto);
    _markDocumentSigned(documentId);

    return withLatency(dto);
  }

  @override
  Future<List<SignatureDetailDto>> getSignatures(int documentId) async {
    await _ensureSeeded();
    _requireDocument(documentId);
    return withLatency(
      List<SignatureDetailDto>.of(
        _byDocument[documentId] ?? const <SignatureDetailDto>[],
      ),
    );
  }

  /// The server's own masking rule, so demo mode shows what the live one shows.
  static String _mask(String destination) {
    if (destination.contains('@')) {
      final List<String> parts = destination.split('@');
      return parts.first.length > 2
          ? '${parts.first.substring(0, 2)}***@${parts[1]}'
          : '*@${parts[1]}';
    }
    return destination.length > 4
        ? '${destination.substring(0, 3)}****${destination.substring(destination.length - 2)}'
        : '****';
  }

  void _markDocumentSigned(int documentId) {
    final Map<String, dynamic>? row = _session.document(documentId);
    if (row == null) return;
    _session.putDocument(
      Map<String, dynamic>.of(row)
        ..['status'] = 'Signed'
        ..['statusId'] = 4,
    );
  }

  void _requireDocument(int documentId) {
    if (_session.document(documentId) != null) return;
    throw AppException(
      'Document not found or access denied.',
      kind: AppExceptionKind.notFound,
      statusCode: 404,
    );
  }

  /// Seeds only when nothing has been stored yet: the documents source copies the
  /// same rows in and then mutates them, and re-seeding would undo that.
  Future<void> _ensureSeeded() async {
    if (_session.documents.isNotEmpty) return;
    for (final Map<String, dynamic> row in await loadRows(
      AssetPaths.mockDocuments,
    )) {
      _session.putDocument(row);
    }
  }

  String _newSuffix() =>
      DateTime.now().microsecondsSinceEpoch.toRadixString(16).padLeft(16, '0');
}
