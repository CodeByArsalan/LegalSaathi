// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legal_template_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LegalTemplateDto {

 int get templateId; String get slug; int get categoryId; String get titleEn; String get titleUr; bool get requiresStampPaper;@JsonKey(fromJson: readAmount) double get basePrice;@JsonKey(fromJson: readAmount) double get estimatedStampDuty; String get tier; String get descriptionEn; String get descriptionUr; String get categoryNameEn; String get categoryNameUr; String? get contentTemplateEn; String? get contentTemplateUr; String? get applicableLaws; List<TemplateFieldDto> get formFields;
/// Create a copy of LegalTemplateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalTemplateDtoCopyWith<LegalTemplateDto> get copyWith => _$LegalTemplateDtoCopyWithImpl<LegalTemplateDto>(this as LegalTemplateDto, _$identity);

  /// Serializes this LegalTemplateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalTemplateDto&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleUr, titleUr) || other.titleUr == titleUr)&&(identical(other.requiresStampPaper, requiresStampPaper) || other.requiresStampPaper == requiresStampPaper)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.estimatedStampDuty, estimatedStampDuty) || other.estimatedStampDuty == estimatedStampDuty)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUr, descriptionUr) || other.descriptionUr == descriptionUr)&&(identical(other.categoryNameEn, categoryNameEn) || other.categoryNameEn == categoryNameEn)&&(identical(other.categoryNameUr, categoryNameUr) || other.categoryNameUr == categoryNameUr)&&(identical(other.contentTemplateEn, contentTemplateEn) || other.contentTemplateEn == contentTemplateEn)&&(identical(other.contentTemplateUr, contentTemplateUr) || other.contentTemplateUr == contentTemplateUr)&&(identical(other.applicableLaws, applicableLaws) || other.applicableLaws == applicableLaws)&&const DeepCollectionEquality().equals(other.formFields, formFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,templateId,slug,categoryId,titleEn,titleUr,requiresStampPaper,basePrice,estimatedStampDuty,tier,descriptionEn,descriptionUr,categoryNameEn,categoryNameUr,contentTemplateEn,contentTemplateUr,applicableLaws,const DeepCollectionEquality().hash(formFields));

@override
String toString() {
  return 'LegalTemplateDto(templateId: $templateId, slug: $slug, categoryId: $categoryId, titleEn: $titleEn, titleUr: $titleUr, requiresStampPaper: $requiresStampPaper, basePrice: $basePrice, estimatedStampDuty: $estimatedStampDuty, tier: $tier, descriptionEn: $descriptionEn, descriptionUr: $descriptionUr, categoryNameEn: $categoryNameEn, categoryNameUr: $categoryNameUr, contentTemplateEn: $contentTemplateEn, contentTemplateUr: $contentTemplateUr, applicableLaws: $applicableLaws, formFields: $formFields)';
}


}

