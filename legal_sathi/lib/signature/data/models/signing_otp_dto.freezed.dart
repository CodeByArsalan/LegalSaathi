// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signing_otp_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SigningOtpDto {

 String get destinationMasked;@JsonKey(fromJson: ServerDate.required) DateTime get expiresAt;
/// Create a copy of SigningOtpDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SigningOtpDtoCopyWith<SigningOtpDto> get copyWith => _$SigningOtpDtoCopyWithImpl<SigningOtpDto>(this as SigningOtpDto, _$identity);

  /// Serializes this SigningOtpDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SigningOtpDto&&(identical(other.destinationMasked, destinationMasked) || other.destinationMasked == destinationMasked)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,destinationMasked,expiresAt);

@override
String toString() {
  return 'SigningOtpDto(destinationMasked: $destinationMasked, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $SigningOtpDtoCopyWith<$Res>  {
  factory $SigningOtpDtoCopyWith(SigningOtpDto value, $Res Function(SigningOtpDto) _then) = _$SigningOtpDtoCopyWithImpl;
@useResult
$Res call({
 String destinationMasked,@JsonKey(fromJson: ServerDate.required) DateTime expiresAt
});




}
/// @nodoc
class _$SigningOtpDtoCopyWithImpl<$Res>
    implements $SigningOtpDtoCopyWith<$Res> {
  _$SigningOtpDtoCopyWithImpl(this._self, this._then);

  final SigningOtpDto _self;
  final $Res Function(SigningOtpDto) _then;

/// Create a copy of SigningOtpDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? destinationMasked = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
destinationMasked: null == destinationMasked ? _self.destinationMasked : destinationMasked // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SigningOtpDto].
extension SigningOtpDtoPatterns on SigningOtpDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SigningOtpDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SigningOtpDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SigningOtpDto value)  $default,){
final _that = this;
switch (_that) {
case _SigningOtpDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SigningOtpDto value)?  $default,){
final _that = this;
switch (_that) {
case _SigningOtpDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String destinationMasked, @JsonKey(fromJson: ServerDate.required)  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SigningOtpDto() when $default != null:
return $default(_that.destinationMasked,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String destinationMasked, @JsonKey(fromJson: ServerDate.required)  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _SigningOtpDto():
return $default(_that.destinationMasked,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String destinationMasked, @JsonKey(fromJson: ServerDate.required)  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _SigningOtpDto() when $default != null:
return $default(_that.destinationMasked,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SigningOtpDto implements SigningOtpDto {
  const _SigningOtpDto({this.destinationMasked = '', @JsonKey(fromJson: ServerDate.required) required this.expiresAt});
  factory _SigningOtpDto.fromJson(Map<String, dynamic> json) => _$SigningOtpDtoFromJson(json);

@override@JsonKey() final  String destinationMasked;
@override@JsonKey(fromJson: ServerDate.required) final  DateTime expiresAt;

/// Create a copy of SigningOtpDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SigningOtpDtoCopyWith<_SigningOtpDto> get copyWith => __$SigningOtpDtoCopyWithImpl<_SigningOtpDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SigningOtpDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SigningOtpDto&&(identical(other.destinationMasked, destinationMasked) || other.destinationMasked == destinationMasked)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,destinationMasked,expiresAt);

@override
String toString() {
  return 'SigningOtpDto(destinationMasked: $destinationMasked, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$SigningOtpDtoCopyWith<$Res> implements $SigningOtpDtoCopyWith<$Res> {
  factory _$SigningOtpDtoCopyWith(_SigningOtpDto value, $Res Function(_SigningOtpDto) _then) = __$SigningOtpDtoCopyWithImpl;
@override @useResult
$Res call({
 String destinationMasked,@JsonKey(fromJson: ServerDate.required) DateTime expiresAt
});




}
/// @nodoc
class __$SigningOtpDtoCopyWithImpl<$Res>
    implements _$SigningOtpDtoCopyWith<$Res> {
  __$SigningOtpDtoCopyWithImpl(this._self, this._then);

  final _SigningOtpDto _self;
  final $Res Function(_SigningOtpDto) _then;

/// Create a copy of SigningOtpDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? destinationMasked = null,Object? expiresAt = null,}) {
  return _then(_SigningOtpDto(
destinationMasked: null == destinationMasked ? _self.destinationMasked : destinationMasked // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
