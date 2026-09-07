// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_prompt_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuickPromptDto {

 String get id; String get titleEng; String get titleUrdu; String get promptEng; String get promptUrdu; String get category; String get icon;
/// Create a copy of QuickPromptDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuickPromptDtoCopyWith<QuickPromptDto> get copyWith => _$QuickPromptDtoCopyWithImpl<QuickPromptDto>(this as QuickPromptDto, _$identity);

  /// Serializes this QuickPromptDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickPromptDto&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEng, titleEng) || other.titleEng == titleEng)&&(identical(other.titleUrdu, titleUrdu) || other.titleUrdu == titleUrdu)&&(identical(other.promptEng, promptEng) || other.promptEng == promptEng)&&(identical(other.promptUrdu, promptUrdu) || other.promptUrdu == promptUrdu)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titleEng,titleUrdu,promptEng,promptUrdu,category,icon);

@override
String toString() {
  return 'QuickPromptDto(id: $id, titleEng: $titleEng, titleUrdu: $titleUrdu, promptEng: $promptEng, promptUrdu: $promptUrdu, category: $category, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $QuickPromptDtoCopyWith<$Res>  {
  factory $QuickPromptDtoCopyWith(QuickPromptDto value, $Res Function(QuickPromptDto) _then) = _$QuickPromptDtoCopyWithImpl;
@useResult
$Res call({
 String id, String titleEng, String titleUrdu, String promptEng, String promptUrdu, String category, String icon
});




}
/// @nodoc
class _$QuickPromptDtoCopyWithImpl<$Res>
    implements $QuickPromptDtoCopyWith<$Res> {
  _$QuickPromptDtoCopyWithImpl(this._self, this._then);

  final QuickPromptDto _self;
  final $Res Function(QuickPromptDto) _then;

/// Create a copy of QuickPromptDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleEng = null,Object? titleUrdu = null,Object? promptEng = null,Object? promptUrdu = null,Object? category = null,Object? icon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleEng: null == titleEng ? _self.titleEng : titleEng // ignore: cast_nullable_to_non_nullable
as String,titleUrdu: null == titleUrdu ? _self.titleUrdu : titleUrdu // ignore: cast_nullable_to_non_nullable
as String,promptEng: null == promptEng ? _self.promptEng : promptEng // ignore: cast_nullable_to_non_nullable
as String,promptUrdu: null == promptUrdu ? _self.promptUrdu : promptUrdu // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuickPromptDto].
extension QuickPromptDtoPatterns on QuickPromptDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuickPromptDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuickPromptDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuickPromptDto value)  $default,){
final _that = this;
switch (_that) {
case _QuickPromptDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuickPromptDto value)?  $default,){
final _that = this;
switch (_that) {
case _QuickPromptDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titleEng,  String titleUrdu,  String promptEng,  String promptUrdu,  String category,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuickPromptDto() when $default != null:
return $default(_that.id,_that.titleEng,_that.titleUrdu,_that.promptEng,_that.promptUrdu,_that.category,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titleEng,  String titleUrdu,  String promptEng,  String promptUrdu,  String category,  String icon)  $default,) {final _that = this;
switch (_that) {
case _QuickPromptDto():
return $default(_that.id,_that.titleEng,_that.titleUrdu,_that.promptEng,_that.promptUrdu,_that.category,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titleEng,  String titleUrdu,  String promptEng,  String promptUrdu,  String category,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _QuickPromptDto() when $default != null:
return $default(_that.id,_that.titleEng,_that.titleUrdu,_that.promptEng,_that.promptUrdu,_that.category,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuickPromptDto implements QuickPromptDto {
  const _QuickPromptDto({required this.id, this.titleEng = '', this.titleUrdu = '', this.promptEng = '', this.promptUrdu = '', this.category = '', this.icon = ''});
  factory _QuickPromptDto.fromJson(Map<String, dynamic> json) => _$QuickPromptDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  String titleEng;
@override@JsonKey() final  String titleUrdu;
@override@JsonKey() final  String promptEng;
@override@JsonKey() final  String promptUrdu;
@override@JsonKey() final  String category;
@override@JsonKey() final  String icon;

/// Create a copy of QuickPromptDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuickPromptDtoCopyWith<_QuickPromptDto> get copyWith => __$QuickPromptDtoCopyWithImpl<_QuickPromptDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuickPromptDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickPromptDto&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEng, titleEng) || other.titleEng == titleEng)&&(identical(other.titleUrdu, titleUrdu) || other.titleUrdu == titleUrdu)&&(identical(other.promptEng, promptEng) || other.promptEng == promptEng)&&(identical(other.promptUrdu, promptUrdu) || other.promptUrdu == promptUrdu)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titleEng,titleUrdu,promptEng,promptUrdu,category,icon);

@override
String toString() {
  return 'QuickPromptDto(id: $id, titleEng: $titleEng, titleUrdu: $titleUrdu, promptEng: $promptEng, promptUrdu: $promptUrdu, category: $category, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$QuickPromptDtoCopyWith<$Res> implements $QuickPromptDtoCopyWith<$Res> {
  factory _$QuickPromptDtoCopyWith(_QuickPromptDto value, $Res Function(_QuickPromptDto) _then) = __$QuickPromptDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleEng, String titleUrdu, String promptEng, String promptUrdu, String category, String icon
});




}
/// @nodoc
class __$QuickPromptDtoCopyWithImpl<$Res>
    implements _$QuickPromptDtoCopyWith<$Res> {
  __$QuickPromptDtoCopyWithImpl(this._self, this._then);

  final _QuickPromptDto _self;
  final $Res Function(_QuickPromptDto) _then;

/// Create a copy of QuickPromptDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleEng = null,Object? titleUrdu = null,Object? promptEng = null,Object? promptUrdu = null,Object? category = null,Object? icon = null,}) {
  return _then(_QuickPromptDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleEng: null == titleEng ? _self.titleEng : titleEng // ignore: cast_nullable_to_non_nullable
as String,titleUrdu: null == titleUrdu ? _self.titleUrdu : titleUrdu // ignore: cast_nullable_to_non_nullable
as String,promptEng: null == promptEng ? _self.promptEng : promptEng // ignore: cast_nullable_to_non_nullable
as String,promptUrdu: null == promptUrdu ? _self.promptUrdu : promptUrdu // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
