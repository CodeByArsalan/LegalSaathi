// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TemplateField {

 int get id; String get fieldKey; FieldType get fieldType; String get labelEn; String get labelUr; bool get isRequired; int get stepNumber; int get sortOrder; List<String> get options; String? get placeholderEn; String? get placeholderUr; String? get helpTextEn; String? get helpTextUr;/// A server-supplied pattern the answer must match, in addition to whatever
/// the field type implies. Null for most fields.
 String? get validationRegex;
/// Create a copy of TemplateField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateFieldCopyWith<TemplateField> get copyWith => _$TemplateFieldCopyWithImpl<TemplateField>(this as TemplateField, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateField&&(identical(other.id, id) || other.id == id)&&(identical(other.fieldKey, fieldKey) || other.fieldKey == fieldKey)&&(identical(other.fieldType, fieldType) || other.fieldType == fieldType)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.labelUr, labelUr) || other.labelUr == labelUr)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.placeholderEn, placeholderEn) || other.placeholderEn == placeholderEn)&&(identical(other.placeholderUr, placeholderUr) || other.placeholderUr == placeholderUr)&&(identical(other.helpTextEn, helpTextEn) || other.helpTextEn == helpTextEn)&&(identical(other.helpTextUr, helpTextUr) || other.helpTextUr == helpTextUr)&&(identical(other.validationRegex, validationRegex) || other.validationRegex == validationRegex));
}


@override
int get hashCode => Object.hash(runtimeType,id,fieldKey,fieldType,labelEn,labelUr,isRequired,stepNumber,sortOrder,const DeepCollectionEquality().hash(options),placeholderEn,placeholderUr,helpTextEn,helpTextUr,validationRegex);

@override
String toString() {
  return 'TemplateField(id: $id, fieldKey: $fieldKey, fieldType: $fieldType, labelEn: $labelEn, labelUr: $labelUr, isRequired: $isRequired, stepNumber: $stepNumber, sortOrder: $sortOrder, options: $options, placeholderEn: $placeholderEn, placeholderUr: $placeholderUr, helpTextEn: $helpTextEn, helpTextUr: $helpTextUr, validationRegex: $validationRegex)';
}


}

/// @nodoc
abstract mixin class $TemplateFieldCopyWith<$Res>  {
  factory $TemplateFieldCopyWith(TemplateField value, $Res Function(TemplateField) _then) = _$TemplateFieldCopyWithImpl;
@useResult
$Res call({
 int id, String fieldKey, FieldType fieldType, String labelEn, String labelUr, bool isRequired, int stepNumber, int sortOrder, List<String> options, String? placeholderEn, String? placeholderUr, String? helpTextEn, String? helpTextUr, String? validationRegex
});




}
/// @nodoc
class _$TemplateFieldCopyWithImpl<$Res>
    implements $TemplateFieldCopyWith<$Res> {
  _$TemplateFieldCopyWithImpl(this._self, this._then);

  final TemplateField _self;
  final $Res Function(TemplateField) _then;

/// Create a copy of TemplateField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fieldKey = null,Object? fieldType = null,Object? labelEn = null,Object? labelUr = null,Object? isRequired = null,Object? stepNumber = null,Object? sortOrder = null,Object? options = null,Object? placeholderEn = freezed,Object? placeholderUr = freezed,Object? helpTextEn = freezed,Object? helpTextUr = freezed,Object? validationRegex = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fieldKey: null == fieldKey ? _self.fieldKey : fieldKey // ignore: cast_nullable_to_non_nullable
as String,fieldType: null == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as FieldType,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,labelUr: null == labelUr ? _self.labelUr : labelUr // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,placeholderEn: freezed == placeholderEn ? _self.placeholderEn : placeholderEn // ignore: cast_nullable_to_non_nullable
as String?,placeholderUr: freezed == placeholderUr ? _self.placeholderUr : placeholderUr // ignore: cast_nullable_to_non_nullable
as String?,helpTextEn: freezed == helpTextEn ? _self.helpTextEn : helpTextEn // ignore: cast_nullable_to_non_nullable
as String?,helpTextUr: freezed == helpTextUr ? _self.helpTextUr : helpTextUr // ignore: cast_nullable_to_non_nullable
as String?,validationRegex: freezed == validationRegex ? _self.validationRegex : validationRegex // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateField].
extension TemplateFieldPatterns on TemplateField {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateField value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateField() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateField value)  $default,){
final _that = this;
switch (_that) {
case _TemplateField():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateField value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateField() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String fieldKey,  FieldType fieldType,  String labelEn,  String labelUr,  bool isRequired,  int stepNumber,  int sortOrder,  List<String> options,  String? placeholderEn,  String? placeholderUr,  String? helpTextEn,  String? helpTextUr,  String? validationRegex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateField() when $default != null:
return $default(_that.id,_that.fieldKey,_that.fieldType,_that.labelEn,_that.labelUr,_that.isRequired,_that.stepNumber,_that.sortOrder,_that.options,_that.placeholderEn,_that.placeholderUr,_that.helpTextEn,_that.helpTextUr,_that.validationRegex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String fieldKey,  FieldType fieldType,  String labelEn,  String labelUr,  bool isRequired,  int stepNumber,  int sortOrder,  List<String> options,  String? placeholderEn,  String? placeholderUr,  String? helpTextEn,  String? helpTextUr,  String? validationRegex)  $default,) {final _that = this;
switch (_that) {
case _TemplateField():
return $default(_that.id,_that.fieldKey,_that.fieldType,_that.labelEn,_that.labelUr,_that.isRequired,_that.stepNumber,_that.sortOrder,_that.options,_that.placeholderEn,_that.placeholderUr,_that.helpTextEn,_that.helpTextUr,_that.validationRegex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String fieldKey,  FieldType fieldType,  String labelEn,  String labelUr,  bool isRequired,  int stepNumber,  int sortOrder,  List<String> options,  String? placeholderEn,  String? placeholderUr,  String? helpTextEn,  String? helpTextUr,  String? validationRegex)?  $default,) {final _that = this;
switch (_that) {
case _TemplateField() when $default != null:
return $default(_that.id,_that.fieldKey,_that.fieldType,_that.labelEn,_that.labelUr,_that.isRequired,_that.stepNumber,_that.sortOrder,_that.options,_that.placeholderEn,_that.placeholderUr,_that.helpTextEn,_that.helpTextUr,_that.validationRegex);case _:
  return null;

}
}

}

/// @nodoc


class _TemplateField implements TemplateField {
  const _TemplateField({required this.id, required this.fieldKey, required this.fieldType, required this.labelEn, required this.labelUr, required this.isRequired, required this.stepNumber, required this.sortOrder, final  List<String> options = const <String>[], this.placeholderEn, this.placeholderUr, this.helpTextEn, this.helpTextUr, this.validationRegex}): _options = options;
  

@override final  int id;
@override final  String fieldKey;
@override final  FieldType fieldType;
@override final  String labelEn;
@override final  String labelUr;
@override final  bool isRequired;
@override final  int stepNumber;
@override final  int sortOrder;
 final  List<String> _options;
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  String? placeholderEn;
@override final  String? placeholderUr;
@override final  String? helpTextEn;
@override final  String? helpTextUr;
/// A server-supplied pattern the answer must match, in addition to whatever
/// the field type implies. Null for most fields.
@override final  String? validationRegex;

/// Create a copy of TemplateField
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateFieldCopyWith<_TemplateField> get copyWith => __$TemplateFieldCopyWithImpl<_TemplateField>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateField&&(identical(other.id, id) || other.id == id)&&(identical(other.fieldKey, fieldKey) || other.fieldKey == fieldKey)&&(identical(other.fieldType, fieldType) || other.fieldType == fieldType)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.labelUr, labelUr) || other.labelUr == labelUr)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.placeholderEn, placeholderEn) || other.placeholderEn == placeholderEn)&&(identical(other.placeholderUr, placeholderUr) || other.placeholderUr == placeholderUr)&&(identical(other.helpTextEn, helpTextEn) || other.helpTextEn == helpTextEn)&&(identical(other.helpTextUr, helpTextUr) || other.helpTextUr == helpTextUr)&&(identical(other.validationRegex, validationRegex) || other.validationRegex == validationRegex));
}


