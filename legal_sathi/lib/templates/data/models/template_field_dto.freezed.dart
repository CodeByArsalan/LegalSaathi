// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_field_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplateFieldDto {

 int get fieldId; String get fieldKey; String get fieldType; String get labelEn; String get labelUr; bool get isRequired; int get stepNumber; int get sortOrder; String get placeholderEn; String get placeholderUr; String get helpTextEn; String get helpTextUr; String? get validationRegex; String? get optionsJson;
/// Create a copy of TemplateFieldDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateFieldDtoCopyWith<TemplateFieldDto> get copyWith => _$TemplateFieldDtoCopyWithImpl<TemplateFieldDto>(this as TemplateFieldDto, _$identity);

  /// Serializes this TemplateFieldDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateFieldDto&&(identical(other.fieldId, fieldId) || other.fieldId == fieldId)&&(identical(other.fieldKey, fieldKey) || other.fieldKey == fieldKey)&&(identical(other.fieldType, fieldType) || other.fieldType == fieldType)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.labelUr, labelUr) || other.labelUr == labelUr)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.placeholderEn, placeholderEn) || other.placeholderEn == placeholderEn)&&(identical(other.placeholderUr, placeholderUr) || other.placeholderUr == placeholderUr)&&(identical(other.helpTextEn, helpTextEn) || other.helpTextEn == helpTextEn)&&(identical(other.helpTextUr, helpTextUr) || other.helpTextUr == helpTextUr)&&(identical(other.validationRegex, validationRegex) || other.validationRegex == validationRegex)&&(identical(other.optionsJson, optionsJson) || other.optionsJson == optionsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fieldId,fieldKey,fieldType,labelEn,labelUr,isRequired,stepNumber,sortOrder,placeholderEn,placeholderUr,helpTextEn,helpTextUr,validationRegex,optionsJson);

@override
String toString() {
  return 'TemplateFieldDto(fieldId: $fieldId, fieldKey: $fieldKey, fieldType: $fieldType, labelEn: $labelEn, labelUr: $labelUr, isRequired: $isRequired, stepNumber: $stepNumber, sortOrder: $sortOrder, placeholderEn: $placeholderEn, placeholderUr: $placeholderUr, helpTextEn: $helpTextEn, helpTextUr: $helpTextUr, validationRegex: $validationRegex, optionsJson: $optionsJson)';
}


}

