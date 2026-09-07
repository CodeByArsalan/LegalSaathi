import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../../documents/domain/entities/legal_document.dart';
import '../../../documents/domain/usecases/get_user_documents.dart';
import '../domain/entities/profile_stats.dart';
import 'profile_state.dart';

/// Counts what the signed-in account has done, for the header on the profile tab.
///
/// Identity is not loaded here: `AuthCubit` already holds it, and reading
/// `GET /Auth/me` again would only risk the two disagreeing.
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getDocuments) : super(const ProfileState.loading());

  final GetUserDocumentsUseCase _getDocuments;

  Future<void> load() async {
    emit(const ProfileState.loading());
    final Result<List<LegalDocument>> result = await _getDocuments();
    if (isClosed) return;

    emit(
      result.fold<ProfileState>(
        onSuccess: (List<LegalDocument> documents) =>
            ProfileState.ready(ProfileStats.of(documents)),
        onFailure: (Failure failure) => ProfileState.failure(failure),
      ),
    );
  }
}
