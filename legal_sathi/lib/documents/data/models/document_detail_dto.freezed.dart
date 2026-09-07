// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentDetailDto {

 int get userDocumentId; String get documentGuid; int get templateId; int get userId; String get templateTitleEn; String get templateTitleUr; String get title; String? get formAnswersJson; String get status; int get statusId; bool get isPaid;@JsonKey(fromJson: ServerDate.required) DateTime get createdAt;@JsonKey(fromJson: ServerDate.parse) DateTime? get updatedAt;@JsonKey(fromJson: ServerDate.parse) DateTime? get completedAt; String? get storagePath; String? get docxStoragePath; String? get documentHash;
/// Create a copy of DocumentDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentDetailDtoCopyWith<DocumentDetailDto> get copyWith => _$DocumentDetailDtoCopyWithImpl<DocumentDetailDto>(this as DocumentDetailDto, _$identity);

  /// Serializes this DocumentDetailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentDetailDto&&(identical(other.userDocumentId, userDocumentId) || other.userDocumentId == userDocumentId)&&(identical(other.documentGuid, documentGuid) || other.documentGuid == documentGuid)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.templateTitleEn, templateTitleEn) || other.templateTitleEn == templateTitleEn)&&(identical(other.templateTitleUr, templateTitleUr) || other.templateTitleUr == templateTitleUr)&&(identical(other.title, title) || other.title == title)&&(identical(other.formAnswersJson, formAnswersJson) || other.formAnswersJson == formAnswersJson)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.docxStoragePath, docxStoragePath) || other.docxStoragePath == docxStoragePath)&&(identical(other.documentHash, documentHash) || other.documentHash == documentHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userDocumentId,documentGuid,templateId,userId,templateTitleEn,templateTitleUr,title,formAnswersJson,status,statusId,isPaid,createdAt,updatedAt,completedAt,storagePath,docxStoragePath,documentHash);

@override
String toString() {
  return 'DocumentDetailDto(userDocumentId: $userDocumentId, documentGuid: $documentGuid, templateId: $templateId, userId: $userId, templateTitleEn: $templateTitleEn, templateTitleUr: $templateTitleUr, title: $title, formAnswersJson: $formAnswersJson, status: $status, statusId: $statusId, isPaid: $isPaid, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, storagePath: $storagePath, docxStoragePath: $docxStoragePath, documentHash: $documentHash)';
}


}