/// @nodoc
abstract mixin class $TemplateFieldDtoCopyWith<$Res>  {
  factory $TemplateFieldDtoCopyWith(TemplateFieldDto value, $Res Function(TemplateFieldDto) _then) = _$TemplateFieldDtoCopyWithImpl;
@useResult
$Res call({
 int fieldId, String fieldKey, String fieldType, String labelEn, String labelUr, bool isRequired, int stepNumber, int sortOrder, String placeholderEn, String placeholderUr, String helpTextEn, String helpTextUr, String? validationRegex, String? optionsJson
});




}
/// @nodoc
class _$TemplateFieldDtoCopyWithImpl<$Res>
    implements $TemplateFieldDtoCopyWith<$Res> {
  _$TemplateFieldDtoCopyWithImpl(this._self, this._then);

  final TemplateFieldDto _self;
  final $Res Function(TemplateFieldDto) _then;

/// Create a copy of TemplateFieldDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fieldId = null,Object? fieldKey = null,Object? fieldType = null,Object? labelEn = null,Object? labelUr = null,Object? isRequired = null,Object? stepNumber = null,Object? sortOrder = null,Object? placeholderEn = null,Object? placeholderUr = null,Object? helpTextEn = null,Object? helpTextUr = null,Object? validationRegex = freezed,Object? optionsJson = freezed,}) {
  return _then(_self.copyWith(
fieldId: null == fieldId ? _self.fieldId : fieldId // ignore: cast_nullable_to_non_nullable
as int,fieldKey: null == fieldKey ? _self.fieldKey : fieldKey // ignore: cast_nullable_to_non_nullable
as String,fieldType: null == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as String,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,labelUr: null == labelUr ? _self.labelUr : labelUr // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,placeholderEn: null == placeholderEn ? _self.placeholderEn : placeholderEn // ignore: cast_nullable_to_non_nullable
as String,placeholderUr: null == placeholderUr ? _self.placeholderUr : placeholderUr // ignore: cast_nullable_to_non_nullable
as String,helpTextEn: null == helpTextEn ? _self.helpTextEn : helpTextEn // ignore: cast_nullable_to_non_nullable
as String,helpTextUr: null == helpTextUr ? _self.helpTextUr : helpTextUr // ignore: cast_nullable_to_non_nullable
as String,validationRegex: freezed == validationRegex ? _self.validationRegex : validationRegex // ignore: cast_nullable_to_non_nullable
as String?,optionsJson: freezed == optionsJson ? _self.optionsJson : optionsJson // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateFieldDto].
extension TemplateFieldDtoPatterns on TemplateFieldDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateFieldDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateFieldDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateFieldDto value)  $default,){
final _that = this;
switch (_that) {
case _TemplateFieldDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateFieldDto value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateFieldDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int fieldId,  String fieldKey,  String fieldType,  String labelEn,  String labelUr,  bool isRequired,  int stepNumber,  int sortOrder,  String placeholderEn,  String placeholderUr,  String helpTextEn,  String helpTextUr,  String? validationRegex,  String? optionsJson)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateFieldDto() when $default != null:
return $default(_that.fieldId,_that.fieldKey,_that.fieldType,_that.labelEn,_that.labelUr,_that.isRequired,_that.stepNumber,_that.sortOrder,_that.placeholderEn,_that.placeholderUr,_that.helpTextEn,_that.helpTextUr,_that.validationRegex,_that.optionsJson);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int fieldId,  String fieldKey,  String fieldType,  String labelEn,  String labelUr,  bool isRequired,  int stepNumber,  int sortOrder,  String placeholderEn,  String placeholderUr,  String helpTextEn,  String helpTextUr,  String? validationRegex,  String? optionsJson)  $default,) {final _that = this;
switch (_that) {
case _TemplateFieldDto():
return $default(_that.fieldId,_that.fieldKey,_that.fieldType,_that.labelEn,_that.labelUr,_that.isRequired,_that.stepNumber,_that.sortOrder,_that.placeholderEn,_that.placeholderUr,_that.helpTextEn,_that.helpTextUr,_that.validationRegex,_that.optionsJson);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int fieldId,  String fieldKey,  String fieldType,  String labelEn,  String labelUr,  bool isRequired,  int stepNumber,  int sortOrder,  String placeholderEn,  String placeholderUr,  String helpTextEn,  String helpTextUr,  String? validationRegex,  String? optionsJson)?  $default,) {final _that = this;
switch (_that) {
case _TemplateFieldDto() when $default != null:
return $default(_that.fieldId,_that.fieldKey,_that.fieldType,_that.labelEn,_that.labelUr,_that.isRequired,_that.stepNumber,_that.sortOrder,_that.placeholderEn,_that.placeholderUr,_that.helpTextEn,_that.helpTextUr,_that.validationRegex,_that.optionsJson);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemplateFieldDto implements TemplateFieldDto {
  const _TemplateFieldDto({required this.fieldId, required this.fieldKey, required this.fieldType, required this.labelEn, required this.labelUr, required this.isRequired, required this.stepNumber, required this.sortOrder, this.placeholderEn = '', this.placeholderUr = '', this.helpTextEn = '', this.helpTextUr = '', this.validationRegex, this.optionsJson});
  factory _TemplateFieldDto.fromJson(Map<String, dynamic> json) => _$TemplateFieldDtoFromJson(json);

@override final  int fieldId;
@override final  String fieldKey;
@override final  String fieldType;
@override final  String labelEn;
@override final  String labelUr;
@override final  bool isRequired;
@override final  int stepNumber;
@override final  int sortOrder;
@override@JsonKey() final  String placeholderEn;
@override@JsonKey() final  String placeholderUr;
@override@JsonKey() final  String helpTextEn;
@override@JsonKey() final  String helpTextUr;
@override final  String? validationRegex;
@override final  String? optionsJson;

/// Create a copy of TemplateFieldDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateFieldDtoCopyWith<_TemplateFieldDto> get copyWith => __$TemplateFieldDtoCopyWithImpl<_TemplateFieldDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemplateFieldDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateFieldDto&&(identical(other.fieldId, fieldId) || other.fieldId == fieldId)&&(identical(other.fieldKey, fieldKey) || other.fieldKey == fieldKey)&&(identical(other.fieldType, fieldType) || other.fieldType == fieldType)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.labelUr, labelUr) || other.labelUr == labelUr)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.placeholderEn, placeholderEn) || other.placeholderEn == placeholderEn)&&(identical(other.placeholderUr, placeholderUr) || other.placeholderUr == placeholderUr)&&(identical(other.helpTextEn, helpTextEn) || other.helpTextEn == helpTextEn)&&(identical(other.helpTextUr, helpTextUr) || other.helpTextUr == helpTextUr)&&(identical(other.validationRegex, validationRegex) || other.validationRegex == validationRegex)&&(identical(other.optionsJson, optionsJson) || other.optionsJson == optionsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fieldId,fieldKey,fieldType,labelEn,labelUr,isRequired,stepNumber,sortOrder,placeholderEn,placeholderUr,helpTextEn,helpTextUr,validationRegex,optionsJson);

@override
String toString() {
  return 'TemplateFieldDto(fieldId: $fieldId, fieldKey: $fieldKey, fieldType: $fieldType, labelEn: $labelEn, labelUr: $labelUr, isRequired: $isRequired, stepNumber: $stepNumber, sortOrder: $sortOrder, placeholderEn: $placeholderEn, placeholderUr: $placeholderUr, helpTextEn: $helpTextEn, helpTextUr: $helpTextUr, validationRegex: $validationRegex, optionsJson: $optionsJson)';
}


}

/// @nodoc
abstract mixin class _$TemplateFieldDtoCopyWith<$Res> implements $TemplateFieldDtoCopyWith<$Res> {
  factory _$TemplateFieldDtoCopyWith(_TemplateFieldDto value, $Res Function(_TemplateFieldDto) _then) = __$TemplateFieldDtoCopyWithImpl;
@override @useResult
$Res call({
 int fieldId, String fieldKey, String fieldType, String labelEn, String labelUr, bool isRequired, int stepNumber, int sortOrder, String placeholderEn, String placeholderUr, String helpTextEn, String helpTextUr, String? validationRegex, String? optionsJson
});




}
/// @nodoc
class __$TemplateFieldDtoCopyWithImpl<$Res>
    implements _$TemplateFieldDtoCopyWith<$Res> {
  __$TemplateFieldDtoCopyWithImpl(this._self, this._then);

  final _TemplateFieldDto _self;
  final $Res Function(_TemplateFieldDto) _then;

/// Create a copy of TemplateFieldDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fieldId = null,Object? fieldKey = null,Object? fieldType = null,Object? labelEn = null,Object? labelUr = null,Object? isRequired = null,Object? stepNumber = null,Object? sortOrder = null,Object? placeholderEn = null,Object? placeholderUr = null,Object? helpTextEn = null,Object? helpTextUr = null,Object? validationRegex = freezed,Object? optionsJson = freezed,}) {
  return _then(_TemplateFieldDto(
fieldId: null == fieldId ? _self.fieldId : fieldId // ignore: cast_nullable_to_non_nullable
as int,fieldKey: null == fieldKey ? _self.fieldKey : fieldKey // ignore: cast_nullable_to_non_nullable
as String,fieldType: null == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as String,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,labelUr: null == labelUr ? _self.labelUr : labelUr // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,placeholderEn: null == placeholderEn ? _self.placeholderEn : placeholderEn // ignore: cast_nullable_to_non_nullable
as String,placeholderUr: null == placeholderUr ? _self.placeholderUr : placeholderUr // ignore: cast_nullable_to_non_nullable
as String,helpTextEn: null == helpTextEn ? _self.helpTextEn : helpTextEn // ignore: cast_nullable_to_non_nullable
as String,helpTextUr: null == helpTextUr ? _self.helpTextUr : helpTextUr // ignore: cast_nullable_to_non_nullable
as String,validationRegex: freezed == validationRegex ? _self.validationRegex : validationRegex // ignore: cast_nullable_to_non_nullable
as String?,optionsJson: freezed == optionsJson ? _self.optionsJson : optionsJson // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
