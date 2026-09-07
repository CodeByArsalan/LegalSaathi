// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState()';
}


}

/// @nodoc
class $RegisterStateCopyWith<$Res>  {
$RegisterStateCopyWith(RegisterState _, $Res Function(RegisterState) __);
}


/// Adds pattern-matching-related methods to [RegisterState].
extension RegisterStatePatterns on RegisterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RegisterInitial value)?  initial,TResult Function( RegisterSubmitting value)?  submitting,TResult Function( RegisterSuccess value)?  success,TResult Function( RegisterFailureState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RegisterInitial() when initial != null:
return initial(_that);case RegisterSubmitting() when submitting != null:
return submitting(_that);case RegisterSuccess() when success != null:
return success(_that);case RegisterFailureState() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RegisterInitial value)  initial,required TResult Function( RegisterSubmitting value)  submitting,required TResult Function( RegisterSuccess value)  success,required TResult Function( RegisterFailureState value)  failure,}){
final _that = this;
switch (_that) {
case RegisterInitial():
return initial(_that);case RegisterSubmitting():
return submitting(_that);case RegisterSuccess():
return success(_that);case RegisterFailureState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RegisterInitial value)?  initial,TResult? Function( RegisterSubmitting value)?  submitting,TResult? Function( RegisterSuccess value)?  success,TResult? Function( RegisterFailureState value)?  failure,}){
final _that = this;
switch (_that) {
case RegisterInitial() when initial != null:
return initial(_that);case RegisterSubmitting() when submitting != null:
return submitting(_that);case RegisterSuccess() when success != null:
return success(_that);case RegisterFailureState() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  submitting,TResult Function( String email,  String message)?  success,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RegisterInitial() when initial != null:
return initial();case RegisterSubmitting() when submitting != null:
return submitting();case RegisterSuccess() when success != null:
return success(_that.email,_that.message);case RegisterFailureState() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  submitting,required TResult Function( String email,  String message)  success,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case RegisterInitial():
return initial();case RegisterSubmitting():
return submitting();case RegisterSuccess():
return success(_that.email,_that.message);case RegisterFailureState():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  submitting,TResult? Function( String email,  String message)?  success,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case RegisterInitial() when initial != null:
return initial();case RegisterSubmitting() when submitting != null:
return submitting();case RegisterSuccess() when success != null:
return success(_that.email,_that.message);case RegisterFailureState() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class RegisterInitial implements RegisterState {
  const RegisterInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.initial()';
}


}




/// @nodoc


class RegisterSubmitting implements RegisterState {
  const RegisterSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.submitting()';
}


}




/// @nodoc


class RegisterSuccess implements RegisterState {
  const RegisterSuccess({required this.email, required this.message});
  

 final  String email;
 final  String message;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterSuccessCopyWith<RegisterSuccess> get copyWith => _$RegisterSuccessCopyWithImpl<RegisterSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterSuccess&&(identical(other.email, email) || other.email == email)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,email,message);

@override
String toString() {
  return 'RegisterState.success(email: $email, message: $message)';
}


}

/// @nodoc
abstract mixin class $RegisterSuccessCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory $RegisterSuccessCopyWith(RegisterSuccess value, $Res Function(RegisterSuccess) _then) = _$RegisterSuccessCopyWithImpl;
@useResult
$Res call({
 String email, String message
});




}
/// @nodoc
class _$RegisterSuccessCopyWithImpl<$Res>
    implements $RegisterSuccessCopyWith<$Res> {
  _$RegisterSuccessCopyWithImpl(this._self, this._then);

  final RegisterSuccess _self;
  final $Res Function(RegisterSuccess) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? message = null,}) {
  return _then(RegisterSuccess(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterFailureState implements RegisterState {
  const RegisterFailureState(this.failure);
  

 final  Failure failure;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterFailureStateCopyWith<RegisterFailureState> get copyWith => _$RegisterFailureStateCopyWithImpl<RegisterFailureState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterFailureState&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'RegisterState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RegisterFailureStateCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory $RegisterFailureStateCopyWith(RegisterFailureState value, $Res Function(RegisterFailureState) _then) = _$RegisterFailureStateCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$RegisterFailureStateCopyWithImpl<$Res>
    implements $RegisterFailureStateCopyWith<$Res> {
  _$RegisterFailureStateCopyWithImpl(this._self, this._then);

  final RegisterFailureState _self;
  final $Res Function(RegisterFailureState) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(RegisterFailureState(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
