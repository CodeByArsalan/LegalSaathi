// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signature_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignatureDetailDto {

 int get signatureId; int get userDocumentId; String get signerName; String get signerCnic; String get signerRole; String get signatureUri; bool get isOtpVerified; String? get signerEmail; String? get signerPhone; String? get ipAddress;@JsonKey(fromJson: ServerDate.required) DateTime get signedAt;
/// Create a copy of SignatureDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureDetailDtoCopyWith<SignatureDetailDto> get copyWith => _$SignatureDetailDtoCopyWithImpl<SignatureDetailDto>(this as SignatureDetailDto, _$identity);

  /// Serializes this SignatureDetailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureDetailDto&&(identical(other.signatureId, signatureId) || other.signatureId == signatureId)&&(identical(other.userDocumentId, userDocumentId) || other.userDocumentId == userDocumentId)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerCnic, signerCnic) || other.signerCnic == signerCnic)&&(identical(other.signerRole, signerRole) || other.signerRole == signerRole)&&(identical(other.signatureUri, signatureUri) || other.signatureUri == signatureUri)&&(identical(other.isOtpVerified, isOtpVerified) || other.isOtpVerified == isOtpVerified)&&(identical(other.signerEmail, signerEmail) || other.signerEmail == signerEmail)&&(identical(other.signerPhone, signerPhone) || other.signerPhone == signerPhone)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signatureId,userDocumentId,signerName,signerCnic,signerRole,signatureUri,isOtpVerified,signerEmail,signerPhone,ipAddress,signedAt);

@override
String toString() {
  return 'SignatureDetailDto(signatureId: $signatureId, userDocumentId: $userDocumentId, signerName: $signerName, signerCnic: $signerCnic, signerRole: $signerRole, signatureUri: $signatureUri, isOtpVerified: $isOtpVerified, signerEmail: $signerEmail, signerPhone: $signerPhone, ipAddress: $ipAddress, signedAt: $signedAt)';
}


}

