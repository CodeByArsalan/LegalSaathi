import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/server_date.dart';
import '../../domain/entities/app_user.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

/// Wire shape of `UserProfileResponse`, returned by `GET /Auth/me` and
/// `PUT /Auth/profile`. This is the only payload that reports `isEmailVerified`
/// and a creation date. `roleId`, `isActive` and `updatedDateTime` are left out
/// because nothing in the app reads them.
@freezed
abstract class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    required int userId,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String role,
    required bool isEmailVerified,

    /// Naive on the wire (`2026-09-07T08:11:13.6920539`), so it goes through
    /// [ServerDate] rather than the default parser, which would read it as
    /// device-local time.
    @JsonKey(fromJson: ServerDate.parse) DateTime? createdDateTime,
    String? cnic,
  }) = _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);
}

extension UserProfileDtoMapper on UserProfileDto {
  AppUser toEntity() => AppUser(
    id: userId,
    email: email,
    fullName: fullName,
    phoneNumber: phoneNumber,
    emailVerified: isEmailVerified,
    role: role,
    cnic: cnic,
    createdAt: createdDateTime,
  );
}
