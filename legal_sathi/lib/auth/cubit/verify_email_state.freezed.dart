// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_email_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyEmailState {

 String get email;
/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyEmailStateCopyWith<VerifyEmailState> get copyWith => _$VerifyEmailStateCopyWithImpl<VerifyEmailState>(this as VerifyEmailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyEmailState&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'VerifyEmailState(email: $email)';
}


}

/// @nodoc
abstract mixin class $VerifyEmailStateCopyWith<$Res>  {
  factory $VerifyEmailStateCopyWith(VerifyEmailState value, $Res Function(VerifyEmailState) _then) = _$VerifyEmailStateCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$VerifyEmailStateCopyWithImpl<$Res>
    implements $VerifyEmailStateCopyWith<$Res> {
  _$VerifyEmailStateCopyWithImpl(this._self, this._then);

  final VerifyEmailState _self;
  final $Res Function(VerifyEmailState) _then;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyEmailState].
extension VerifyEmailStatePatterns on VerifyEmailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VerifyEmailInitial value)?  initial,TResult Function( VerifyEmailSubmitting value)?  submitting,TResult Function( VerifyEmailCodeSent value)?  codeSent,TResult Function( VerifyEmailVerified value)?  verified,TResult Function( VerifyEmailFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VerifyEmailInitial() when initial != null:
return initial(_that);case VerifyEmailSubmitting() when submitting != null:
return submitting(_that);case VerifyEmailCodeSent() when codeSent != null:
return codeSent(_that);case VerifyEmailVerified() when verified != null:
return verified(_that);case VerifyEmailFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VerifyEmailInitial value)  initial,required TResult Function( VerifyEmailSubmitting value)  submitting,required TResult Function( VerifyEmailCodeSent value)  codeSent,required TResult Function( VerifyEmailVerified value)  verified,required TResult Function( VerifyEmailFailure value)  failure,}){
final _that = this;
switch (_that) {
case VerifyEmailInitial():
return initial(_that);case VerifyEmailSubmitting():
return submitting(_that);case VerifyEmailCodeSent():
return codeSent(_that);case VerifyEmailVerified():
return verified(_that);case VerifyEmailFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VerifyEmailInitial value)?  initial,TResult? Function( VerifyEmailSubmitting value)?  submitting,TResult? Function( VerifyEmailCodeSent value)?  codeSent,TResult? Function( VerifyEmailVerified value)?  verified,TResult? Function( VerifyEmailFailure value)?  failure,}){
final _that = this;
switch (_that) {
case VerifyEmailInitial() when initial != null:
return initial(_that);case VerifyEmailSubmitting() when submitting != null:
return submitting(_that);case VerifyEmailCodeSent() when codeSent != null:
return codeSent(_that);case VerifyEmailVerified() when verified != null:
return verified(_that);case VerifyEmailFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email)?  initial,TResult Function( String email)?  submitting,TResult Function( String email,  String message)?  codeSent,TResult Function( String email)?  verified,TResult Function( String email,  Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VerifyEmailInitial() when initial != null:
return initial(_that.email);case VerifyEmailSubmitting() when submitting != null:
return submitting(_that.email);case VerifyEmailCodeSent() when codeSent != null:
return codeSent(_that.email,_that.message);case VerifyEmailVerified() when verified != null:
return verified(_that.email);case VerifyEmailFailure() when failure != null:
return failure(_that.email,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email)  initial,required TResult Function( String email)  submitting,required TResult Function( String email,  String message)  codeSent,required TResult Function( String email)  verified,required TResult Function( String email,  Failure failure)  failure,}) {final _that = this;
switch (_that) {
case VerifyEmailInitial():
return initial(_that.email);case VerifyEmailSubmitting():
return submitting(_that.email);case VerifyEmailCodeSent():
return codeSent(_that.email,_that.message);case VerifyEmailVerified():
return verified(_that.email);case VerifyEmailFailure():
return failure(_that.email,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email)?  initial,TResult? Function( String email)?  submitting,TResult? Function( String email,  String message)?  codeSent,TResult? Function( String email)?  verified,TResult? Function( String email,  Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case VerifyEmailInitial() when initial != null:
return initial(_that.email);case VerifyEmailSubmitting() when submitting != null:
return submitting(_that.email);case VerifyEmailCodeSent() when codeSent != null:
return codeSent(_that.email,_that.message);case VerifyEmailVerified() when verified != null:
return verified(_that.email);case VerifyEmailFailure() when failure != null:
return failure(_that.email,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class VerifyEmailInitial implements VerifyEmailState {
  const VerifyEmailInitial({required this.email});
  

@override final  String email;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyEmailInitialCopyWith<VerifyEmailInitial> get copyWith => _$VerifyEmailInitialCopyWithImpl<VerifyEmailInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyEmailInitial&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'VerifyEmailState.initial(email: $email)';
}


}

/// @nodoc
abstract mixin class $VerifyEmailInitialCopyWith<$Res> implements $VerifyEmailStateCopyWith<$Res> {
  factory $VerifyEmailInitialCopyWith(VerifyEmailInitial value, $Res Function(VerifyEmailInitial) _then) = _$VerifyEmailInitialCopyWithImpl;
@override @useResult
$Res call({
 String email
});




}
/// @nodoc
class _$VerifyEmailInitialCopyWithImpl<$Res>
    implements $VerifyEmailInitialCopyWith<$Res> {
  _$VerifyEmailInitialCopyWithImpl(this._self, this._then);

  final VerifyEmailInitial _self;
  final $Res Function(VerifyEmailInitial) _then;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(VerifyEmailInitial(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VerifyEmailSubmitting implements VerifyEmailState {
  const VerifyEmailSubmitting({required this.email});
  

@override final  String email;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyEmailSubmittingCopyWith<VerifyEmailSubmitting> get copyWith => _$VerifyEmailSubmittingCopyWithImpl<VerifyEmailSubmitting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyEmailSubmitting&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'VerifyEmailState.submitting(email: $email)';
}


}

/// @nodoc
abstract mixin class $VerifyEmailSubmittingCopyWith<$Res> implements $VerifyEmailStateCopyWith<$Res> {
  factory $VerifyEmailSubmittingCopyWith(VerifyEmailSubmitting value, $Res Function(VerifyEmailSubmitting) _then) = _$VerifyEmailSubmittingCopyWithImpl;
@override @useResult
$Res call({
 String email
});




}
/// @nodoc
class _$VerifyEmailSubmittingCopyWithImpl<$Res>
    implements $VerifyEmailSubmittingCopyWith<$Res> {
  _$VerifyEmailSubmittingCopyWithImpl(this._self, this._then);

  final VerifyEmailSubmitting _self;
  final $Res Function(VerifyEmailSubmitting) _then;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(VerifyEmailSubmitting(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VerifyEmailCodeSent implements VerifyEmailState {
  const VerifyEmailCodeSent({required this.email, required this.message});
  

@override final  String email;
 final  String message;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyEmailCodeSentCopyWith<VerifyEmailCodeSent> get copyWith => _$VerifyEmailCodeSentCopyWithImpl<VerifyEmailCodeSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyEmailCodeSent&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,email,message);

@override
String toString() {
  return 'VerifyEmailState.codeSent(email: $email, message: $message)';
}


}

/// @nodoc
abstract mixin class $VerifyEmailCodeSentCopyWith<$Res> implements $VerifyEmailStateCopyWith<$Res> {
  factory $VerifyEmailCodeSentCopyWith(VerifyEmailCodeSent value, $Res Function(VerifyEmailCodeSent) _then) = _$VerifyEmailCodeSentCopyWithImpl;
@override @useResult
$Res call({
 String email, String message
});




}
/// @nodoc
class _$VerifyEmailCodeSentCopyWithImpl<$Res>
    implements $VerifyEmailCodeSentCopyWith<$Res> {
  _$VerifyEmailCodeSentCopyWithImpl(this._self, this._then);

  final VerifyEmailCodeSent _self;
  final $Res Function(VerifyEmailCodeSent) _then;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? message = null,}) {
  return _then(VerifyEmailCodeSent(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VerifyEmailVerified implements VerifyEmailState {
  const VerifyEmailVerified({required this.email});
  

@override final  String email;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyEmailVerifiedCopyWith<VerifyEmailVerified> get copyWith => _$VerifyEmailVerifiedCopyWithImpl<VerifyEmailVerified>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyEmailVerified&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'VerifyEmailState.verified(email: $email)';
}


}

/// @nodoc
abstract mixin class $VerifyEmailVerifiedCopyWith<$Res> implements $VerifyEmailStateCopyWith<$Res> {
  factory $VerifyEmailVerifiedCopyWith(VerifyEmailVerified value, $Res Function(VerifyEmailVerified) _then) = _$VerifyEmailVerifiedCopyWithImpl;
@override @useResult
$Res call({
 String email
});




}
/// @nodoc
class _$VerifyEmailVerifiedCopyWithImpl<$Res>
    implements $VerifyEmailVerifiedCopyWith<$Res> {
  _$VerifyEmailVerifiedCopyWithImpl(this._self, this._then);

  final VerifyEmailVerified _self;
  final $Res Function(VerifyEmailVerified) _then;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(VerifyEmailVerified(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VerifyEmailFailure implements VerifyEmailState {
  const VerifyEmailFailure({required this.email, required this.failure});
  

@override final  String email;
 final  Failure failure;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyEmailFailureCopyWith<VerifyEmailFailure> get copyWith => _$VerifyEmailFailureCopyWithImpl<VerifyEmailFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyEmailFailure&&(identical(other.email, email) || other.email == email)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,email,failure);

@override
String toString() {
  return 'VerifyEmailState.failure(email: $email, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $VerifyEmailFailureCopyWith<$Res> implements $VerifyEmailStateCopyWith<$Res> {
  factory $VerifyEmailFailureCopyWith(VerifyEmailFailure value, $Res Function(VerifyEmailFailure) _then) = _$VerifyEmailFailureCopyWithImpl;
@override @useResult
$Res call({
 String email, Failure failure
});




}
/// @nodoc
class _$VerifyEmailFailureCopyWithImpl<$Res>
    implements $VerifyEmailFailureCopyWith<$Res> {
  _$VerifyEmailFailureCopyWithImpl(this._self, this._then);

  final VerifyEmailFailure _self;
  final $Res Function(VerifyEmailFailure) _then;

/// Create a copy of VerifyEmailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? failure = null,}) {
  return _then(VerifyEmailFailure(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
