import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/legal_template.dart';
import '../domain/usecases/get_template_detail.dart';
import 'template_detail_state.dart';

class TemplateDetailCubit extends Cubit<TemplateDetailState> {
  TemplateDetailCubit(this._getTemplateDetail)
    : super(const TemplateDetailState.loading());

  final GetTemplateDetailUseCase _getTemplateDetail;

  Future<void> load(String slug) async {
    emit(const TemplateDetailState.loading());
    final result = await _getTemplateDetail(slug);
    if (isClosed) return;

    emit(
      result.fold<TemplateDetailState>(
        onSuccess: (LegalTemplate template) =>
            TemplateDetailState.ready(template),
        onFailure: (Failure failure) => TemplateDetailState.failure(failure),
      ),
    );
  }
}
