// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_category_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplateCategoryDto {

 int get categoryId; String get nameEn; String get nameUr; String get icon; String get descriptionEn; String get descriptionUr; int get templateCount;
/// Create a copy of TemplateCategoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateCategoryDtoCopyWith<TemplateCategoryDto> get copyWith => _$TemplateCategoryDtoCopyWithImpl<TemplateCategoryDto>(this as TemplateCategoryDto, _$identity);

  /// Serializes this TemplateCategoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateCategoryDto&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameUr, nameUr) || other.nameUr == nameUr)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUr, descriptionUr) || other.descriptionUr == descriptionUr)&&(identical(other.templateCount, templateCount) || other.templateCount == templateCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,nameEn,nameUr,icon,descriptionEn,descriptionUr,templateCount);

@override
String toString() {
  return 'TemplateCategoryDto(categoryId: $categoryId, nameEn: $nameEn, nameUr: $nameUr, icon: $icon, descriptionEn: $descriptionEn, descriptionUr: $descriptionUr, templateCount: $templateCount)';
}


}

/// @nodoc
abstract mixin class $TemplateCategoryDtoCopyWith<$Res>  {
  factory $TemplateCategoryDtoCopyWith(TemplateCategoryDto value, $Res Function(TemplateCategoryDto) _then) = _$TemplateCategoryDtoCopyWithImpl;
@useResult
$Res call({
 int categoryId, String nameEn, String nameUr, String icon, String descriptionEn, String descriptionUr, int templateCount
});




}
/// @nodoc
class _$TemplateCategoryDtoCopyWithImpl<$Res>
    implements $TemplateCategoryDtoCopyWith<$Res> {
  _$TemplateCategoryDtoCopyWithImpl(this._self, this._then);

  final TemplateCategoryDto _self;
  final $Res Function(TemplateCategoryDto) _then;

/// Create a copy of TemplateCategoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? nameEn = null,Object? nameUr = null,Object? icon = null,Object? descriptionEn = null,Object? descriptionUr = null,Object? templateCount = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameUr: null == nameUr ? _self.nameUr : nameUr // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUr: null == descriptionUr ? _self.descriptionUr : descriptionUr // ignore: cast_nullable_to_non_nullable
as String,templateCount: null == templateCount ? _self.templateCount : templateCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateCategoryDto].
extension TemplateCategoryDtoPatterns on TemplateCategoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateCategoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateCategoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateCategoryDto value)  $default,){
final _that = this;
switch (_that) {
case _TemplateCategoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateCategoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateCategoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int categoryId,  String nameEn,  String nameUr,  String icon,  String descriptionEn,  String descriptionUr,  int templateCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateCategoryDto() when $default != null:
return $default(_that.categoryId,_that.nameEn,_that.nameUr,_that.icon,_that.descriptionEn,_that.descriptionUr,_that.templateCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int categoryId,  String nameEn,  String nameUr,  String icon,  String descriptionEn,  String descriptionUr,  int templateCount)  $default,) {final _that = this;
switch (_that) {
case _TemplateCategoryDto():
return $default(_that.categoryId,_that.nameEn,_that.nameUr,_that.icon,_that.descriptionEn,_that.descriptionUr,_that.templateCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int categoryId,  String nameEn,  String nameUr,  String icon,  String descriptionEn,  String descriptionUr,  int templateCount)?  $default,) {final _that = this;
switch (_that) {
case _TemplateCategoryDto() when $default != null:
return $default(_that.categoryId,_that.nameEn,_that.nameUr,_that.icon,_that.descriptionEn,_that.descriptionUr,_that.templateCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemplateCategoryDto implements TemplateCategoryDto {
  const _TemplateCategoryDto({required this.categoryId, required this.nameEn, required this.nameUr, required this.icon, this.descriptionEn = '', this.descriptionUr = '', this.templateCount = 0});
  factory _TemplateCategoryDto.fromJson(Map<String, dynamic> json) => _$TemplateCategoryDtoFromJson(json);

@override final  int categoryId;
@override final  String nameEn;
@override final  String nameUr;
@override final  String icon;
@override@JsonKey() final  String descriptionEn;
@override@JsonKey() final  String descriptionUr;
@override@JsonKey() final  int templateCount;

/// Create a copy of TemplateCategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateCategoryDtoCopyWith<_TemplateCategoryDto> get copyWith => __$TemplateCategoryDtoCopyWithImpl<_TemplateCategoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemplateCategoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateCategoryDto&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameUr, nameUr) || other.nameUr == nameUr)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUr, descriptionUr) || other.descriptionUr == descriptionUr)&&(identical(other.templateCount, templateCount) || other.templateCount == templateCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,nameEn,nameUr,icon,descriptionEn,descriptionUr,templateCount);

@override
String toString() {
  return 'TemplateCategoryDto(categoryId: $categoryId, nameEn: $nameEn, nameUr: $nameUr, icon: $icon, descriptionEn: $descriptionEn, descriptionUr: $descriptionUr, templateCount: $templateCount)';
}


}

/// @nodoc
abstract mixin class _$TemplateCategoryDtoCopyWith<$Res> implements $TemplateCategoryDtoCopyWith<$Res> {
  factory _$TemplateCategoryDtoCopyWith(_TemplateCategoryDto value, $Res Function(_TemplateCategoryDto) _then) = __$TemplateCategoryDtoCopyWithImpl;
@override @useResult
$Res call({
 int categoryId, String nameEn, String nameUr, String icon, String descriptionEn, String descriptionUr, int templateCount
});




}
/// @nodoc
class __$TemplateCategoryDtoCopyWithImpl<$Res>
    implements _$TemplateCategoryDtoCopyWith<$Res> {
  __$TemplateCategoryDtoCopyWithImpl(this._self, this._then);

  final _TemplateCategoryDto _self;
  final $Res Function(_TemplateCategoryDto) _then;

/// Create a copy of TemplateCategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? nameEn = null,Object? nameUr = null,Object? icon = null,Object? descriptionEn = null,Object? descriptionUr = null,Object? templateCount = null,}) {
  return _then(_TemplateCategoryDto(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameUr: null == nameUr ? _self.nameUr : nameUr // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUr: null == descriptionUr ? _self.descriptionUr : descriptionUr // ignore: cast_nullable_to_non_nullable
as String,templateCount: null == templateCount ? _self.templateCount : templateCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
