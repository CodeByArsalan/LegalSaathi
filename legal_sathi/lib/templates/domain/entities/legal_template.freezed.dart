// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legal_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LegalTemplate {

 int get id;/// The only key the detail endpoint accepts.
 String get slug; int get categoryId; String get titleEn; String get titleUr; String get descriptionEn; String get descriptionUr; double get basePrice; TemplateTier get tier; bool get requiresStampPaper; double get estimatedStampDuty; String? get categoryNameEn; String? get categoryNameUr; String? get contentTemplateEn; String? get contentTemplateUr;/// A comma-separated list of statutes, exactly as the server stores it.
 String? get applicableLaws; List<TemplateField> get fields;
/// Create a copy of LegalTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalTemplateCopyWith<LegalTemplate> get copyWith => _$LegalTemplateCopyWithImpl<LegalTemplate>(this as LegalTemplate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleUr, titleUr) || other.titleUr == titleUr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUr, descriptionUr) || other.descriptionUr == descriptionUr)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.requiresStampPaper, requiresStampPaper) || other.requiresStampPaper == requiresStampPaper)&&(identical(other.estimatedStampDuty, estimatedStampDuty) || other.estimatedStampDuty == estimatedStampDuty)&&(identical(other.categoryNameEn, categoryNameEn) || other.categoryNameEn == categoryNameEn)&&(identical(other.categoryNameUr, categoryNameUr) || other.categoryNameUr == categoryNameUr)&&(identical(other.contentTemplateEn, contentTemplateEn) || other.contentTemplateEn == contentTemplateEn)&&(identical(other.contentTemplateUr, contentTemplateUr) || other.contentTemplateUr == contentTemplateUr)&&(identical(other.applicableLaws, applicableLaws) || other.applicableLaws == applicableLaws)&&const DeepCollectionEquality().equals(other.fields, fields));
}


@override
int get hashCode => Object.hash(runtimeType,id,slug,categoryId,titleEn,titleUr,descriptionEn,descriptionUr,basePrice,tier,requiresStampPaper,estimatedStampDuty,categoryNameEn,categoryNameUr,contentTemplateEn,contentTemplateUr,applicableLaws,const DeepCollectionEquality().hash(fields));

@override
String toString() {
  return 'LegalTemplate(id: $id, slug: $slug, categoryId: $categoryId, titleEn: $titleEn, titleUr: $titleUr, descriptionEn: $descriptionEn, descriptionUr: $descriptionUr, basePrice: $basePrice, tier: $tier, requiresStampPaper: $requiresStampPaper, estimatedStampDuty: $estimatedStampDuty, categoryNameEn: $categoryNameEn, categoryNameUr: $categoryNameUr, contentTemplateEn: $contentTemplateEn, contentTemplateUr: $contentTemplateUr, applicableLaws: $applicableLaws, fields: $fields)';
}


}

/// @nodoc
abstract mixin class $LegalTemplateCopyWith<$Res>  {
  factory $LegalTemplateCopyWith(LegalTemplate value, $Res Function(LegalTemplate) _then) = _$LegalTemplateCopyWithImpl;
@useResult
$Res call({
 int id, String slug, int categoryId, String titleEn, String titleUr, String descriptionEn, String descriptionUr, double basePrice, TemplateTier tier, bool requiresStampPaper, double estimatedStampDuty, String? categoryNameEn, String? categoryNameUr, String? contentTemplateEn, String? contentTemplateUr, String? applicableLaws, List<TemplateField> fields
});




}
/// @nodoc
class _$LegalTemplateCopyWithImpl<$Res>
    implements $LegalTemplateCopyWith<$Res> {
  _$LegalTemplateCopyWithImpl(this._self, this._then);

  final LegalTemplate _self;
  final $Res Function(LegalTemplate) _then;

/// Create a copy of LegalTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? categoryId = null,Object? titleEn = null,Object? titleUr = null,Object? descriptionEn = null,Object? descriptionUr = null,Object? basePrice = null,Object? tier = null,Object? requiresStampPaper = null,Object? estimatedStampDuty = null,Object? categoryNameEn = freezed,Object? categoryNameUr = freezed,Object? contentTemplateEn = freezed,Object? contentTemplateUr = freezed,Object? applicableLaws = freezed,Object? fields = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleUr: null == titleUr ? _self.titleUr : titleUr // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUr: null == descriptionUr ? _self.descriptionUr : descriptionUr // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as TemplateTier,requiresStampPaper: null == requiresStampPaper ? _self.requiresStampPaper : requiresStampPaper // ignore: cast_nullable_to_non_nullable
as bool,estimatedStampDuty: null == estimatedStampDuty ? _self.estimatedStampDuty : estimatedStampDuty // ignore: cast_nullable_to_non_nullable
as double,categoryNameEn: freezed == categoryNameEn ? _self.categoryNameEn : categoryNameEn // ignore: cast_nullable_to_non_nullable
as String?,categoryNameUr: freezed == categoryNameUr ? _self.categoryNameUr : categoryNameUr // ignore: cast_nullable_to_non_nullable
as String?,contentTemplateEn: freezed == contentTemplateEn ? _self.contentTemplateEn : contentTemplateEn // ignore: cast_nullable_to_non_nullable
as String?,contentTemplateUr: freezed == contentTemplateUr ? _self.contentTemplateUr : contentTemplateUr // ignore: cast_nullable_to_non_nullable
as String?,applicableLaws: freezed == applicableLaws ? _self.applicableLaws : applicableLaws // ignore: cast_nullable_to_non_nullable
as String?,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<TemplateField>,
  ));
}

}