/// @nodoc
abstract mixin class $DocumentDetailDtoCopyWith<$Res>  {
  factory $DocumentDetailDtoCopyWith(DocumentDetailDto value, $Res Function(DocumentDetailDto) _then) = _$DocumentDetailDtoCopyWithImpl;
@useResult
$Res call({
 int userDocumentId, String documentGuid, int templateId, int userId, String templateTitleEn, String templateTitleUr, String title, String? formAnswersJson, String status, int statusId, bool isPaid,@JsonKey(fromJson: ServerDate.required) DateTime createdAt,@JsonKey(fromJson: ServerDate.parse) DateTime? updatedAt,@JsonKey(fromJson: ServerDate.parse) DateTime? completedAt, String? storagePath, String? docxStoragePath, String? documentHash
});




}
/// @nodoc
class _$DocumentDetailDtoCopyWithImpl<$Res>
    implements $DocumentDetailDtoCopyWith<$Res> {
  _$DocumentDetailDtoCopyWithImpl(this._self, this._then);

  final DocumentDetailDto _self;
  final $Res Function(DocumentDetailDto) _then;

/// Create a copy of DocumentDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userDocumentId = null,Object? documentGuid = null,Object? templateId = null,Object? userId = null,Object? templateTitleEn = null,Object? templateTitleUr = null,Object? title = null,Object? formAnswersJson = freezed,Object? status = null,Object? statusId = null,Object? isPaid = null,Object? createdAt = null,Object? updatedAt = freezed,Object? completedAt = freezed,Object? storagePath = freezed,Object? docxStoragePath = freezed,Object? documentHash = freezed,}) {
  return _then(_self.copyWith(
userDocumentId: null == userDocumentId ? _self.userDocumentId : userDocumentId // ignore: cast_nullable_to_non_nullable
as int,documentGuid: null == documentGuid ? _self.documentGuid : documentGuid // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,templateTitleEn: null == templateTitleEn ? _self.templateTitleEn : templateTitleEn // ignore: cast_nullable_to_non_nullable
as String,templateTitleUr: null == templateTitleUr ? _self.templateTitleUr : templateTitleUr // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,formAnswersJson: freezed == formAnswersJson ? _self.formAnswersJson : formAnswersJson // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusId: null == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,storagePath: freezed == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String?,docxStoragePath: freezed == docxStoragePath ? _self.docxStoragePath : docxStoragePath // ignore: cast_nullable_to_non_nullable
as String?,documentHash: freezed == documentHash ? _self.documentHash : documentHash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentDetailDto].
extension DocumentDetailDtoPatterns on DocumentDetailDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentDetailDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _DocumentDetailDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentDetailDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userDocumentId,  String documentGuid,  int templateId,  int userId,  String templateTitleEn,  String templateTitleUr,  String title,  String? formAnswersJson,  String status,  int statusId,  bool isPaid, @JsonKey(fromJson: ServerDate.required)  DateTime createdAt, @JsonKey(fromJson: ServerDate.parse)  DateTime? updatedAt, @JsonKey(fromJson: ServerDate.parse)  DateTime? completedAt,  String? storagePath,  String? docxStoragePath,  String? documentHash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentDetailDto() when $default != null:
return $default(_that.userDocumentId,_that.documentGuid,_that.templateId,_that.userId,_that.templateTitleEn,_that.templateTitleUr,_that.title,_that.formAnswersJson,_that.status,_that.statusId,_that.isPaid,_that.createdAt,_that.updatedAt,_that.completedAt,_that.storagePath,_that.docxStoragePath,_that.documentHash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userDocumentId,  String documentGuid,  int templateId,  int userId,  String templateTitleEn,  String templateTitleUr,  String title,  String? formAnswersJson,  String status,  int statusId,  bool isPaid, @JsonKey(fromJson: ServerDate.required)  DateTime createdAt, @JsonKey(fromJson: ServerDate.parse)  DateTime? updatedAt, @JsonKey(fromJson: ServerDate.parse)  DateTime? completedAt,  String? storagePath,  String? docxStoragePath,  String? documentHash)  $default,) {final _that = this;
switch (_that) {
case _DocumentDetailDto():
return $default(_that.userDocumentId,_that.documentGuid,_that.templateId,_that.userId,_that.templateTitleEn,_that.templateTitleUr,_that.title,_that.formAnswersJson,_that.status,_that.statusId,_that.isPaid,_that.createdAt,_that.updatedAt,_that.completedAt,_that.storagePath,_that.docxStoragePath,_that.documentHash);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userDocumentId,  String documentGuid,  int templateId,  int userId,  String templateTitleEn,  String templateTitleUr,  String title,  String? formAnswersJson,  String status,  int statusId,  bool isPaid, @JsonKey(fromJson: ServerDate.required)  DateTime createdAt, @JsonKey(fromJson: ServerDate.parse)  DateTime? updatedAt, @JsonKey(fromJson: ServerDate.parse)  DateTime? completedAt,  String? storagePath,  String? docxStoragePath,  String? documentHash)?  $default,) {final _that = this;
switch (_that) {
case _DocumentDetailDto() when $default != null:
return $default(_that.userDocumentId,_that.documentGuid,_that.templateId,_that.userId,_that.templateTitleEn,_that.templateTitleUr,_that.title,_that.formAnswersJson,_that.status,_that.statusId,_that.isPaid,_that.createdAt,_that.updatedAt,_that.completedAt,_that.storagePath,_that.docxStoragePath,_that.documentHash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentDetailDto implements DocumentDetailDto {
  const _DocumentDetailDto({required this.userDocumentId, required this.documentGuid, required this.templateId, this.userId = 0, this.templateTitleEn = '', this.templateTitleUr = '', this.title = '', this.formAnswersJson, this.status = 'Draft', this.statusId = 1, this.isPaid = false, @JsonKey(fromJson: ServerDate.required) required this.createdAt, @JsonKey(fromJson: ServerDate.parse) this.updatedAt, @JsonKey(fromJson: ServerDate.parse) this.completedAt, this.storagePath, this.docxStoragePath, this.documentHash});
  factory _DocumentDetailDto.fromJson(Map<String, dynamic> json) => _$DocumentDetailDtoFromJson(json);

@override final  int userDocumentId;
@override final  String documentGuid;
@override final  int templateId;
@override@JsonKey() final  int userId;
@override@JsonKey() final  String templateTitleEn;
@override@JsonKey() final  String templateTitleUr;
@override@JsonKey() final  String title;
@override final  String? formAnswersJson;
@override@JsonKey() final  String status;
@override@JsonKey() final  int statusId;
@override@JsonKey() final  bool isPaid;
@override@JsonKey(fromJson: ServerDate.required) final  DateTime createdAt;
@override@JsonKey(fromJson: ServerDate.parse) final  DateTime? updatedAt;
@override@JsonKey(fromJson: ServerDate.parse) final  DateTime? completedAt;
@override final  String? storagePath;
@override final  String? docxStoragePath;
@override final  String? documentHash;

/// Create a copy of DocumentDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentDetailDtoCopyWith<_DocumentDetailDto> get copyWith => __$DocumentDetailDtoCopyWithImpl<_DocumentDetailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentDetailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentDetailDto&&(identical(other.userDocumentId, userDocumentId) || other.userDocumentId == userDocumentId)&&(identical(other.documentGuid, documentGuid) || other.documentGuid == documentGuid)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.templateTitleEn, templateTitleEn) || other.templateTitleEn == templateTitleEn)&&(identical(other.templateTitleUr, templateTitleUr) || other.templateTitleUr == templateTitleUr)&&(identical(other.title, title) || other.title == title)&&(identical(other.formAnswersJson, formAnswersJson) || other.formAnswersJson == formAnswersJson)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.docxStoragePath, docxStoragePath) || other.docxStoragePath == docxStoragePath)&&(identical(other.documentHash, documentHash) || other.documentHash == documentHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userDocumentId,documentGuid,templateId,userId,templateTitleEn,templateTitleUr,title,formAnswersJson,status,statusId,isPaid,createdAt,updatedAt,completedAt,storagePath,docxStoragePath,documentHash);

@override
String toString() {
  return 'DocumentDetailDto(userDocumentId: $userDocumentId, documentGuid: $documentGuid, templateId: $templateId, userId: $userId, templateTitleEn: $templateTitleEn, templateTitleUr: $templateTitleUr, title: $title, formAnswersJson: $formAnswersJson, status: $status, statusId: $statusId, isPaid: $isPaid, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, storagePath: $storagePath, docxStoragePath: $docxStoragePath, documentHash: $documentHash)';
}


}

/// @nodoc
abstract mixin class _$DocumentDetailDtoCopyWith<$Res> implements $DocumentDetailDtoCopyWith<$Res> {
  factory _$DocumentDetailDtoCopyWith(_DocumentDetailDto value, $Res Function(_DocumentDetailDto) _then) = __$DocumentDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 int userDocumentId, String documentGuid, int templateId, int userId, String templateTitleEn, String templateTitleUr, String title, String? formAnswersJson, String status, int statusId, bool isPaid,@JsonKey(fromJson: ServerDate.required) DateTime createdAt,@JsonKey(fromJson: ServerDate.parse) DateTime? updatedAt,@JsonKey(fromJson: ServerDate.parse) DateTime? completedAt, String? storagePath, String? docxStoragePath, String? documentHash
});




}
/// @nodoc
class __$DocumentDetailDtoCopyWithImpl<$Res>
    implements _$DocumentDetailDtoCopyWith<$Res> {
  __$DocumentDetailDtoCopyWithImpl(this._self, this._then);

  final _DocumentDetailDto _self;
  final $Res Function(_DocumentDetailDto) _then;

/// Create a copy of DocumentDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userDocumentId = null,Object? documentGuid = null,Object? templateId = null,Object? userId = null,Object? templateTitleEn = null,Object? templateTitleUr = null,Object? title = null,Object? formAnswersJson = freezed,Object? status = null,Object? statusId = null,Object? isPaid = null,Object? createdAt = null,Object? updatedAt = freezed,Object? completedAt = freezed,Object? storagePath = freezed,Object? docxStoragePath = freezed,Object? documentHash = freezed,}) {
  return _then(_DocumentDetailDto(
userDocumentId: null == userDocumentId ? _self.userDocumentId : userDocumentId // ignore: cast_nullable_to_non_nullable
as int,documentGuid: null == documentGuid ? _self.documentGuid : documentGuid // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,templateTitleEn: null == templateTitleEn ? _self.templateTitleEn : templateTitleEn // ignore: cast_nullable_to_non_nullable
as String,templateTitleUr: null == templateTitleUr ? _self.templateTitleUr : templateTitleUr // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,formAnswersJson: freezed == formAnswersJson ? _self.formAnswersJson : formAnswersJson // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusId: null == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,storagePath: freezed == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String?,docxStoragePath: freezed == docxStoragePath ? _self.docxStoragePath : docxStoragePath // ignore: cast_nullable_to_non_nullable
as String?,documentHash: freezed == documentHash ? _self.documentHash : documentHash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
