// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterResponseDto {

 int get userId; String get email; bool get requiresEmailVerification; String get message;
/// Create a copy of RegisterResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterResponseDtoCopyWith<RegisterResponseDto> get copyWith => _$RegisterResponseDtoCopyWithImpl<RegisterResponseDto>(this as RegisterResponseDto, _$identity);

  /// Serializes this RegisterResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterResponseDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.requiresEmailVerification, requiresEmailVerification) || other.requiresEmailVerification == requiresEmailVerification)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,requiresEmailVerification,message);

@override
String toString() {
  return 'RegisterResponseDto(userId: $userId, email: $email, requiresEmailVerification: $requiresEmailVerification, message: $message)';
}


}

/// @nodoc
abstract mixin class $RegisterResponseDtoCopyWith<$Res>  {
  factory $RegisterResponseDtoCopyWith(RegisterResponseDto value, $Res Function(RegisterResponseDto) _then) = _$RegisterResponseDtoCopyWithImpl;
@useResult
$Res call({
 int userId, String email, bool requiresEmailVerification, String message
});




}
/// @nodoc
class _$RegisterResponseDtoCopyWithImpl<$Res>
    implements $RegisterResponseDtoCopyWith<$Res> {
  _$RegisterResponseDtoCopyWithImpl(this._self, this._then);

  final RegisterResponseDto _self;
  final $Res Function(RegisterResponseDto) _then;

/// Create a copy of RegisterResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,Object? requiresEmailVerification = null,Object? message = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,requiresEmailVerification: null == requiresEmailVerification ? _self.requiresEmailVerification : requiresEmailVerification // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterResponseDto].
extension RegisterResponseDtoPatterns on RegisterResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _RegisterResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String email,  bool requiresEmailVerification,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterResponseDto() when $default != null:
return $default(_that.userId,_that.email,_that.requiresEmailVerification,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String email,  bool requiresEmailVerification,  String message)  $default,) {final _that = this;
switch (_that) {
case _RegisterResponseDto():
return $default(_that.userId,_that.email,_that.requiresEmailVerification,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String email,  bool requiresEmailVerification,  String message)?  $default,) {final _that = this;
switch (_that) {
case _RegisterResponseDto() when $default != null:
return $default(_that.userId,_that.email,_that.requiresEmailVerification,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterResponseDto implements RegisterResponseDto {
  const _RegisterResponseDto({required this.userId, required this.email, required this.requiresEmailVerification, required this.message});
  factory _RegisterResponseDto.fromJson(Map<String, dynamic> json) => _$RegisterResponseDtoFromJson(json);

@override final  int userId;
@override final  String email;
@override final  bool requiresEmailVerification;
@override final  String message;

/// Create a copy of RegisterResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterResponseDtoCopyWith<_RegisterResponseDto> get copyWith => __$RegisterResponseDtoCopyWithImpl<_RegisterResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterResponseDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.requiresEmailVerification, requiresEmailVerification) || other.requiresEmailVerification == requiresEmailVerification)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,requiresEmailVerification,message);

@override
String toString() {
  return 'RegisterResponseDto(userId: $userId, email: $email, requiresEmailVerification: $requiresEmailVerification, message: $message)';
}


}

/// @nodoc
abstract mixin class _$RegisterResponseDtoCopyWith<$Res> implements $RegisterResponseDtoCopyWith<$Res> {
  factory _$RegisterResponseDtoCopyWith(_RegisterResponseDto value, $Res Function(_RegisterResponseDto) _then) = __$RegisterResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int userId, String email, bool requiresEmailVerification, String message
});




}
/// @nodoc
class __$RegisterResponseDtoCopyWithImpl<$Res>
    implements _$RegisterResponseDtoCopyWith<$Res> {
  __$RegisterResponseDtoCopyWithImpl(this._self, this._then);

  final _RegisterResponseDto _self;
  final $Res Function(_RegisterResponseDto) _then;

/// Create a copy of RegisterResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,Object? requiresEmailVerification = null,Object? message = null,}) {
  return _then(_RegisterResponseDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,requiresEmailVerification: null == requiresEmailVerification ? _self.requiresEmailVerification : requiresEmailVerification // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