/// @nodoc
abstract mixin class $SignatureDetailDtoCopyWith<$Res>  {
  factory $SignatureDetailDtoCopyWith(SignatureDetailDto value, $Res Function(SignatureDetailDto) _then) = _$SignatureDetailDtoCopyWithImpl;
@useResult
$Res call({
 int signatureId, int userDocumentId, String signerName, String signerCnic, String signerRole, String signatureUri, bool isOtpVerified, String? signerEmail, String? signerPhone, String? ipAddress,@JsonKey(fromJson: ServerDate.required) DateTime signedAt
});




}
/// @nodoc
class _$SignatureDetailDtoCopyWithImpl<$Res>
    implements $SignatureDetailDtoCopyWith<$Res> {
  _$SignatureDetailDtoCopyWithImpl(this._self, this._then);

  final SignatureDetailDto _self;
  final $Res Function(SignatureDetailDto) _then;

/// Create a copy of SignatureDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signatureId = null,Object? userDocumentId = null,Object? signerName = null,Object? signerCnic = null,Object? signerRole = null,Object? signatureUri = null,Object? isOtpVerified = null,Object? signerEmail = freezed,Object? signerPhone = freezed,Object? ipAddress = freezed,Object? signedAt = null,}) {
  return _then(_self.copyWith(
signatureId: null == signatureId ? _self.signatureId : signatureId // ignore: cast_nullable_to_non_nullable
as int,userDocumentId: null == userDocumentId ? _self.userDocumentId : userDocumentId // ignore: cast_nullable_to_non_nullable
as int,signerName: null == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String,signerCnic: null == signerCnic ? _self.signerCnic : signerCnic // ignore: cast_nullable_to_non_nullable
as String,signerRole: null == signerRole ? _self.signerRole : signerRole // ignore: cast_nullable_to_non_nullable
as String,signatureUri: null == signatureUri ? _self.signatureUri : signatureUri // ignore: cast_nullable_to_non_nullable
as String,isOtpVerified: null == isOtpVerified ? _self.isOtpVerified : isOtpVerified // ignore: cast_nullable_to_non_nullable
as bool,signerEmail: freezed == signerEmail ? _self.signerEmail : signerEmail // ignore: cast_nullable_to_non_nullable
as String?,signerPhone: freezed == signerPhone ? _self.signerPhone : signerPhone // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SignatureDetailDto].
extension SignatureDetailDtoPatterns on SignatureDetailDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignatureDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignatureDetailDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignatureDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _SignatureDetailDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignatureDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _SignatureDetailDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int signatureId,  int userDocumentId,  String signerName,  String signerCnic,  String signerRole,  String signatureUri,  bool isOtpVerified,  String? signerEmail,  String? signerPhone,  String? ipAddress, @JsonKey(fromJson: ServerDate.required)  DateTime signedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignatureDetailDto() when $default != null:
return $default(_that.signatureId,_that.userDocumentId,_that.signerName,_that.signerCnic,_that.signerRole,_that.signatureUri,_that.isOtpVerified,_that.signerEmail,_that.signerPhone,_that.ipAddress,_that.signedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int signatureId,  int userDocumentId,  String signerName,  String signerCnic,  String signerRole,  String signatureUri,  bool isOtpVerified,  String? signerEmail,  String? signerPhone,  String? ipAddress, @JsonKey(fromJson: ServerDate.required)  DateTime signedAt)  $default,) {final _that = this;
switch (_that) {
case _SignatureDetailDto():
return $default(_that.signatureId,_that.userDocumentId,_that.signerName,_that.signerCnic,_that.signerRole,_that.signatureUri,_that.isOtpVerified,_that.signerEmail,_that.signerPhone,_that.ipAddress,_that.signedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int signatureId,  int userDocumentId,  String signerName,  String signerCnic,  String signerRole,  String signatureUri,  bool isOtpVerified,  String? signerEmail,  String? signerPhone,  String? ipAddress, @JsonKey(fromJson: ServerDate.required)  DateTime signedAt)?  $default,) {final _that = this;
switch (_that) {
case _SignatureDetailDto() when $default != null:
return $default(_that.signatureId,_that.userDocumentId,_that.signerName,_that.signerCnic,_that.signerRole,_that.signatureUri,_that.isOtpVerified,_that.signerEmail,_that.signerPhone,_that.ipAddress,_that.signedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignatureDetailDto implements SignatureDetailDto {
  const _SignatureDetailDto({required this.signatureId, required this.userDocumentId, this.signerName = '', this.signerCnic = '', this.signerRole = '', this.signatureUri = '', this.isOtpVerified = false, this.signerEmail, this.signerPhone, this.ipAddress, @JsonKey(fromJson: ServerDate.required) required this.signedAt});
  factory _SignatureDetailDto.fromJson(Map<String, dynamic> json) => _$SignatureDetailDtoFromJson(json);

@override final  int signatureId;
@override final  int userDocumentId;
@override@JsonKey() final  String signerName;
@override@JsonKey() final  String signerCnic;
@override@JsonKey() final  String signerRole;
@override@JsonKey() final  String signatureUri;
@override@JsonKey() final  bool isOtpVerified;
@override final  String? signerEmail;
@override final  String? signerPhone;
@override final  String? ipAddress;
@override@JsonKey(fromJson: ServerDate.required) final  DateTime signedAt;

/// Create a copy of SignatureDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureDetailDtoCopyWith<_SignatureDetailDto> get copyWith => __$SignatureDetailDtoCopyWithImpl<_SignatureDetailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignatureDetailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignatureDetailDto&&(identical(other.signatureId, signatureId) || other.signatureId == signatureId)&&(identical(other.userDocumentId, userDocumentId) || other.userDocumentId == userDocumentId)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerCnic, signerCnic) || other.signerCnic == signerCnic)&&(identical(other.signerRole, signerRole) || other.signerRole == signerRole)&&(identical(other.signatureUri, signatureUri) || other.signatureUri == signatureUri)&&(identical(other.isOtpVerified, isOtpVerified) || other.isOtpVerified == isOtpVerified)&&(identical(other.signerEmail, signerEmail) || other.signerEmail == signerEmail)&&(identical(other.signerPhone, signerPhone) || other.signerPhone == signerPhone)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signatureId,userDocumentId,signerName,signerCnic,signerRole,signatureUri,isOtpVerified,signerEmail,signerPhone,ipAddress,signedAt);

@override
String toString() {
  return 'SignatureDetailDto(signatureId: $signatureId, userDocumentId: $userDocumentId, signerName: $signerName, signerCnic: $signerCnic, signerRole: $signerRole, signatureUri: $signatureUri, isOtpVerified: $isOtpVerified, signerEmail: $signerEmail, signerPhone: $signerPhone, ipAddress: $ipAddress, signedAt: $signedAt)';
}


}

/// @nodoc
abstract mixin class _$SignatureDetailDtoCopyWith<$Res> implements $SignatureDetailDtoCopyWith<$Res> {
  factory _$SignatureDetailDtoCopyWith(_SignatureDetailDto value, $Res Function(_SignatureDetailDto) _then) = __$SignatureDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 int signatureId, int userDocumentId, String signerName, String signerCnic, String signerRole, String signatureUri, bool isOtpVerified, String? signerEmail, String? signerPhone, String? ipAddress,@JsonKey(fromJson: ServerDate.required) DateTime signedAt
});




}
/// @nodoc
class __$SignatureDetailDtoCopyWithImpl<$Res>
    implements _$SignatureDetailDtoCopyWith<$Res> {
  __$SignatureDetailDtoCopyWithImpl(this._self, this._then);

  final _SignatureDetailDto _self;
  final $Res Function(_SignatureDetailDto) _then;

/// Create a copy of SignatureDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signatureId = null,Object? userDocumentId = null,Object? signerName = null,Object? signerCnic = null,Object? signerRole = null,Object? signatureUri = null,Object? isOtpVerified = null,Object? signerEmail = freezed,Object? signerPhone = freezed,Object? ipAddress = freezed,Object? signedAt = null,}) {
  return _then(_SignatureDetailDto(
signatureId: null == signatureId ? _self.signatureId : signatureId // ignore: cast_nullable_to_non_nullable
as int,userDocumentId: null == userDocumentId ? _self.userDocumentId : userDocumentId // ignore: cast_nullable_to_non_nullable
as int,signerName: null == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String,signerCnic: null == signerCnic ? _self.signerCnic : signerCnic // ignore: cast_nullable_to_non_nullable
as String,signerRole: null == signerRole ? _self.signerRole : signerRole // ignore: cast_nullable_to_non_nullable
as String,signatureUri: null == signatureUri ? _self.signatureUri : signatureUri // ignore: cast_nullable_to_non_nullable
as String,isOtpVerified: null == isOtpVerified ? _self.isOtpVerified : isOtpVerified // ignore: cast_nullable_to_non_nullable
as bool,signerEmail: freezed == signerEmail ? _self.signerEmail : signerEmail // ignore: cast_nullable_to_non_nullable
as String?,signerPhone: freezed == signerPhone ? _self.signerPhone : signerPhone // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
