import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../documents/domain/entities/legal_document.dart';

part 'profile_stats.freezed.dart';

/// Account activity for the profile header.
///
/// The API has no profile-stats endpoint, so these are counted from
/// `GET /Documents` — the same list the Documents tab shows, which is what keeps
/// the two screens from disagreeing about how much the account has done.
///
/// Identity is deliberately absent: it belongs to the session (`AuthCubit`), and
/// a second copy here would only go stale.
@freezed
abstract class ProfileStats with _$ProfileStats {
  const factory ProfileStats({
    @Default(0) int documents,
    @Default(0) int signed,
    @Default(0) int completed,
  }) = _ProfileStats;

  /// "Completed" follows the API's own line — anything past `Draft` has been
  /// rendered — and "signed" counts the statuses where a signature is on file.
  static ProfileStats of(List<LegalDocument> documents) => ProfileStats(
    documents: documents.length,
    signed: documents
        .where((LegalDocument document) => document.status.isSigned)
        .length,
    completed: documents
        .where((LegalDocument document) => document.status.isGenerated)
        .length,
  );
}
