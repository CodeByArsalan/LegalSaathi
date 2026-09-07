import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/server_date.dart';
import '../../domain/entities/document_status.dart';
import '../../domain/entities/legal_document.dart';

part 'document_summary_dto.freezed.dart';
part 'document_summary_dto.g.dart';

/// Wire shape of one row of `GET /Documents`. Names match the JSON exactly; the
/// entity is where `userDocumentId` becomes `id`.
///
/// A summary carries no answers and no file locations — those come only from
/// `GET /Documents/{id}` — so the entity it produces has empty [answers] and
/// null storage paths.
@freezed
abstract class DocumentSummaryDto with _$DocumentSummaryDto {
  const factory DocumentSummaryDto({
    required int userDocumentId,
    required String documentGuid,
    required int templateId,
    @Default('') String templateTitleEn,
    @Default('') String templateTitleUr,
    @Default('') String title,
    @Default('Draft') String status,
    @Default(1) int statusId,
    @Default(false) bool isPaid,
    @JsonKey(fromJson: ServerDate.required) required DateTime createdAt,
    @JsonKey(fromJson: ServerDate.parse) DateTime? completedAt,
  }) = _DocumentSummaryDto;

  factory DocumentSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$DocumentSummaryDtoFromJson(json);
}

extension DocumentSummaryDtoMapper on DocumentSummaryDto {
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
    completedAt: completedAt,
  );
}
