// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_documents_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyDocumentsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyDocumentsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyDocumentsState()';
}


}

/// @nodoc
class $MyDocumentsStateCopyWith<$Res>  {
$MyDocumentsStateCopyWith(MyDocumentsState _, $Res Function(MyDocumentsState) __);
}


/// Adds pattern-matching-related methods to [MyDocumentsState].
extension MyDocumentsStatePatterns on MyDocumentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MyDocumentsLoading value)?  loading,TResult Function( MyDocumentsReady value)?  ready,TResult Function( MyDocumentsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MyDocumentsLoading() when loading != null:
return loading(_that);case MyDocumentsReady() when ready != null:
return ready(_that);case MyDocumentsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MyDocumentsLoading value)  loading,required TResult Function( MyDocumentsReady value)  ready,required TResult Function( MyDocumentsFailure value)  failure,}){
final _that = this;
switch (_that) {
case MyDocumentsLoading():
return loading(_that);case MyDocumentsReady():
return ready(_that);case MyDocumentsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MyDocumentsLoading value)?  loading,TResult? Function( MyDocumentsReady value)?  ready,TResult? Function( MyDocumentsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case MyDocumentsLoading() when loading != null:
return loading(_that);case MyDocumentsReady() when ready != null:
return ready(_that);case MyDocumentsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<LegalDocument> documents)?  ready,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MyDocumentsLoading() when loading != null:
return loading();case MyDocumentsReady() when ready != null:
return ready(_that.documents);case MyDocumentsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<LegalDocument> documents)  ready,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case MyDocumentsLoading():
return loading();case MyDocumentsReady():
return ready(_that.documents);case MyDocumentsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<LegalDocument> documents)?  ready,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case MyDocumentsLoading() when loading != null:
return loading();case MyDocumentsReady() when ready != null:
return ready(_that.documents);case MyDocumentsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class MyDocumentsLoading implements MyDocumentsState {
  const MyDocumentsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyDocumentsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyDocumentsState.loading()';
}


}




/// @nodoc


class MyDocumentsReady implements MyDocumentsState {
  const MyDocumentsReady(final  List<LegalDocument> documents): _documents = documents;
  

 final  List<LegalDocument> _documents;
 List<LegalDocument> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}


/// Create a copy of MyDocumentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyDocumentsReadyCopyWith<MyDocumentsReady> get copyWith => _$MyDocumentsReadyCopyWithImpl<MyDocumentsReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyDocumentsReady&&const DeepCollectionEquality().equals(other._documents, _documents));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_documents));

@override
String toString() {
  return 'MyDocumentsState.ready(documents: $documents)';
}


}

/// @nodoc
abstract mixin class $MyDocumentsReadyCopyWith<$Res> implements $MyDocumentsStateCopyWith<$Res> {
  factory $MyDocumentsReadyCopyWith(MyDocumentsReady value, $Res Function(MyDocumentsReady) _then) = _$MyDocumentsReadyCopyWithImpl;
@useResult
$Res call({
 List<LegalDocument> documents
});




}
/// @nodoc
class _$MyDocumentsReadyCopyWithImpl<$Res>
    implements $MyDocumentsReadyCopyWith<$Res> {
  _$MyDocumentsReadyCopyWithImpl(this._self, this._then);

  final MyDocumentsReady _self;
  final $Res Function(MyDocumentsReady) _then;

/// Create a copy of MyDocumentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? documents = null,}) {
  return _then(MyDocumentsReady(
null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<LegalDocument>,
  ));
}


}

/// @nodoc


class MyDocumentsFailure implements MyDocumentsState {
  const MyDocumentsFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of MyDocumentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyDocumentsFailureCopyWith<MyDocumentsFailure> get copyWith => _$MyDocumentsFailureCopyWithImpl<MyDocumentsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyDocumentsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'MyDocumentsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $MyDocumentsFailureCopyWith<$Res> implements $MyDocumentsStateCopyWith<$Res> {
  factory $MyDocumentsFailureCopyWith(MyDocumentsFailure value, $Res Function(MyDocumentsFailure) _then) = _$MyDocumentsFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$MyDocumentsFailureCopyWithImpl<$Res>
    implements $MyDocumentsFailureCopyWith<$Res> {
  _$MyDocumentsFailureCopyWithImpl(this._self, this._then);

  final MyDocumentsFailure _self;
  final $Res Function(MyDocumentsFailure) _then;

/// Create a copy of MyDocumentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(MyDocumentsFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
