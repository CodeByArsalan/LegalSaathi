// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legal_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LegalDocument {

 int get id;/// The server's `documentGuid` — the name its rendered files are stored
/// under, and the value its download URLs are built from.
 String get guid; int get templateId; String get templateTitleEn; String get templateTitleUr;/// The user's own label for this copy. Empty until one is chosen.
 String get title; DocumentStatus get status; bool get isPaid; DateTime get createdAt; Map<String, String> get answers; String? get storagePath; String? get docxStoragePath; String? get documentHash; DateTime? get updatedAt; DateTime? get completedAt;
/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalDocumentCopyWith<LegalDocument> get copyWith => _$LegalDocumentCopyWithImpl<LegalDocument>(this as LegalDocument, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.guid, guid) || other.guid == guid)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.templateTitleEn, templateTitleEn) || other.templateTitleEn == templateTitleEn)&&(identical(other.templateTitleUr, templateTitleUr) || other.templateTitleUr == templateTitleUr)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.answers, answers)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.docxStoragePath, docxStoragePath) || other.docxStoragePath == docxStoragePath)&&(identical(other.documentHash, documentHash) || other.documentHash == documentHash)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,guid,templateId,templateTitleEn,templateTitleUr,title,status,isPaid,createdAt,const DeepCollectionEquality().hash(answers),storagePath,docxStoragePath,documentHash,updatedAt,completedAt);

@override
String toString() {
  return 'LegalDocument(id: $id, guid: $guid, templateId: $templateId, templateTitleEn: $templateTitleEn, templateTitleUr: $templateTitleUr, title: $title, status: $status, isPaid: $isPaid, createdAt: $createdAt, answers: $answers, storagePath: $storagePath, docxStoragePath: $docxStoragePath, documentHash: $documentHash, updatedAt: $updatedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $LegalDocumentCopyWith<$Res>  {
  factory $LegalDocumentCopyWith(LegalDocument value, $Res Function(LegalDocument) _then) = _$LegalDocumentCopyWithImpl;
@useResult
$Res call({
 int id, String guid, int templateId, String templateTitleEn, String templateTitleUr, String title, DocumentStatus status, bool isPaid, DateTime createdAt, Map<String, String> answers, String? storagePath, String? docxStoragePath, String? documentHash, DateTime? updatedAt, DateTime? completedAt
});




}
/// @nodoc
class _$LegalDocumentCopyWithImpl<$Res>
    implements $LegalDocumentCopyWith<$Res> {
  _$LegalDocumentCopyWithImpl(this._self, this._then);

  final LegalDocument _self;
  final $Res Function(LegalDocument) _then;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? guid = null,Object? templateId = null,Object? templateTitleEn = null,Object? templateTitleUr = null,Object? title = null,Object? status = null,Object? isPaid = null,Object? createdAt = null,Object? answers = null,Object? storagePath = freezed,Object? docxStoragePath = freezed,Object? documentHash = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,guid: null == guid ? _self.guid : guid // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,templateTitleEn: null == templateTitleEn ? _self.templateTitleEn : templateTitleEn // ignore: cast_nullable_to_non_nullable
as String,templateTitleUr: null == templateTitleUr ? _self.templateTitleUr : templateTitleUr // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,storagePath: freezed == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String?,docxStoragePath: freezed == docxStoragePath ? _self.docxStoragePath : docxStoragePath // ignore: cast_nullable_to_non_nullable
as String?,documentHash: freezed == documentHash ? _self.documentHash : documentHash // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LegalDocument].
extension LegalDocumentPatterns on LegalDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegalDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegalDocument value)  $default,){
final _that = this;
switch (_that) {
case _LegalDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegalDocument value)?  $default,){
final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String guid,  int templateId,  String templateTitleEn,  String templateTitleUr,  String title,  DocumentStatus status,  bool isPaid,  DateTime createdAt,  Map<String, String> answers,  String? storagePath,  String? docxStoragePath,  String? documentHash,  DateTime? updatedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
return $default(_that.id,_that.guid,_that.templateId,_that.templateTitleEn,_that.templateTitleUr,_that.title,_that.status,_that.isPaid,_that.createdAt,_that.answers,_that.storagePath,_that.docxStoragePath,_that.documentHash,_that.updatedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String guid,  int templateId,  String templateTitleEn,  String templateTitleUr,  String title,  DocumentStatus status,  bool isPaid,  DateTime createdAt,  Map<String, String> answers,  String? storagePath,  String? docxStoragePath,  String? documentHash,  DateTime? updatedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _LegalDocument():
return $default(_that.id,_that.guid,_that.templateId,_that.templateTitleEn,_that.templateTitleUr,_that.title,_that.status,_that.isPaid,_that.createdAt,_that.answers,_that.storagePath,_that.docxStoragePath,_that.documentHash,_that.updatedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String guid,  int templateId,  String templateTitleEn,  String templateTitleUr,  String title,  DocumentStatus status,  bool isPaid,  DateTime createdAt,  Map<String, String> answers,  String? storagePath,  String? docxStoragePath,  String? documentHash,  DateTime? updatedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _LegalDocument() when $default != null:
return $default(_that.id,_that.guid,_that.templateId,_that.templateTitleEn,_that.templateTitleUr,_that.title,_that.status,_that.isPaid,_that.createdAt,_that.answers,_that.storagePath,_that.docxStoragePath,_that.documentHash,_that.updatedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _LegalDocument implements LegalDocument {
  const _LegalDocument({required this.id, required this.guid, required this.templateId, required this.templateTitleEn, required this.templateTitleUr, required this.title, required this.status, required this.isPaid, required this.createdAt, final  Map<String, String> answers = const <String, String>{}, this.storagePath, this.docxStoragePath, this.documentHash, this.updatedAt, this.completedAt}): _answers = answers;
  

@override final  int id;
/// The server's `documentGuid` — the name its rendered files are stored
/// under, and the value its download URLs are built from.
@override final  String guid;
@override final  int templateId;
@override final  String templateTitleEn;
@override final  String templateTitleUr;
/// The user's own label for this copy. Empty until one is chosen.
@override final  String title;
@override final  DocumentStatus status;
@override final  bool isPaid;
@override final  DateTime createdAt;
 final  Map<String, String> _answers;
@override@JsonKey() Map<String, String> get answers {
  if (_answers is EqualUnmodifiableMapView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answers);
}

@override final  String? storagePath;
@override final  String? docxStoragePath;
@override final  String? documentHash;
@override final  DateTime? updatedAt;
@override final  DateTime? completedAt;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalDocumentCopyWith<_LegalDocument> get copyWith => __$LegalDocumentCopyWithImpl<_LegalDocument>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.guid, guid) || other.guid == guid)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.templateTitleEn, templateTitleEn) || other.templateTitleEn == templateTitleEn)&&(identical(other.templateTitleUr, templateTitleUr) || other.templateTitleUr == templateTitleUr)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._answers, _answers)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.docxStoragePath, docxStoragePath) || other.docxStoragePath == docxStoragePath)&&(identical(other.documentHash, documentHash) || other.documentHash == documentHash)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,guid,templateId,templateTitleEn,templateTitleUr,title,status,isPaid,createdAt,const DeepCollectionEquality().hash(_answers),storagePath,docxStoragePath,documentHash,updatedAt,completedAt);

