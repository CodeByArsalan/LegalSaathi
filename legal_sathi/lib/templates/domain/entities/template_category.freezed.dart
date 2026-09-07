// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TemplateCategory {

 int get id; String get nameEn; String get nameUr; String get descriptionEn; String get descriptionUr; String get icon; int get templateCount;
/// Create a copy of TemplateCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateCategoryCopyWith<TemplateCategory> get copyWith => _$TemplateCategoryCopyWithImpl<TemplateCategory>(this as TemplateCategory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameUr, nameUr) || other.nameUr == nameUr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUr, descriptionUr) || other.descriptionUr == descriptionUr)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.templateCount, templateCount) || other.templateCount == templateCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameUr,descriptionEn,descriptionUr,icon,templateCount);

@override
String toString() {
  return 'TemplateCategory(id: $id, nameEn: $nameEn, nameUr: $nameUr, descriptionEn: $descriptionEn, descriptionUr: $descriptionUr, icon: $icon, templateCount: $templateCount)';
}


}

/// @nodoc
abstract mixin class $TemplateCategoryCopyWith<$Res>  {
  factory $TemplateCategoryCopyWith(TemplateCategory value, $Res Function(TemplateCategory) _then) = _$TemplateCategoryCopyWithImpl;
@useResult
$Res call({
 int id, String nameEn, String nameUr, String descriptionEn, String descriptionUr, String icon, int templateCount
});




}
/// @nodoc
class _$TemplateCategoryCopyWithImpl<$Res>
    implements $TemplateCategoryCopyWith<$Res> {
  _$TemplateCategoryCopyWithImpl(this._self, this._then);

  final TemplateCategory _self;
  final $Res Function(TemplateCategory) _then;

/// Create a copy of TemplateCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameEn = null,Object? nameUr = null,Object? descriptionEn = null,Object? descriptionUr = null,Object? icon = null,Object? templateCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameUr: null == nameUr ? _self.nameUr : nameUr // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUr: null == descriptionUr ? _self.descriptionUr : descriptionUr // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,templateCount: null == templateCount ? _self.templateCount : templateCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateCategory].
extension TemplateCategoryPatterns on TemplateCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateCategory value)  $default,){
final _that = this;
switch (_that) {
case _TemplateCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateCategory value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nameEn,  String nameUr,  String descriptionEn,  String descriptionUr,  String icon,  int templateCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateCategory() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameUr,_that.descriptionEn,_that.descriptionUr,_that.icon,_that.templateCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nameEn,  String nameUr,  String descriptionEn,  String descriptionUr,  String icon,  int templateCount)  $default,) {final _that = this;
switch (_that) {
case _TemplateCategory():
return $default(_that.id,_that.nameEn,_that.nameUr,_that.descriptionEn,_that.descriptionUr,_that.icon,_that.templateCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nameEn,  String nameUr,  String descriptionEn,  String descriptionUr,  String icon,  int templateCount)?  $default,) {final _that = this;
switch (_that) {
case _TemplateCategory() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameUr,_that.descriptionEn,_that.descriptionUr,_that.icon,_that.templateCount);case _:
  return null;

}
}

}

/// @nodoc


class _TemplateCategory implements TemplateCategory {
  const _TemplateCategory({required this.id, required this.nameEn, required this.nameUr, required this.descriptionEn, required this.descriptionUr, required this.icon, this.templateCount = 0});
  

@override final  int id;
@override final  String nameEn;
@override final  String nameUr;
@override final  String descriptionEn;
@override final  String descriptionUr;
@override final  String icon;
@override@JsonKey() final  int templateCount;

/// Create a copy of TemplateCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateCategoryCopyWith<_TemplateCategory> get copyWith => __$TemplateCategoryCopyWithImpl<_TemplateCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameUr, nameUr) || other.nameUr == nameUr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUr, descriptionUr) || other.descriptionUr == descriptionUr)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.templateCount, templateCount) || other.templateCount == templateCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameUr,descriptionEn,descriptionUr,icon,templateCount);

@override
String toString() {
  return 'TemplateCategory(id: $id, nameEn: $nameEn, nameUr: $nameUr, descriptionEn: $descriptionEn, descriptionUr: $descriptionUr, icon: $icon, templateCount: $templateCount)';
}


}

/// @nodoc
abstract mixin class _$TemplateCategoryCopyWith<$Res> implements $TemplateCategoryCopyWith<$Res> {
  factory _$TemplateCategoryCopyWith(_TemplateCategory value, $Res Function(_TemplateCategory) _then) = __$TemplateCategoryCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String nameUr, String descriptionEn, String descriptionUr, String icon, int templateCount
});




}
/// @nodoc
class __$TemplateCategoryCopyWithImpl<$Res>
    implements _$TemplateCategoryCopyWith<$Res> {
  __$TemplateCategoryCopyWithImpl(this._self, this._then);

  final _TemplateCategory _self;
  final $Res Function(_TemplateCategory) _then;

/// Create a copy of TemplateCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameUr = null,Object? descriptionEn = null,Object? descriptionUr = null,Object? icon = null,Object? templateCount = null,}) {
  return _then(_TemplateCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameUr: null == nameUr ? _self.nameUr : nameUr // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUr: null == descriptionUr ? _self.descriptionUr : descriptionUr // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,templateCount: null == templateCount ? _self.templateCount : templateCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
