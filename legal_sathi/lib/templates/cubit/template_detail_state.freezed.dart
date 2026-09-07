// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TemplateDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TemplateDetailState()';
}


}

/// @nodoc
class $TemplateDetailStateCopyWith<$Res>  {
$TemplateDetailStateCopyWith(TemplateDetailState _, $Res Function(TemplateDetailState) __);
}


/// Adds pattern-matching-related methods to [TemplateDetailState].
extension TemplateDetailStatePatterns on TemplateDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TemplateDetailLoading value)?  loading,TResult Function( TemplateDetailReady value)?  ready,TResult Function( TemplateDetailFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TemplateDetailLoading() when loading != null:
return loading(_that);case TemplateDetailReady() when ready != null:
return ready(_that);case TemplateDetailFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TemplateDetailLoading value)  loading,required TResult Function( TemplateDetailReady value)  ready,required TResult Function( TemplateDetailFailure value)  failure,}){
final _that = this;
switch (_that) {
case TemplateDetailLoading():
return loading(_that);case TemplateDetailReady():
return ready(_that);case TemplateDetailFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TemplateDetailLoading value)?  loading,TResult? Function( TemplateDetailReady value)?  ready,TResult? Function( TemplateDetailFailure value)?  failure,}){
final _that = this;
switch (_that) {
case TemplateDetailLoading() when loading != null:
return loading(_that);case TemplateDetailReady() when ready != null:
return ready(_that);case TemplateDetailFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( LegalTemplate template)?  ready,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TemplateDetailLoading() when loading != null:
return loading();case TemplateDetailReady() when ready != null:
return ready(_that.template);case TemplateDetailFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( LegalTemplate template)  ready,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case TemplateDetailLoading():
return loading();case TemplateDetailReady():
return ready(_that.template);case TemplateDetailFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( LegalTemplate template)?  ready,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case TemplateDetailLoading() when loading != null:
return loading();case TemplateDetailReady() when ready != null:
return ready(_that.template);case TemplateDetailFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class TemplateDetailLoading implements TemplateDetailState {
  const TemplateDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TemplateDetailState.loading()';
}


}




/// @nodoc


class TemplateDetailReady implements TemplateDetailState {
  const TemplateDetailReady(this.template);
  

 final  LegalTemplate template;

/// Create a copy of TemplateDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateDetailReadyCopyWith<TemplateDetailReady> get copyWith => _$TemplateDetailReadyCopyWithImpl<TemplateDetailReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateDetailReady&&(identical(other.template, template) || other.template == template));
}


@override
int get hashCode => Object.hash(runtimeType,template);

@override
String toString() {
  return 'TemplateDetailState.ready(template: $template)';
}


}

/// @nodoc
abstract mixin class $TemplateDetailReadyCopyWith<$Res> implements $TemplateDetailStateCopyWith<$Res> {
  factory $TemplateDetailReadyCopyWith(TemplateDetailReady value, $Res Function(TemplateDetailReady) _then) = _$TemplateDetailReadyCopyWithImpl;
@useResult
$Res call({
 LegalTemplate template
});


$LegalTemplateCopyWith<$Res> get template;

}
/// @nodoc
class _$TemplateDetailReadyCopyWithImpl<$Res>
    implements $TemplateDetailReadyCopyWith<$Res> {
  _$TemplateDetailReadyCopyWithImpl(this._self, this._then);

  final TemplateDetailReady _self;
  final $Res Function(TemplateDetailReady) _then;

/// Create a copy of TemplateDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? template = null,}) {
  return _then(TemplateDetailReady(
null == template ? _self.template : template // ignore: cast_nullable_to_non_nullable
as LegalTemplate,
  ));
}

/// Create a copy of TemplateDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTemplateCopyWith<$Res> get template {
  
  return $LegalTemplateCopyWith<$Res>(_self.template, (value) {
    return _then(_self.copyWith(template: value));
  });
}
}

/// @nodoc


class TemplateDetailFailure implements TemplateDetailState {
  const TemplateDetailFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of TemplateDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateDetailFailureCopyWith<TemplateDetailFailure> get copyWith => _$TemplateDetailFailureCopyWithImpl<TemplateDetailFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateDetailFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'TemplateDetailState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $TemplateDetailFailureCopyWith<$Res> implements $TemplateDetailStateCopyWith<$Res> {
  factory $TemplateDetailFailureCopyWith(TemplateDetailFailure value, $Res Function(TemplateDetailFailure) _then) = _$TemplateDetailFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$TemplateDetailFailureCopyWithImpl<$Res>
    implements $TemplateDetailFailureCopyWith<$Res> {
  _$TemplateDetailFailureCopyWithImpl(this._self, this._then);

  final TemplateDetailFailure _self;
  final $Res Function(TemplateDetailFailure) _then;

/// Create a copy of TemplateDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(TemplateDetailFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
