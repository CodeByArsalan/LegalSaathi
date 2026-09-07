import 'package:dio/dio.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_envelope.dart';
import '../models/signature_detail_dto.dart';
import '../models/signing_otp_dto.dart';
import 'signature_remote_data_source.dart';

final class SignatureRemoteDataSourceDio implements SignatureRemoteDataSource {
  SignatureRemoteDataSourceDio(this._dio);

  final Dio _dio;

  @override
  Future<SigningOtpDto> requestOtp({
    required int documentId,
    required String signerName,
    required String signerCnic,
    required String destination,
  }) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.documentSignatureOtp(documentId),
      data: <String, Object>{
        'userDocumentId': documentId,
        'signerName': signerName,
        'signerCnic': signerCnic,
        'destinationPhoneOrEmail': destination,
      },
    );
    return ApiEnvelope.unwrapObject<SigningOtpDto>(
      response,
      SigningOtpDto.fromJson,
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
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.documentSignatures(documentId),
      data: <String, Object>{
        'userDocumentId': documentId,
        'signerName': signerName,
        'signerCnic': signerCnic,
        'signerRole': signerRole,
        'signatureBase64Image': signatureImageBase64,
        // Always sent. An absent code makes the server record the signature as
        // verified without checking anything, so omitting it is never an option.
        'otpCode': otp,
        'signerEmail': ?signerEmail,
        'signerPhone': ?signerPhone,
      },
    );
    return ApiEnvelope.unwrapObject<SignatureDetailDto>(
      response,
      SignatureDetailDto.fromJson,
    );
  }

  @override
  Future<List<SignatureDetailDto>> getSignatures(int documentId) async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      ApiEndpoints.documentSignatures(documentId),
    );
    return ApiEnvelope.unwrapList<SignatureDetailDto>(
      response,
      SignatureDetailDto.fromJson,
    );
  }
}
