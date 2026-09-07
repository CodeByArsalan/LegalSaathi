// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signing_otp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SigningOtp {

 String get destinationMasked; DateTime get expiresAt;
/// Create a copy of SigningOtp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SigningOtpCopyWith<SigningOtp> get copyWith => _$SigningOtpCopyWithImpl<SigningOtp>(this as SigningOtp, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SigningOtp&&(identical(other.destinationMasked, destinationMasked) || other.destinationMasked == destinationMasked)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,destinationMasked,expiresAt);

@override
String toString() {
  return 'SigningOtp(destinationMasked: $destinationMasked, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $SigningOtpCopyWith<$Res>  {
  factory $SigningOtpCopyWith(SigningOtp value, $Res Function(SigningOtp) _then) = _$SigningOtpCopyWithImpl;
@useResult
$Res call({
 String destinationMasked, DateTime expiresAt
});




}
/// @nodoc
class _$SigningOtpCopyWithImpl<$Res>
    implements $SigningOtpCopyWith<$Res> {
  _$SigningOtpCopyWithImpl(this._self, this._then);

  final SigningOtp _self;
  final $Res Function(SigningOtp) _then;

/// Create a copy of SigningOtp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? destinationMasked = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
destinationMasked: null == destinationMasked ? _self.destinationMasked : destinationMasked // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SigningOtp].
extension SigningOtpPatterns on SigningOtp {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SigningOtp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SigningOtp() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SigningOtp value)  $default,){
final _that = this;
switch (_that) {
case _SigningOtp():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SigningOtp value)?  $default,){
final _that = this;
switch (_that) {
case _SigningOtp() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String destinationMasked,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SigningOtp() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String destinationMasked,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _SigningOtp():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String destinationMasked,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _SigningOtp() when $default != null:
return $default(_that.destinationMasked,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _SigningOtp implements SigningOtp {
  const _SigningOtp({required this.destinationMasked, required this.expiresAt});
  

@override final  String destinationMasked;
@override final  DateTime expiresAt;

/// Create a copy of SigningOtp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SigningOtpCopyWith<_SigningOtp> get copyWith => __$SigningOtpCopyWithImpl<_SigningOtp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SigningOtp&&(identical(other.destinationMasked, destinationMasked) || other.destinationMasked == destinationMasked)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,destinationMasked,expiresAt);

@override
String toString() {
  return 'SigningOtp(destinationMasked: $destinationMasked, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$SigningOtpCopyWith<$Res> implements $SigningOtpCopyWith<$Res> {
  factory _$SigningOtpCopyWith(_SigningOtp value, $Res Function(_SigningOtp) _then) = __$SigningOtpCopyWithImpl;
@override @useResult
$Res call({
 String destinationMasked, DateTime expiresAt
});




}
/// @nodoc
class __$SigningOtpCopyWithImpl<$Res>
    implements _$SigningOtpCopyWith<$Res> {
  __$SigningOtpCopyWithImpl(this._self, this._then);

  final _SigningOtp _self;
  final $Res Function(_SigningOtp) _then;

/// Create a copy of SigningOtp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? destinationMasked = null,Object? expiresAt = null,}) {
  return _then(_SigningOtp(
destinationMasked: null == destinationMasked ? _self.destinationMasked : destinationMasked // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