/// Adds pattern-matching-related methods to [LegalTemplate].
extension LegalTemplatePatterns on LegalTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegalTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegalTemplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegalTemplate value)  $default,){
final _that = this;
switch (_that) {
case _LegalTemplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegalTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _LegalTemplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String slug,  int categoryId,  String titleEn,  String titleUr,  String descriptionEn,  String descriptionUr,  double basePrice,  TemplateTier tier,  bool requiresStampPaper,  double estimatedStampDuty,  String? categoryNameEn,  String? categoryNameUr,  String? contentTemplateEn,  String? contentTemplateUr,  String? applicableLaws,  List<TemplateField> fields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegalTemplate() when $default != null:
return $default(_that.id,_that.slug,_that.categoryId,_that.titleEn,_that.titleUr,_that.descriptionEn,_that.descriptionUr,_that.basePrice,_that.tier,_that.requiresStampPaper,_that.estimatedStampDuty,_that.categoryNameEn,_that.categoryNameUr,_that.contentTemplateEn,_that.contentTemplateUr,_that.applicableLaws,_that.fields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String slug,  int categoryId,  String titleEn,  String titleUr,  String descriptionEn,  String descriptionUr,  double basePrice,  TemplateTier tier,  bool requiresStampPaper,  double estimatedStampDuty,  String? categoryNameEn,  String? categoryNameUr,  String? contentTemplateEn,  String? contentTemplateUr,  String? applicableLaws,  List<TemplateField> fields)  $default,) {final _that = this;
switch (_that) {
case _LegalTemplate():
return $default(_that.id,_that.slug,_that.categoryId,_that.titleEn,_that.titleUr,_that.descriptionEn,_that.descriptionUr,_that.basePrice,_that.tier,_that.requiresStampPaper,_that.estimatedStampDuty,_that.categoryNameEn,_that.categoryNameUr,_that.contentTemplateEn,_that.contentTemplateUr,_that.applicableLaws,_that.fields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String slug,  int categoryId,  String titleEn,  String titleUr,  String descriptionEn,  String descriptionUr,  double basePrice,  TemplateTier tier,  bool requiresStampPaper,  double estimatedStampDuty,  String? categoryNameEn,  String? categoryNameUr,  String? contentTemplateEn,  String? contentTemplateUr,  String? applicableLaws,  List<TemplateField> fields)?  $default,) {final _that = this;
switch (_that) {
case _LegalTemplate() when $default != null:
return $default(_that.id,_that.slug,_that.categoryId,_that.titleEn,_that.titleUr,_that.descriptionEn,_that.descriptionUr,_that.basePrice,_that.tier,_that.requiresStampPaper,_that.estimatedStampDuty,_that.categoryNameEn,_that.categoryNameUr,_that.contentTemplateEn,_that.contentTemplateUr,_that.applicableLaws,_that.fields);case _:
  return null;

}
}

}

/// @nodoc


class _LegalTemplate implements LegalTemplate {
  const _LegalTemplate({required this.id, required this.slug, required this.categoryId, required this.titleEn, required this.titleUr, required this.descriptionEn, required this.descriptionUr, required this.basePrice, required this.tier, required this.requiresStampPaper, required this.estimatedStampDuty, this.categoryNameEn, this.categoryNameUr, this.contentTemplateEn, this.contentTemplateUr, this.applicableLaws, final  List<TemplateField> fields = const <TemplateField>[]}): _fields = fields;
  

@override final  int id;
/// The only key the detail endpoint accepts.
@override final  String slug;
@override final  int categoryId;
@override final  String titleEn;
@override final  String titleUr;
@override final  String descriptionEn;
@override final  String descriptionUr;
@override final  double basePrice;
@override final  TemplateTier tier;
@override final  bool requiresStampPaper;
@override final  double estimatedStampDuty;
@override final  String? categoryNameEn;
@override final  String? categoryNameUr;
@override final  String? contentTemplateEn;
@override final  String? contentTemplateUr;
/// A comma-separated list of statutes, exactly as the server stores it.
@override final  String? applicableLaws;
 final  List<TemplateField> _fields;
@override@JsonKey() List<TemplateField> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}


/// Create a copy of LegalTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalTemplateCopyWith<_LegalTemplate> get copyWith => __$LegalTemplateCopyWithImpl<_LegalTemplate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleUr, titleUr) || other.titleUr == titleUr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUr, descriptionUr) || other.descriptionUr == descriptionUr)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.requiresStampPaper, requiresStampPaper) || other.requiresStampPaper == requiresStampPaper)&&(identical(other.estimatedStampDuty, estimatedStampDuty) || other.estimatedStampDuty == estimatedStampDuty)&&(identical(other.categoryNameEn, categoryNameEn) || other.categoryNameEn == categoryNameEn)&&(identical(other.categoryNameUr, categoryNameUr) || other.categoryNameUr == categoryNameUr)&&(identical(other.contentTemplateEn, contentTemplateEn) || other.contentTemplateEn == contentTemplateEn)&&(identical(other.contentTemplateUr, contentTemplateUr) || other.contentTemplateUr == contentTemplateUr)&&(identical(other.applicableLaws, applicableLaws) || other.applicableLaws == applicableLaws)&&const DeepCollectionEquality().equals(other._fields, _fields));
}


