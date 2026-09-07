// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState()';
}


}

/// @nodoc
class $ProfileStateCopyWith<$Res>  {
$ProfileStateCopyWith(ProfileState _, $Res Function(ProfileState) __);
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileLoading value)?  loading,TResult Function( ProfileReady value)?  ready,TResult Function( ProfileFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileLoading() when loading != null:
return loading(_that);case ProfileReady() when ready != null:
return ready(_that);case ProfileFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileLoading value)  loading,required TResult Function( ProfileReady value)  ready,required TResult Function( ProfileFailure value)  failure,}){
final _that = this;
switch (_that) {
case ProfileLoading():
return loading(_that);case ProfileReady():
return ready(_that);case ProfileFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileLoading value)?  loading,TResult? Function( ProfileReady value)?  ready,TResult? Function( ProfileFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ProfileLoading() when loading != null:
return loading(_that);case ProfileReady() when ready != null:
return ready(_that);case ProfileFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( ProfileStats stats)?  ready,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileLoading() when loading != null:
return loading();case ProfileReady() when ready != null:
return ready(_that.stats);case ProfileFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( ProfileStats stats)  ready,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ProfileLoading():
return loading();case ProfileReady():
return ready(_that.stats);case ProfileFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( ProfileStats stats)?  ready,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ProfileLoading() when loading != null:
return loading();case ProfileReady() when ready != null:
return ready(_that.stats);case ProfileFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ProfileLoading implements ProfileState {
  const ProfileLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.loading()';
}


}




/// @nodoc


class ProfileReady implements ProfileState {
  const ProfileReady(this.stats);
  

 final  ProfileStats stats;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileReadyCopyWith<ProfileReady> get copyWith => _$ProfileReadyCopyWithImpl<ProfileReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileReady&&(identical(other.stats, stats) || other.stats == stats));
}


@override
int get hashCode => Object.hash(runtimeType,stats);

@override
String toString() {
  return 'ProfileState.ready(stats: $stats)';
}


}

/// @nodoc
abstract mixin class $ProfileReadyCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileReadyCopyWith(ProfileReady value, $Res Function(ProfileReady) _then) = _$ProfileReadyCopyWithImpl;
@useResult
$Res call({
 ProfileStats stats
});


$ProfileStatsCopyWith<$Res> get stats;

}
/// @nodoc
class _$ProfileReadyCopyWithImpl<$Res>
    implements $ProfileReadyCopyWith<$Res> {
  _$ProfileReadyCopyWithImpl(this._self, this._then);

  final ProfileReady _self;
  final $Res Function(ProfileReady) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stats = null,}) {
  return _then(ProfileReady(
null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ProfileStats,
  ));
}

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileStatsCopyWith<$Res> get stats {
  
  return $ProfileStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}

/// @nodoc


class ProfileFailure implements ProfileState {
  const ProfileFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileFailureCopyWith<ProfileFailure> get copyWith => _$ProfileFailureCopyWithImpl<ProfileFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ProfileState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ProfileFailureCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileFailureCopyWith(ProfileFailure value, $Res Function(ProfileFailure) _then) = _$ProfileFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ProfileFailureCopyWithImpl<$Res>
    implements $ProfileFailureCopyWith<$Res> {
  _$ProfileFailureCopyWithImpl(this._self, this._then);

  final ProfileFailure _self;
  final $Res Function(ProfileFailure) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ProfileFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