@override
String toString() {
  return 'LegalDocument(id: $id, guid: $guid, templateId: $templateId, templateTitleEn: $templateTitleEn, templateTitleUr: $templateTitleUr, title: $title, status: $status, isPaid: $isPaid, createdAt: $createdAt, answers: $answers, storagePath: $storagePath, docxStoragePath: $docxStoragePath, documentHash: $documentHash, updatedAt: $updatedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$LegalDocumentCopyWith<$Res> implements $LegalDocumentCopyWith<$Res> {
  factory _$LegalDocumentCopyWith(_LegalDocument value, $Res Function(_LegalDocument) _then) = __$LegalDocumentCopyWithImpl;
@override @useResult
$Res call({
 int id, String guid, int templateId, String templateTitleEn, String templateTitleUr, String title, DocumentStatus status, bool isPaid, DateTime createdAt, Map<String, String> answers, String? storagePath, String? docxStoragePath, String? documentHash, DateTime? updatedAt, DateTime? completedAt
});




}
/// @nodoc
class __$LegalDocumentCopyWithImpl<$Res>
    implements _$LegalDocumentCopyWith<$Res> {
  __$LegalDocumentCopyWithImpl(this._self, this._then);

  final _LegalDocument _self;
  final $Res Function(_LegalDocument) _then;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? guid = null,Object? templateId = null,Object? templateTitleEn = null,Object? templateTitleUr = null,Object? title = null,Object? status = null,Object? isPaid = null,Object? createdAt = null,Object? answers = null,Object? storagePath = freezed,Object? docxStoragePath = freezed,Object? documentHash = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_LegalDocument(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,guid: null == guid ? _self.guid : guid // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,templateTitleEn: null == templateTitleEn ? _self.templateTitleEn : templateTitleEn // ignore: cast_nullable_to_non_nullable
as String,templateTitleUr: null == templateTitleUr ? _self.templateTitleUr : templateTitleUr // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,storagePath: freezed == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String?,docxStoragePath: freezed == docxStoragePath ? _self.docxStoragePath : docxStoragePath // ignore: cast_nullable_to_non_nullable
as String?,documentHash: freezed == documentHash ? _self.documentHash : documentHash // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