@override
int get hashCode => Object.hash(runtimeType,id,slug,categoryId,titleEn,titleUr,descriptionEn,descriptionUr,basePrice,tier,requiresStampPaper,estimatedStampDuty,categoryNameEn,categoryNameUr,contentTemplateEn,contentTemplateUr,applicableLaws,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'LegalTemplate(id: $id, slug: $slug, categoryId: $categoryId, titleEn: $titleEn, titleUr: $titleUr, descriptionEn: $descriptionEn, descriptionUr: $descriptionUr, basePrice: $basePrice, tier: $tier, requiresStampPaper: $requiresStampPaper, estimatedStampDuty: $estimatedStampDuty, categoryNameEn: $categoryNameEn, categoryNameUr: $categoryNameUr, contentTemplateEn: $contentTemplateEn, contentTemplateUr: $contentTemplateUr, applicableLaws: $applicableLaws, fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$LegalTemplateCopyWith<$Res> implements $LegalTemplateCopyWith<$Res> {
  factory _$LegalTemplateCopyWith(_LegalTemplate value, $Res Function(_LegalTemplate) _then) = __$LegalTemplateCopyWithImpl;
@override @useResult
$Res call({
 int id, String slug, int categoryId, String titleEn, String titleUr, String descriptionEn, String descriptionUr, double basePrice, TemplateTier tier, bool requiresStampPaper, double estimatedStampDuty, String? categoryNameEn, String? categoryNameUr, String? contentTemplateEn, String? contentTemplateUr, String? applicableLaws, List<TemplateField> fields
});




}
/// @nodoc
class __$LegalTemplateCopyWithImpl<$Res>
    implements _$LegalTemplateCopyWith<$Res> {
  __$LegalTemplateCopyWithImpl(this._self, this._then);

  final _LegalTemplate _self;
  final $Res Function(_LegalTemplate) _then;

/// Create a copy of LegalTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? categoryId = null,Object? titleEn = null,Object? titleUr = null,Object? descriptionEn = null,Object? descriptionUr = null,Object? basePrice = null,Object? tier = null,Object? requiresStampPaper = null,Object? estimatedStampDuty = null,Object? categoryNameEn = freezed,Object? categoryNameUr = freezed,Object? contentTemplateEn = freezed,Object? contentTemplateUr = freezed,Object? applicableLaws = freezed,Object? fields = null,}) {
  return _then(_LegalTemplate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleUr: null == titleUr ? _self.titleUr : titleUr // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUr: null == descriptionUr ? _self.descriptionUr : descriptionUr // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as TemplateTier,requiresStampPaper: null == requiresStampPaper ? _self.requiresStampPaper : requiresStampPaper // ignore: cast_nullable_to_non_nullable
as bool,estimatedStampDuty: null == estimatedStampDuty ? _self.estimatedStampDuty : estimatedStampDuty // ignore: cast_nullable_to_non_nullable
as double,categoryNameEn: freezed == categoryNameEn ? _self.categoryNameEn : categoryNameEn // ignore: cast_nullable_to_non_nullable
as String?,categoryNameUr: freezed == categoryNameUr ? _self.categoryNameUr : categoryNameUr // ignore: cast_nullable_to_non_nullable
as String?,contentTemplateEn: freezed == contentTemplateEn ? _self.contentTemplateEn : contentTemplateEn // ignore: cast_nullable_to_non_nullable
as String?,contentTemplateUr: freezed == contentTemplateUr ? _self.contentTemplateUr : contentTemplateUr // ignore: cast_nullable_to_non_nullable
as String?,applicableLaws: freezed == applicableLaws ? _self.applicableLaws : applicableLaws // ignore: cast_nullable_to_non_nullable
as String?,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<TemplateField>,
  ));
}


}

// dart format on
