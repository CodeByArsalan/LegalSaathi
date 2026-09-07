// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_answer_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiAnswerDto {

 String get answer; int get totalTokens; String get model; int? get queryId;
/// Create a copy of AiAnswerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiAnswerDtoCopyWith<AiAnswerDto> get copyWith => _$AiAnswerDtoCopyWithImpl<AiAnswerDto>(this as AiAnswerDto, _$identity);

  /// Serializes this AiAnswerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiAnswerDto&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.model, model) || other.model == model)&&(identical(other.queryId, queryId) || other.queryId == queryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,answer,totalTokens,model,queryId);

@override
String toString() {
  return 'AiAnswerDto(answer: $answer, totalTokens: $totalTokens, model: $model, queryId: $queryId)';
}


}

/// @nodoc
abstract mixin class $AiAnswerDtoCopyWith<$Res>  {
  factory $AiAnswerDtoCopyWith(AiAnswerDto value, $Res Function(AiAnswerDto) _then) = _$AiAnswerDtoCopyWithImpl;
@useResult
$Res call({
 String answer, int totalTokens, String model, int? queryId
});




}
/// @nodoc
class _$AiAnswerDtoCopyWithImpl<$Res>
    implements $AiAnswerDtoCopyWith<$Res> {
  _$AiAnswerDtoCopyWithImpl(this._self, this._then);

  final AiAnswerDto _self;
  final $Res Function(AiAnswerDto) _then;

/// Create a copy of AiAnswerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? answer = null,Object? totalTokens = null,Object? model = null,Object? queryId = freezed,}) {
  return _then(_self.copyWith(
answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,totalTokens: null == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,queryId: freezed == queryId ? _self.queryId : queryId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiAnswerDto].
extension AiAnswerDtoPatterns on AiAnswerDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiAnswerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiAnswerDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiAnswerDto value)  $default,){
final _that = this;
switch (_that) {
case _AiAnswerDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiAnswerDto value)?  $default,){
final _that = this;
switch (_that) {
case _AiAnswerDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String answer,  int totalTokens,  String model,  int? queryId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiAnswerDto() when $default != null:
return $default(_that.answer,_that.totalTokens,_that.model,_that.queryId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String answer,  int totalTokens,  String model,  int? queryId)  $default,) {final _that = this;
switch (_that) {
case _AiAnswerDto():
return $default(_that.answer,_that.totalTokens,_that.model,_that.queryId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String answer,  int totalTokens,  String model,  int? queryId)?  $default,) {final _that = this;
switch (_that) {
case _AiAnswerDto() when $default != null:
return $default(_that.answer,_that.totalTokens,_that.model,_that.queryId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiAnswerDto implements AiAnswerDto {
  const _AiAnswerDto({this.answer = '', this.totalTokens = 0, this.model = '', this.queryId});
  factory _AiAnswerDto.fromJson(Map<String, dynamic> json) => _$AiAnswerDtoFromJson(json);

@override@JsonKey() final  String answer;
@override@JsonKey() final  int totalTokens;
@override@JsonKey() final  String model;
@override final  int? queryId;

/// Create a copy of AiAnswerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiAnswerDtoCopyWith<_AiAnswerDto> get copyWith => __$AiAnswerDtoCopyWithImpl<_AiAnswerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiAnswerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiAnswerDto&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.model, model) || other.model == model)&&(identical(other.queryId, queryId) || other.queryId == queryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,answer,totalTokens,model,queryId);

@override
String toString() {
  return 'AiAnswerDto(answer: $answer, totalTokens: $totalTokens, model: $model, queryId: $queryId)';
}


}

/// @nodoc
abstract mixin class _$AiAnswerDtoCopyWith<$Res> implements $AiAnswerDtoCopyWith<$Res> {
  factory _$AiAnswerDtoCopyWith(_AiAnswerDto value, $Res Function(_AiAnswerDto) _then) = __$AiAnswerDtoCopyWithImpl;
@override @useResult
$Res call({
 String answer, int totalTokens, String model, int? queryId
});




}
/// @nodoc
class __$AiAnswerDtoCopyWithImpl<$Res>
    implements _$AiAnswerDtoCopyWith<$Res> {
  __$AiAnswerDtoCopyWithImpl(this._self, this._then);

  final _AiAnswerDto _self;
  final $Res Function(_AiAnswerDto) _then;

/// Create a copy of AiAnswerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? answer = null,Object? totalTokens = null,Object? model = null,Object? queryId = freezed,}) {
  return _then(_AiAnswerDto(
answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,totalTokens: null == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,queryId: freezed == queryId ? _self.queryId : queryId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
