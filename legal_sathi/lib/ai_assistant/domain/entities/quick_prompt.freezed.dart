// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_prompt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuickPrompt {

 String get id; String get titleEn; String get titleUr; String get promptEn; String get promptUr; String get category; String get icon;
/// Create a copy of QuickPrompt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuickPromptCopyWith<QuickPrompt> get copyWith => _$QuickPromptCopyWithImpl<QuickPrompt>(this as QuickPrompt, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickPrompt&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleUr, titleUr) || other.titleUr == titleUr)&&(identical(other.promptEn, promptEn) || other.promptEn == promptEn)&&(identical(other.promptUr, promptUr) || other.promptUr == promptUr)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleEn,titleUr,promptEn,promptUr,category,icon);

@override
String toString() {
  return 'QuickPrompt(id: $id, titleEn: $titleEn, titleUr: $titleUr, promptEn: $promptEn, promptUr: $promptUr, category: $category, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $QuickPromptCopyWith<$Res>  {
  factory $QuickPromptCopyWith(QuickPrompt value, $Res Function(QuickPrompt) _then) = _$QuickPromptCopyWithImpl;
@useResult
$Res call({
 String id, String titleEn, String titleUr, String promptEn, String promptUr, String category, String icon
});




}
/// @nodoc
class _$QuickPromptCopyWithImpl<$Res>
    implements $QuickPromptCopyWith<$Res> {
  _$QuickPromptCopyWithImpl(this._self, this._then);

  final QuickPrompt _self;
  final $Res Function(QuickPrompt) _then;

/// Create a copy of QuickPrompt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleEn = null,Object? titleUr = null,Object? promptEn = null,Object? promptUr = null,Object? category = null,Object? icon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleUr: null == titleUr ? _self.titleUr : titleUr // ignore: cast_nullable_to_non_nullable
as String,promptEn: null == promptEn ? _self.promptEn : promptEn // ignore: cast_nullable_to_non_nullable
as String,promptUr: null == promptUr ? _self.promptUr : promptUr // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuickPrompt].
extension QuickPromptPatterns on QuickPrompt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuickPrompt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuickPrompt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuickPrompt value)  $default,){
final _that = this;
switch (_that) {
case _QuickPrompt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuickPrompt value)?  $default,){
final _that = this;
switch (_that) {
case _QuickPrompt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titleEn,  String titleUr,  String promptEn,  String promptUr,  String category,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuickPrompt() when $default != null:
return $default(_that.id,_that.titleEn,_that.titleUr,_that.promptEn,_that.promptUr,_that.category,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titleEn,  String titleUr,  String promptEn,  String promptUr,  String category,  String icon)  $default,) {final _that = this;
switch (_that) {
case _QuickPrompt():
return $default(_that.id,_that.titleEn,_that.titleUr,_that.promptEn,_that.promptUr,_that.category,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titleEn,  String titleUr,  String promptEn,  String promptUr,  String category,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _QuickPrompt() when $default != null:
return $default(_that.id,_that.titleEn,_that.titleUr,_that.promptEn,_that.promptUr,_that.category,_that.icon);case _:
  return null;

}
}

}

/// @nodoc


class _QuickPrompt implements QuickPrompt {
  const _QuickPrompt({required this.id, required this.titleEn, required this.titleUr, required this.promptEn, required this.promptUr, required this.category, required this.icon});
  

@override final  String id;
@override final  String titleEn;
@override final  String titleUr;
@override final  String promptEn;
@override final  String promptUr;
@override final  String category;
@override final  String icon;

/// Create a copy of QuickPrompt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuickPromptCopyWith<_QuickPrompt> get copyWith => __$QuickPromptCopyWithImpl<_QuickPrompt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickPrompt&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleUr, titleUr) || other.titleUr == titleUr)&&(identical(other.promptEn, promptEn) || other.promptEn == promptEn)&&(identical(other.promptUr, promptUr) || other.promptUr == promptUr)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleEn,titleUr,promptEn,promptUr,category,icon);

@override
String toString() {
  return 'QuickPrompt(id: $id, titleEn: $titleEn, titleUr: $titleUr, promptEn: $promptEn, promptUr: $promptUr, category: $category, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$QuickPromptCopyWith<$Res> implements $QuickPromptCopyWith<$Res> {
  factory _$QuickPromptCopyWith(_QuickPrompt value, $Res Function(_QuickPrompt) _then) = __$QuickPromptCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleEn, String titleUr, String promptEn, String promptUr, String category, String icon
});




}
/// @nodoc
class __$QuickPromptCopyWithImpl<$Res>
    implements _$QuickPromptCopyWith<$Res> {
  __$QuickPromptCopyWithImpl(this._self, this._then);

  final _QuickPrompt _self;
  final $Res Function(_QuickPrompt) _then;

/// Create a copy of QuickPrompt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleEn = null,Object? titleUr = null,Object? promptEn = null,Object? promptUr = null,Object? category = null,Object? icon = null,}) {
  return _then(_QuickPrompt(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleUr: null == titleUr ? _self.titleUr : titleUr // ignore: cast_nullable_to_non_nullable
as String,promptEn: null == promptEn ? _self.promptEn : promptEn // ignore: cast_nullable_to_non_nullable
as String,promptUr: null == promptUr ? _self.promptUr : promptUr // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
