// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentSummaryDto {

 int get userDocumentId; String get documentGuid; int get templateId; String get templateTitleEn; String get templateTitleUr; String get title; String get status; int get statusId; bool get isPaid;@JsonKey(fromJson: ServerDate.required) DateTime get createdAt;@JsonKey(fromJson: ServerDate.parse) DateTime? get completedAt;
/// Create a copy of DocumentSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentSummaryDtoCopyWith<DocumentSummaryDto> get copyWith => _$DocumentSummaryDtoCopyWithImpl<DocumentSummaryDto>(this as DocumentSummaryDto, _$identity);

  /// Serializes this DocumentSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentSummaryDto&&(identical(other.userDocumentId, userDocumentId) || other.userDocumentId == userDocumentId)&&(identical(other.documentGuid, documentGuid) || other.documentGuid == documentGuid)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.templateTitleEn, templateTitleEn) || other.templateTitleEn == templateTitleEn)&&(identical(other.templateTitleUr, templateTitleUr) || other.templateTitleUr == templateTitleUr)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userDocumentId,documentGuid,templateId,templateTitleEn,templateTitleUr,title,status,statusId,isPaid,createdAt,completedAt);

@override
String toString() {
  return 'DocumentSummaryDto(userDocumentId: $userDocumentId, documentGuid: $documentGuid, templateId: $templateId, templateTitleEn: $templateTitleEn, templateTitleUr: $templateTitleUr, title: $title, status: $status, statusId: $statusId, isPaid: $isPaid, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $DocumentSummaryDtoCopyWith<$Res>  {
  factory $DocumentSummaryDtoCopyWith(DocumentSummaryDto value, $Res Function(DocumentSummaryDto) _then) = _$DocumentSummaryDtoCopyWithImpl;
@useResult
$Res call({
 int userDocumentId, String documentGuid, int templateId, String templateTitleEn, String templateTitleUr, String title, String status, int statusId, bool isPaid,@JsonKey(fromJson: ServerDate.required) DateTime createdAt,@JsonKey(fromJson: ServerDate.parse) DateTime? completedAt
});




}
/// @nodoc
class _$DocumentSummaryDtoCopyWithImpl<$Res>
    implements $DocumentSummaryDtoCopyWith<$Res> {
  _$DocumentSummaryDtoCopyWithImpl(this._self, this._then);

  final DocumentSummaryDto _self;
  final $Res Function(DocumentSummaryDto) _then;

/// Create a copy of DocumentSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userDocumentId = null,Object? documentGuid = null,Object? templateId = null,Object? templateTitleEn = null,Object? templateTitleUr = null,Object? title = null,Object? status = null,Object? statusId = null,Object? isPaid = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
userDocumentId: null == userDocumentId ? _self.userDocumentId : userDocumentId // ignore: cast_nullable_to_non_nullable
as int,documentGuid: null == documentGuid ? _self.documentGuid : documentGuid // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,templateTitleEn: null == templateTitleEn ? _self.templateTitleEn : templateTitleEn // ignore: cast_nullable_to_non_nullable
as String,templateTitleUr: null == templateTitleUr ? _self.templateTitleUr : templateTitleUr // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusId: null == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentSummaryDto].
extension DocumentSummaryDtoPatterns on DocumentSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _DocumentSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userDocumentId,  String documentGuid,  int templateId,  String templateTitleEn,  String templateTitleUr,  String title,  String status,  int statusId,  bool isPaid, @JsonKey(fromJson: ServerDate.required)  DateTime createdAt, @JsonKey(fromJson: ServerDate.parse)  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentSummaryDto() when $default != null:
return $default(_that.userDocumentId,_that.documentGuid,_that.templateId,_that.templateTitleEn,_that.templateTitleUr,_that.title,_that.status,_that.statusId,_that.isPaid,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userDocumentId,  String documentGuid,  int templateId,  String templateTitleEn,  String templateTitleUr,  String title,  String status,  int statusId,  bool isPaid, @JsonKey(fromJson: ServerDate.required)  DateTime createdAt, @JsonKey(fromJson: ServerDate.parse)  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _DocumentSummaryDto():
return $default(_that.userDocumentId,_that.documentGuid,_that.templateId,_that.templateTitleEn,_that.templateTitleUr,_that.title,_that.status,_that.statusId,_that.isPaid,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userDocumentId,  String documentGuid,  int templateId,  String templateTitleEn,  String templateTitleUr,  String title,  String status,  int statusId,  bool isPaid, @JsonKey(fromJson: ServerDate.required)  DateTime createdAt, @JsonKey(fromJson: ServerDate.parse)  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _DocumentSummaryDto() when $default != null:
return $default(_that.userDocumentId,_that.documentGuid,_that.templateId,_that.templateTitleEn,_that.templateTitleUr,_that.title,_that.status,_that.statusId,_that.isPaid,_that.createdAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentSummaryDto implements DocumentSummaryDto {
  const _DocumentSummaryDto({required this.userDocumentId, required this.documentGuid, required this.templateId, this.templateTitleEn = '', this.templateTitleUr = '', this.title = '', this.status = 'Draft', this.statusId = 1, this.isPaid = false, @JsonKey(fromJson: ServerDate.required) required this.createdAt, @JsonKey(fromJson: ServerDate.parse) this.completedAt});
  factory _DocumentSummaryDto.fromJson(Map<String, dynamic> json) => _$DocumentSummaryDtoFromJson(json);

@override final  int userDocumentId;
@override final  String documentGuid;
@override final  int templateId;
@override@JsonKey() final  String templateTitleEn;
@override@JsonKey() final  String templateTitleUr;
@override@JsonKey() final  String title;
@override@JsonKey() final  String status;
@override@JsonKey() final  int statusId;
@override@JsonKey() final  bool isPaid;
@override@JsonKey(fromJson: ServerDate.required) final  DateTime createdAt;
@override@JsonKey(fromJson: ServerDate.parse) final  DateTime? completedAt;

/// Create a copy of DocumentSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentSummaryDtoCopyWith<_DocumentSummaryDto> get copyWith => __$DocumentSummaryDtoCopyWithImpl<_DocumentSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentSummaryDto&&(identical(other.userDocumentId, userDocumentId) || other.userDocumentId == userDocumentId)&&(identical(other.documentGuid, documentGuid) || other.documentGuid == documentGuid)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.templateTitleEn, templateTitleEn) || other.templateTitleEn == templateTitleEn)&&(identical(other.templateTitleUr, templateTitleUr) || other.templateTitleUr == templateTitleUr)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userDocumentId,documentGuid,templateId,templateTitleEn,templateTitleUr,title,status,statusId,isPaid,createdAt,completedAt);

@override
String toString() {
  return 'DocumentSummaryDto(userDocumentId: $userDocumentId, documentGuid: $documentGuid, templateId: $templateId, templateTitleEn: $templateTitleEn, templateTitleUr: $templateTitleUr, title: $title, status: $status, statusId: $statusId, isPaid: $isPaid, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$DocumentSummaryDtoCopyWith<$Res> implements $DocumentSummaryDtoCopyWith<$Res> {
  factory _$DocumentSummaryDtoCopyWith(_DocumentSummaryDto value, $Res Function(_DocumentSummaryDto) _then) = __$DocumentSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 int userDocumentId, String documentGuid, int templateId, String templateTitleEn, String templateTitleUr, String title, String status, int statusId, bool isPaid,@JsonKey(fromJson: ServerDate.required) DateTime createdAt,@JsonKey(fromJson: ServerDate.parse) DateTime? completedAt
});




}
/// @nodoc
class __$DocumentSummaryDtoCopyWithImpl<$Res>
    implements _$DocumentSummaryDtoCopyWith<$Res> {
  __$DocumentSummaryDtoCopyWithImpl(this._self, this._then);

  final _DocumentSummaryDto _self;
  final $Res Function(_DocumentSummaryDto) _then;

/// Create a copy of DocumentSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userDocumentId = null,Object? documentGuid = null,Object? templateId = null,Object? templateTitleEn = null,Object? templateTitleUr = null,Object? title = null,Object? status = null,Object? statusId = null,Object? isPaid = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_DocumentSummaryDto(
userDocumentId: null == userDocumentId ? _self.userDocumentId : userDocumentId // ignore: cast_nullable_to_non_nullable
as int,documentGuid: null == documentGuid ? _self.documentGuid : documentGuid // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,templateTitleEn: null == templateTitleEn ? _self.templateTitleEn : templateTitleEn // ignore: cast_nullable_to_non_nullable
as String,templateTitleUr: null == templateTitleUr ? _self.templateTitleUr : templateTitleUr // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusId: null == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
