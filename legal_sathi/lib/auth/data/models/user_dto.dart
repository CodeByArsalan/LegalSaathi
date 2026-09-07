import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/app_user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// The persisted shape of [AppUser] in secure storage, so a cold start can
/// rebuild the session without a network call. Not a wire format — the API never
/// returns this exact object.
@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required int id,
    required String email,
    required String fullName,
    required String phoneNumber,
    required bool emailVerified,
    @Default('EndUser') String role,
    String? cnic,
    DateTime? createdAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

extension UserDtoMapper on UserDto {
  AppUser toEntity() => AppUser(
    id: id,
    email: email,
    fullName: fullName,
    phoneNumber: phoneNumber,
    emailVerified: emailVerified,
    role: role,
    cnic: cnic,
    createdAt: createdAt,
  );

  static UserDto fromEntity(AppUser user) => UserDto(
    id: user.id,
    email: user.email,
    fullName: user.fullName,
    phoneNumber: user.phoneNumber,
    emailVerified: user.emailVerified,
    role: user.role,
    cnic: user.cnic,
    createdAt: user.createdAt,
  );
}
