import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../documents/domain/entities/legal_document.dart';
import '../../../templates/domain/entities/legal_template.dart';
import '../../../templates/domain/entities/template_category.dart';

part 'home_feed.freezed.dart';

/// Dashboard payload. Shaped like a single BFF endpoint so the home screen
/// makes one request, not four.
@freezed
abstract class HomeFeed with _$HomeFeed {
  const factory HomeFeed({
    required List<LegalTemplate> featuredTemplates,
    required List<TemplateCategory> categories,
    required List<LegalDocument> recentDocuments,
    required int completedCount,
  }) = _HomeFeed;
}
