import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/domain/usecases/update_profile.dart';
import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import 'edit_profile_state.dart';

/// Saves the identity fields `PUT /Auth/profile` accepts.
///
/// The email address is not among them: it is what the account was verified
/// against, so the API takes no request to change it and the screen offers none.
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required UpdateProfileUseCase updateProfile,
    required AuthCubit auth,
  }) : _updateProfile = updateProfile,
       _auth = auth,
       super(const EditProfileState());

  final UpdateProfileUseCase _updateProfile;
  final AuthCubit _auth;

  Future<void> save({
    required String fullName,
    required String phoneNumber,
    String? cnic,
  }) async {
    if (state.isSaving) return;

    emit(state.copyWith(isSaving: true, failure: null));
    final Result<AppUser> result = await _updateProfile(
      fullName: fullName,
      phoneNumber: phoneNumber,
      cnic: cnic,
    );
    if (isClosed) return;

    final AppUser? user = result.value;
    if (user == null) {
      emit(
        state.copyWith(
          isSaving: false,
          failure: result.failure ?? const UnknownFailure(),
        ),
      );
      return;
    }

    // The server answers with the account as it now stands, and the session is
    // where every other screen reads identity from — so it is handed over here
    // and this screen only has to pop.
    _auth.applyUser(user);
    emit(state.copyWith(isSaving: false, saved: true));
  }
}
