import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/server_date.dart';
import '../../domain/entities/document_signature.dart';

part 'signature_detail_dto.freezed.dart';
part 'signature_detail_dto.g.dart';

/// Wire shape of `POST|GET /Documents/{id}/signatures`.
///
/// `signedAt` arrives with no timezone designator on the list route and with a
/// `Z` on the submit route, so it goes through [ServerDate] like every other
/// server timestamp.
@freezed
abstract class SignatureDetailDto with _$SignatureDetailDto {
  const factory SignatureDetailDto({
    required int signatureId,
    required int userDocumentId,
    @Default('') String signerName,
    @Default('') String signerCnic,
    @Default('') String signerRole,
    @Default('') String signatureUri,
    @Default(false) bool isOtpVerified,
    String? signerEmail,
    String? signerPhone,
    String? ipAddress,
    @JsonKey(fromJson: ServerDate.required) required DateTime signedAt,
  }) = _SignatureDetailDto;

  factory SignatureDetailDto.fromJson(Map<String, dynamic> json) =>
      _$SignatureDetailDtoFromJson(json);
}

extension SignatureDetailDtoMapper on SignatureDetailDto {
  DocumentSignature toEntity() => DocumentSignature(
    id: signatureId,
    documentId: userDocumentId,
    signerName: signerName,
    signerCnic: signerCnic,
    signerRole: signerRole,
    signatureUri: signatureUri,
    isOtpVerified: isOtpVerified,
    signedAt: signedAt,
    signerEmail: signerEmail,
    signerPhone: signerPhone,
    ipAddress: ipAddress,
  );
}
