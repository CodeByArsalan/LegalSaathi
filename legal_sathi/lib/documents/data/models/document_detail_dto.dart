import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/server_date.dart';
import '../../domain/entities/document_status.dart';
import '../../domain/entities/legal_document.dart';

part 'document_detail_dto.freezed.dart';
part 'document_detail_dto.g.dart';

/// Wire shape of `GET /Documents/{id}`, `POST /Documents` and
/// `PUT /Documents/{id}/answers` — the summary plus the answers, the rendered
/// file locations and the hash.
@freezed
abstract class DocumentDetailDto with _$DocumentDetailDto {
  const factory DocumentDetailDto({
    required int userDocumentId,
    required String documentGuid,
    required int templateId,
    @Default(0) int userId,
    @Default('') String templateTitleEn,
    @Default('') String templateTitleUr,
    @Default('') String title,
    String? formAnswersJson,
    @Default('Draft') String status,
    @Default(1) int statusId,
    @Default(false) bool isPaid,
    @JsonKey(fromJson: ServerDate.required) required DateTime createdAt,
    @JsonKey(fromJson: ServerDate.parse) DateTime? updatedAt,
    @JsonKey(fromJson: ServerDate.parse) DateTime? completedAt,
    String? storagePath,
    String? docxStoragePath,
    String? documentHash,
  }) = _DocumentDetailDto;

  factory DocumentDetailDto.fromJson(Map<String, dynamic> json) =>
      _$DocumentDetailDtoFromJson(json);
}

extension DocumentDetailDtoMapper on DocumentDetailDto {
  LegalDocument toEntity() => LegalDocument(
    id: userDocumentId,
    guid: documentGuid,
    templateId: templateId,
    templateTitleEn: templateTitleEn,
    templateTitleUr: templateTitleUr,
    title: title,
    status: DocumentStatus.resolve(status, statusId),
    isPaid: isPaid,
    createdAt: createdAt,
    answers: parseAnswers(formAnswersJson),
    storagePath: storagePath,
    docxStoragePath: docxStoragePath,
    documentHash: documentHash,
    updatedAt: updatedAt,
    completedAt: completedAt,
  );
}

/// `formAnswersJson` is a JSON object serialised into a string column, so it is
/// decoded a second time here. Anything that is not a flat object of strings —
/// including a null column on a document that has no answers yet — yields no
/// answers rather than a crash.
Map<String, String> parseAnswers(String? raw) {
  final String trimmed = raw?.trim() ?? '';
  if (trimmed.isEmpty) return const <String, String>{};

  try {
    final Object? decoded = jsonDecode(trimmed);
    if (decoded is! Map) return const <String, String>{};
    return decoded.map(
      (dynamic key, dynamic value) =>
          MapEntry<String, String>(key.toString(), value?.toString() ?? ''),
    );
  } on FormatException {
    return const <String, String>{};
  }
}