/// @nodoc
abstract mixin class $LegalTemplateDtoCopyWith<$Res>  {
  factory $LegalTemplateDtoCopyWith(LegalTemplateDto value, $Res Function(LegalTemplateDto) _then) = _$LegalTemplateDtoCopyWithImpl;
@useResult
$Res call({
 int templateId, String slug, int categoryId, String titleEn, String titleUr, bool requiresStampPaper,@JsonKey(fromJson: readAmount) double basePrice,@JsonKey(fromJson: readAmount) double estimatedStampDuty, String tier, String descriptionEn, String descriptionUr, String categoryNameEn, String categoryNameUr, String? contentTemplateEn, String? contentTemplateUr, String? applicableLaws, List<TemplateFieldDto> formFields
});




}
/// @nodoc
class _$LegalTemplateDtoCopyWithImpl<$Res>
    implements $LegalTemplateDtoCopyWith<$Res> {
  _$LegalTemplateDtoCopyWithImpl(this._self, this._then);

  final LegalTemplateDto _self;
  final $Res Function(LegalTemplateDto) _then;

/// Create a copy of LegalTemplateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? templateId = null,Object? slug = null,Object? categoryId = null,Object? titleEn = null,Object? titleUr = null,Object? requiresStampPaper = null,Object? basePrice = null,Object? estimatedStampDuty = null,Object? tier = null,Object? descriptionEn = null,Object? descriptionUr = null,Object? categoryNameEn = null,Object? categoryNameUr = null,Object? contentTemplateEn = freezed,Object? contentTemplateUr = freezed,Object? applicableLaws = freezed,Object? formFields = null,}) {
  return _then(_self.copyWith(
templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleUr: null == titleUr ? _self.titleUr : titleUr // ignore: cast_nullable_to_non_nullable
as String,requiresStampPaper: null == requiresStampPaper ? _self.requiresStampPaper : requiresStampPaper // ignore: cast_nullable_to_non_nullable
as bool,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,estimatedStampDuty: null == estimatedStampDuty ? _self.estimatedStampDuty : estimatedStampDuty // ignore: cast_nullable_to_non_nullable
as double,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUr: null == descriptionUr ? _self.descriptionUr : descriptionUr // ignore: cast_nullable_to_non_nullable
as String,categoryNameEn: null == categoryNameEn ? _self.categoryNameEn : categoryNameEn // ignore: cast_nullable_to_non_nullable
as String,categoryNameUr: null == categoryNameUr ? _self.categoryNameUr : categoryNameUr // ignore: cast_nullable_to_non_nullable
as String,contentTemplateEn: freezed == contentTemplateEn ? _self.contentTemplateEn : contentTemplateEn // ignore: cast_nullable_to_non_nullable
as String?,contentTemplateUr: freezed == contentTemplateUr ? _self.contentTemplateUr : contentTemplateUr // ignore: cast_nullable_to_non_nullable
as String?,applicableLaws: freezed == applicableLaws ? _self.applicableLaws : applicableLaws // ignore: cast_nullable_to_non_nullable
as String?,formFields: null == formFields ? _self.formFields : formFields // ignore: cast_nullable_to_non_nullable
as List<TemplateFieldDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [LegalTemplateDto].
extension LegalTemplateDtoPatterns on LegalTemplateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegalTemplateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegalTemplateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegalTemplateDto value)  $default,){
final _that = this;
switch (_that) {
case _LegalTemplateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegalTemplateDto value)?  $default,){
final _that = this;
switch (_that) {
case _LegalTemplateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int templateId,  String slug,  int categoryId,  String titleEn,  String titleUr,  bool requiresStampPaper, @JsonKey(fromJson: readAmount)  double basePrice, @JsonKey(fromJson: readAmount)  double estimatedStampDuty,  String tier,  String descriptionEn,  String descriptionUr,  String categoryNameEn,  String categoryNameUr,  String? contentTemplateEn,  String? contentTemplateUr,  String? applicableLaws,  List<TemplateFieldDto> formFields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegalTemplateDto() when $default != null:
return $default(_that.templateId,_that.slug,_that.categoryId,_that.titleEn,_that.titleUr,_that.requiresStampPaper,_that.basePrice,_that.estimatedStampDuty,_that.tier,_that.descriptionEn,_that.descriptionUr,_that.categoryNameEn,_that.categoryNameUr,_that.contentTemplateEn,_that.contentTemplateUr,_that.applicableLaws,_that.formFields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int templateId,  String slug,  int categoryId,  String titleEn,  String titleUr,  bool requiresStampPaper, @JsonKey(fromJson: readAmount)  double basePrice, @JsonKey(fromJson: readAmount)  double estimatedStampDuty,  String tier,  String descriptionEn,  String descriptionUr,  String categoryNameEn,  String categoryNameUr,  String? contentTemplateEn,  String? contentTemplateUr,  String? applicableLaws,  List<TemplateFieldDto> formFields)  $default,) {final _that = this;
switch (_that) {
case _LegalTemplateDto():
return $default(_that.templateId,_that.slug,_that.categoryId,_that.titleEn,_that.titleUr,_that.requiresStampPaper,_that.basePrice,_that.estimatedStampDuty,_that.tier,_that.descriptionEn,_that.descriptionUr,_that.categoryNameEn,_that.categoryNameUr,_that.contentTemplateEn,_that.contentTemplateUr,_that.applicableLaws,_that.formFields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int templateId,  String slug,  int categoryId,  String titleEn,  String titleUr,  bool requiresStampPaper, @JsonKey(fromJson: readAmount)  double basePrice, @JsonKey(fromJson: readAmount)  double estimatedStampDuty,  String tier,  String descriptionEn,  String descriptionUr,  String categoryNameEn,  String categoryNameUr,  String? contentTemplateEn,  String? contentTemplateUr,  String? applicableLaws,  List<TemplateFieldDto> formFields)?  $default,) {final _that = this;
switch (_that) {
case _LegalTemplateDto() when $default != null:
return $default(_that.templateId,_that.slug,_that.categoryId,_that.titleEn,_that.titleUr,_that.requiresStampPaper,_that.basePrice,_that.estimatedStampDuty,_that.tier,_that.descriptionEn,_that.descriptionUr,_that.categoryNameEn,_that.categoryNameUr,_that.contentTemplateEn,_that.contentTemplateUr,_that.applicableLaws,_that.formFields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LegalTemplateDto implements LegalTemplateDto {
  const _LegalTemplateDto({required this.templateId, required this.slug, required this.categoryId, required this.titleEn, required this.titleUr, required this.requiresStampPaper, @JsonKey(fromJson: readAmount) required this.basePrice, @JsonKey(fromJson: readAmount) required this.estimatedStampDuty, this.tier = 'Standard', this.descriptionEn = '', this.descriptionUr = '', this.categoryNameEn = '', this.categoryNameUr = '', this.contentTemplateEn, this.contentTemplateUr, this.applicableLaws, final  List<TemplateFieldDto> formFields = const <TemplateFieldDto>[]}): _formFields = formFields;
  factory _LegalTemplateDto.fromJson(Map<String, dynamic> json) => _$LegalTemplateDtoFromJson(json);

@override final  int templateId;
@override final  String slug;
@override final  int categoryId;
@override final  String titleEn;
@override final  String titleUr;
@override final  bool requiresStampPaper;
@override@JsonKey(fromJson: readAmount) final  double basePrice;
@override@JsonKey(fromJson: readAmount) final  double estimatedStampDuty;
@override@JsonKey() final  String tier;
@override@JsonKey() final  String descriptionEn;
@override@JsonKey() final  String descriptionUr;
@override@JsonKey() final  String categoryNameEn;
@override@JsonKey() final  String categoryNameUr;
@override final  String? contentTemplateEn;
@override final  String? contentTemplateUr;
@override final  String? applicableLaws;
 final  List<TemplateFieldDto> _formFields;
@override@JsonKey() List<TemplateFieldDto> get formFields {
  if (_formFields is EqualUnmodifiableListView) return _formFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_formFields);
}


/// Create a copy of LegalTemplateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalTemplateDtoCopyWith<_LegalTemplateDto> get copyWith => __$LegalTemplateDtoCopyWithImpl<_LegalTemplateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegalTemplateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalTemplateDto&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleUr, titleUr) || other.titleUr == titleUr)&&(identical(other.requiresStampPaper, requiresStampPaper) || other.requiresStampPaper == requiresStampPaper)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.estimatedStampDuty, estimatedStampDuty) || other.estimatedStampDuty == estimatedStampDuty)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUr, descriptionUr) || other.descriptionUr == descriptionUr)&&(identical(other.categoryNameEn, categoryNameEn) || other.categoryNameEn == categoryNameEn)&&(identical(other.categoryNameUr, categoryNameUr) || other.categoryNameUr == categoryNameUr)&&(identical(other.contentTemplateEn, contentTemplateEn) || other.contentTemplateEn == contentTemplateEn)&&(identical(other.contentTemplateUr, contentTemplateUr) || other.contentTemplateUr == contentTemplateUr)&&(identical(other.applicableLaws, applicableLaws) || other.applicableLaws == applicableLaws)&&const DeepCollectionEquality().equals(other._formFields, _formFields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,templateId,slug,categoryId,titleEn,titleUr,requiresStampPaper,basePrice,estimatedStampDuty,tier,descriptionEn,descriptionUr,categoryNameEn,categoryNameUr,contentTemplateEn,contentTemplateUr,applicableLaws,const DeepCollectionEquality().hash(_formFields));

@override
String toString() {
  return 'LegalTemplateDto(templateId: $templateId, slug: $slug, categoryId: $categoryId, titleEn: $titleEn, titleUr: $titleUr, requiresStampPaper: $requiresStampPaper, basePrice: $basePrice, estimatedStampDuty: $estimatedStampDuty, tier: $tier, descriptionEn: $descriptionEn, descriptionUr: $descriptionUr, categoryNameEn: $categoryNameEn, categoryNameUr: $categoryNameUr, contentTemplateEn: $contentTemplateEn, contentTemplateUr: $contentTemplateUr, applicableLaws: $applicableLaws, formFields: $formFields)';
}


}

/// @nodoc
abstract mixin class _$LegalTemplateDtoCopyWith<$Res> implements $LegalTemplateDtoCopyWith<$Res> {
  factory _$LegalTemplateDtoCopyWith(_LegalTemplateDto value, $Res Function(_LegalTemplateDto) _then) = __$LegalTemplateDtoCopyWithImpl;
@override @useResult
$Res call({
 int templateId, String slug, int categoryId, String titleEn, String titleUr, bool requiresStampPaper,@JsonKey(fromJson: readAmount) double basePrice,@JsonKey(fromJson: readAmount) double estimatedStampDuty, String tier, String descriptionEn, String descriptionUr, String categoryNameEn, String categoryNameUr, String? contentTemplateEn, String? contentTemplateUr, String? applicableLaws, List<TemplateFieldDto> formFields
});




}
/// @nodoc
class __$LegalTemplateDtoCopyWithImpl<$Res>
    implements _$LegalTemplateDtoCopyWith<$Res> {
  __$LegalTemplateDtoCopyWithImpl(this._self, this._then);

  final _LegalTemplateDto _self;
  final $Res Function(_LegalTemplateDto) _then;

/// Create a copy of LegalTemplateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? templateId = null,Object? slug = null,Object? categoryId = null,Object? titleEn = null,Object? titleUr = null,Object? requiresStampPaper = null,Object? basePrice = null,Object? estimatedStampDuty = null,Object? tier = null,Object? descriptionEn = null,Object? descriptionUr = null,Object? categoryNameEn = null,Object? categoryNameUr = null,Object? contentTemplateEn = freezed,Object? contentTemplateUr = freezed,Object? applicableLaws = freezed,Object? formFields = null,}) {
  return _then(_LegalTemplateDto(
templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleUr: null == titleUr ? _self.titleUr : titleUr // ignore: cast_nullable_to_non_nullable
as String,requiresStampPaper: null == requiresStampPaper ? _self.requiresStampPaper : requiresStampPaper // ignore: cast_nullable_to_non_nullable
as bool,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,estimatedStampDuty: null == estimatedStampDuty ? _self.estimatedStampDuty : estimatedStampDuty // ignore: cast_nullable_to_non_nullable
as double,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUr: null == descriptionUr ? _self.descriptionUr : descriptionUr // ignore: cast_nullable_to_non_nullable
as String,categoryNameEn: null == categoryNameEn ? _self.categoryNameEn : categoryNameEn // ignore: cast_nullable_to_non_nullable
as String,categoryNameUr: null == categoryNameUr ? _self.categoryNameUr : categoryNameUr // ignore: cast_nullable_to_non_nullable
as String,contentTemplateEn: freezed == contentTemplateEn ? _self.contentTemplateEn : contentTemplateEn // ignore: cast_nullable_to_non_nullable
as String?,contentTemplateUr: freezed == contentTemplateUr ? _self.contentTemplateUr : contentTemplateUr // ignore: cast_nullable_to_non_nullable
as String?,applicableLaws: freezed == applicableLaws ? _self.applicableLaws : applicableLaws // ignore: cast_nullable_to_non_nullable
as String?,formFields: null == formFields ? _self._formFields : formFields // ignore: cast_nullable_to_non_nullable
as List<TemplateFieldDto>,
  ));
}


}

// dart format on
