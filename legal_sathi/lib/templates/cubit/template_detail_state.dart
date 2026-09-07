import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/legal_template.dart';

part 'template_detail_state.freezed.dart';

@freezed
abstract class TemplateDetailState with _$TemplateDetailState {
  const factory TemplateDetailState.loading() = TemplateDetailLoading;

  const factory TemplateDetailState.ready(LegalTemplate template) =
      TemplateDetailReady;

  const factory TemplateDetailState.failure(Failure failure) =
      TemplateDetailFailure;
}
