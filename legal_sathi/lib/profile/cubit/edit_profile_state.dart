import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';

part 'edit_profile_state.freezed.dart';

/// [saved] is the signal the screen navigates on: the write landed and the
/// session already carries the new identity, so there is nothing left here to
/// look at.
@freezed
abstract class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    @Default(false) bool isSaving,
    @Default(false) bool saved,
    Failure? failure,
  }) = _EditProfileState;
}
