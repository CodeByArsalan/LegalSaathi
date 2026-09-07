// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signer_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignerIdentity {

 String get name; String get cnic; String get destination; SignerRole get role;
/// Create a copy of SignerIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignerIdentityCopyWith<SignerIdentity> get copyWith => _$SignerIdentityCopyWithImpl<SignerIdentity>(this as SignerIdentity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignerIdentity&&(identical(other.name, name) || other.name == name)&&(identical(other.cnic, cnic) || other.cnic == cnic)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,name,cnic,destination,role);

@override
String toString() {
  return 'SignerIdentity(name: $name, cnic: $cnic, destination: $destination, role: $role)';
}


}

/// @nodoc
abstract mixin class $SignerIdentityCopyWith<$Res>  {
  factory $SignerIdentityCopyWith(SignerIdentity value, $Res Function(SignerIdentity) _then) = _$SignerIdentityCopyWithImpl;
@useResult
$Res call({
 String name, String cnic, String destination, SignerRole role
});




}
/// @nodoc
class _$SignerIdentityCopyWithImpl<$Res>
    implements $SignerIdentityCopyWith<$Res> {
  _$SignerIdentityCopyWithImpl(this._self, this._then);

  final SignerIdentity _self;
  final $Res Function(SignerIdentity) _then;

/// Create a copy of SignerIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? cnic = null,Object? destination = null,Object? role = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cnic: null == cnic ? _self.cnic : cnic // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as SignerRole,
  ));
}

}


/// Adds pattern-matching-related methods to [SignerIdentity].
extension SignerIdentityPatterns on SignerIdentity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignerIdentity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignerIdentity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignerIdentity value)  $default,){
final _that = this;
switch (_that) {
case _SignerIdentity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignerIdentity value)?  $default,){
final _that = this;
switch (_that) {
case _SignerIdentity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String cnic,  String destination,  SignerRole role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignerIdentity() when $default != null:
return $default(_that.name,_that.cnic,_that.destination,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String cnic,  String destination,  SignerRole role)  $default,) {final _that = this;
switch (_that) {
case _SignerIdentity():
return $default(_that.name,_that.cnic,_that.destination,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String cnic,  String destination,  SignerRole role)?  $default,) {final _that = this;
switch (_that) {
case _SignerIdentity() when $default != null:
return $default(_that.name,_that.cnic,_that.destination,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _SignerIdentity implements SignerIdentity {
  const _SignerIdentity({required this.name, required this.cnic, required this.destination, this.role = SignerRole.deponent});
  

@override final  String name;
@override final  String cnic;
@override final  String destination;
@override@JsonKey() final  SignerRole role;

/// Create a copy of SignerIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignerIdentityCopyWith<_SignerIdentity> get copyWith => __$SignerIdentityCopyWithImpl<_SignerIdentity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignerIdentity&&(identical(other.name, name) || other.name == name)&&(identical(other.cnic, cnic) || other.cnic == cnic)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,name,cnic,destination,role);

@override
String toString() {
  return 'SignerIdentity(name: $name, cnic: $cnic, destination: $destination, role: $role)';
}


}

/// @nodoc
abstract mixin class _$SignerIdentityCopyWith<$Res> implements $SignerIdentityCopyWith<$Res> {
  factory _$SignerIdentityCopyWith(_SignerIdentity value, $Res Function(_SignerIdentity) _then) = __$SignerIdentityCopyWithImpl;
@override @useResult
$Res call({
 String name, String cnic, String destination, SignerRole role
});




}
/// @nodoc
class __$SignerIdentityCopyWithImpl<$Res>
    implements _$SignerIdentityCopyWith<$Res> {
  __$SignerIdentityCopyWithImpl(this._self, this._then);

  final _SignerIdentity _self;
  final $Res Function(_SignerIdentity) _then;

/// Create a copy of SignerIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? cnic = null,Object? destination = null,Object? role = null,}) {
  return _then(_SignerIdentity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cnic: null == cnic ? _self.cnic : cnic // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as SignerRole,
  ));
}


}

// dart format on