@override
int get hashCode => Object.hash(runtimeType,id,fieldKey,fieldType,labelEn,labelUr,isRequired,stepNumber,sortOrder,const DeepCollectionEquality().hash(_options),placeholderEn,placeholderUr,helpTextEn,helpTextUr,validationRegex);

@override
String toString() {
  return 'TemplateField(id: $id, fieldKey: $fieldKey, fieldType: $fieldType, labelEn: $labelEn, labelUr: $labelUr, isRequired: $isRequired, stepNumber: $stepNumber, sortOrder: $sortOrder, options: $options, placeholderEn: $placeholderEn, placeholderUr: $placeholderUr, helpTextEn: $helpTextEn, helpTextUr: $helpTextUr, validationRegex: $validationRegex)';
}


}

/// @nodoc
abstract mixin class _$TemplateFieldCopyWith<$Res> implements $TemplateFieldCopyWith<$Res> {
  factory _$TemplateFieldCopyWith(_TemplateField value, $Res Function(_TemplateField) _then) = __$TemplateFieldCopyWithImpl;
@override @useResult
$Res call({
 int id, String fieldKey, FieldType fieldType, String labelEn, String labelUr, bool isRequired, int stepNumber, int sortOrder, List<String> options, String? placeholderEn, String? placeholderUr, String? helpTextEn, String? helpTextUr, String? validationRegex
});




}
/// @nodoc
class __$TemplateFieldCopyWithImpl<$Res>
    implements _$TemplateFieldCopyWith<$Res> {
  __$TemplateFieldCopyWithImpl(this._self, this._then);

  final _TemplateField _self;
  final $Res Function(_TemplateField) _then;

/// Create a copy of TemplateField
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fieldKey = null,Object? fieldType = null,Object? labelEn = null,Object? labelUr = null,Object? isRequired = null,Object? stepNumber = null,Object? sortOrder = null,Object? options = null,Object? placeholderEn = freezed,Object? placeholderUr = freezed,Object? helpTextEn = freezed,Object? helpTextUr = freezed,Object? validationRegex = freezed,}) {
  return _then(_TemplateField(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fieldKey: null == fieldKey ? _self.fieldKey : fieldKey // ignore: cast_nullable_to_non_nullable
as String,fieldType: null == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as FieldType,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,labelUr: null == labelUr ? _self.labelUr : labelUr // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,placeholderEn: freezed == placeholderEn ? _self.placeholderEn : placeholderEn // ignore: cast_nullable_to_non_nullable
as String?,placeholderUr: freezed == placeholderUr ? _self.placeholderUr : placeholderUr // ignore: cast_nullable_to_non_nullable
as String?,helpTextEn: freezed == helpTextEn ? _self.helpTextEn : helpTextEn // ignore: cast_nullable_to_non_nullable
as String?,helpTextUr: freezed == helpTextUr ? _self.helpTextUr : helpTextUr // ignore: cast_nullable_to_non_nullable
as String?,validationRegex: freezed == validationRegex ? _self.validationRegex : validationRegex // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
