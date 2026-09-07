// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generated_document_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeneratedDocumentDto {

 int get userDocumentId; String get documentGuid; String get status; String? get storagePath; String? get docxStoragePath; String? get documentHash; String? get pdfDownloadUrl; String? get docxDownloadUrl;
/// Create a copy of GeneratedDocumentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratedDocumentDtoCopyWith<GeneratedDocumentDto> get copyWith => _$GeneratedDocumentDtoCopyWithImpl<GeneratedDocumentDto>(this as GeneratedDocumentDto, _$identity);

  /// Serializes this GeneratedDocumentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratedDocumentDto&&(identical(other.userDocumentId, userDocumentId) || other.userDocumentId == userDocumentId)&&(identical(other.documentGuid, documentGuid) || other.documentGuid == documentGuid)&&(identical(other.status, status) || other.status == status)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.docxStoragePath, docxStoragePath) || other.docxStoragePath == docxStoragePath)&&(identical(other.documentHash, documentHash) || other.documentHash == documentHash)&&(identical(other.pdfDownloadUrl, pdfDownloadUrl) || other.pdfDownloadUrl == pdfDownloadUrl)&&(identical(other.docxDownloadUrl, docxDownloadUrl) || other.docxDownloadUrl == docxDownloadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userDocumentId,documentGuid,status,storagePath,docxStoragePath,documentHash,pdfDownloadUrl,docxDownloadUrl);

@override
String toString() {
  return 'GeneratedDocumentDto(userDocumentId: $userDocumentId, documentGuid: $documentGuid, status: $status, storagePath: $storagePath, docxStoragePath: $docxStoragePath, documentHash: $documentHash, pdfDownloadUrl: $pdfDownloadUrl, docxDownloadUrl: $docxDownloadUrl)';
}


}

/// @nodoc
abstract mixin class $GeneratedDocumentDtoCopyWith<$Res>  {
  factory $GeneratedDocumentDtoCopyWith(GeneratedDocumentDto value, $Res Function(GeneratedDocumentDto) _then) = _$GeneratedDocumentDtoCopyWithImpl;
@useResult
$Res call({
 int userDocumentId, String documentGuid, String status, String? storagePath, String? docxStoragePath, String? documentHash, String? pdfDownloadUrl, String? docxDownloadUrl
});




}
/// @nodoc
class _$GeneratedDocumentDtoCopyWithImpl<$Res>
    implements $GeneratedDocumentDtoCopyWith<$Res> {
  _$GeneratedDocumentDtoCopyWithImpl(this._self, this._then);

  final GeneratedDocumentDto _self;
  final $Res Function(GeneratedDocumentDto) _then;

/// Create a copy of GeneratedDocumentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userDocumentId = null,Object? documentGuid = null,Object? status = null,Object? storagePath = freezed,Object? docxStoragePath = freezed,Object? documentHash = freezed,Object? pdfDownloadUrl = freezed,Object? docxDownloadUrl = freezed,}) {
  return _then(_self.copyWith(
userDocumentId: null == userDocumentId ? _self.userDocumentId : userDocumentId // ignore: cast_nullable_to_non_nullable
as int,documentGuid: null == documentGuid ? _self.documentGuid : documentGuid // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,storagePath: freezed == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String?,docxStoragePath: freezed == docxStoragePath ? _self.docxStoragePath : docxStoragePath // ignore: cast_nullable_to_non_nullable
as String?,documentHash: freezed == documentHash ? _self.documentHash : documentHash // ignore: cast_nullable_to_non_nullable
as String?,pdfDownloadUrl: freezed == pdfDownloadUrl ? _self.pdfDownloadUrl : pdfDownloadUrl // ignore: cast_nullable_to_non_nullable
as String?,docxDownloadUrl: freezed == docxDownloadUrl ? _self.docxDownloadUrl : docxDownloadUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneratedDocumentDto].
extension GeneratedDocumentDtoPatterns on GeneratedDocumentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneratedDocumentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneratedDocumentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneratedDocumentDto value)  $default,){
final _that = this;
switch (_that) {
case _GeneratedDocumentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneratedDocumentDto value)?  $default,){
final _that = this;
switch (_that) {
case _GeneratedDocumentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userDocumentId,  String documentGuid,  String status,  String? storagePath,  String? docxStoragePath,  String? documentHash,  String? pdfDownloadUrl,  String? docxDownloadUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratedDocumentDto() when $default != null:
return $default(_that.userDocumentId,_that.documentGuid,_that.status,_that.storagePath,_that.docxStoragePath,_that.documentHash,_that.pdfDownloadUrl,_that.docxDownloadUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userDocumentId,  String documentGuid,  String status,  String? storagePath,  String? docxStoragePath,  String? documentHash,  String? pdfDownloadUrl,  String? docxDownloadUrl)  $default,) {final _that = this;
switch (_that) {
case _GeneratedDocumentDto():
return $default(_that.userDocumentId,_that.documentGuid,_that.status,_that.storagePath,_that.docxStoragePath,_that.documentHash,_that.pdfDownloadUrl,_that.docxDownloadUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userDocumentId,  String documentGuid,  String status,  String? storagePath,  String? docxStoragePath,  String? documentHash,  String? pdfDownloadUrl,  String? docxDownloadUrl)?  $default,) {final _that = this;
switch (_that) {
case _GeneratedDocumentDto() when $default != null:
return $default(_that.userDocumentId,_that.documentGuid,_that.status,_that.storagePath,_that.docxStoragePath,_that.documentHash,_that.pdfDownloadUrl,_that.docxDownloadUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeneratedDocumentDto implements GeneratedDocumentDto {
  const _GeneratedDocumentDto({required this.userDocumentId, required this.documentGuid, this.status = 'Completed', this.storagePath, this.docxStoragePath, this.documentHash, this.pdfDownloadUrl, this.docxDownloadUrl});
  factory _GeneratedDocumentDto.fromJson(Map<String, dynamic> json) => _$GeneratedDocumentDtoFromJson(json);

@override final  int userDocumentId;
@override final  String documentGuid;
@override@JsonKey() final  String status;
@override final  String? storagePath;
@override final  String? docxStoragePath;
@override final  String? documentHash;
@override final  String? pdfDownloadUrl;
@override final  String? docxDownloadUrl;

/// Create a copy of GeneratedDocumentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratedDocumentDtoCopyWith<_GeneratedDocumentDto> get copyWith => __$GeneratedDocumentDtoCopyWithImpl<_GeneratedDocumentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeneratedDocumentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratedDocumentDto&&(identical(other.userDocumentId, userDocumentId) || other.userDocumentId == userDocumentId)&&(identical(other.documentGuid, documentGuid) || other.documentGuid == documentGuid)&&(identical(other.status, status) || other.status == status)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.docxStoragePath, docxStoragePath) || other.docxStoragePath == docxStoragePath)&&(identical(other.documentHash, documentHash) || other.documentHash == documentHash)&&(identical(other.pdfDownloadUrl, pdfDownloadUrl) || other.pdfDownloadUrl == pdfDownloadUrl)&&(identical(other.docxDownloadUrl, docxDownloadUrl) || other.docxDownloadUrl == docxDownloadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userDocumentId,documentGuid,status,storagePath,docxStoragePath,documentHash,pdfDownloadUrl,docxDownloadUrl);

@override
String toString() {
  return 'GeneratedDocumentDto(userDocumentId: $userDocumentId, documentGuid: $documentGuid, status: $status, storagePath: $storagePath, docxStoragePath: $docxStoragePath, documentHash: $documentHash, pdfDownloadUrl: $pdfDownloadUrl, docxDownloadUrl: $docxDownloadUrl)';
}


}

/// @nodoc
abstract mixin class _$GeneratedDocumentDtoCopyWith<$Res> implements $GeneratedDocumentDtoCopyWith<$Res> {
  factory _$GeneratedDocumentDtoCopyWith(_GeneratedDocumentDto value, $Res Function(_GeneratedDocumentDto) _then) = __$GeneratedDocumentDtoCopyWithImpl;
@override @useResult
$Res call({
 int userDocumentId, String documentGuid, String status, String? storagePath, String? docxStoragePath, String? documentHash, String? pdfDownloadUrl, String? docxDownloadUrl
});




}
/// @nodoc
class __$GeneratedDocumentDtoCopyWithImpl<$Res>
    implements _$GeneratedDocumentDtoCopyWith<$Res> {
  __$GeneratedDocumentDtoCopyWithImpl(this._self, this._then);

  final _GeneratedDocumentDto _self;
  final $Res Function(_GeneratedDocumentDto) _then;

/// Create a copy of GeneratedDocumentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userDocumentId = null,Object? documentGuid = null,Object? status = null,Object? storagePath = freezed,Object? docxStoragePath = freezed,Object? documentHash = freezed,Object? pdfDownloadUrl = freezed,Object? docxDownloadUrl = freezed,}) {
  return _then(_GeneratedDocumentDto(
userDocumentId: null == userDocumentId ? _self.userDocumentId : userDocumentId // ignore: cast_nullable_to_non_nullable
as int,documentGuid: null == documentGuid ? _self.documentGuid : documentGuid // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,storagePath: freezed == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String?,docxStoragePath: freezed == docxStoragePath ? _self.docxStoragePath : docxStoragePath // ignore: cast_nullable_to_non_nullable
as String?,documentHash: freezed == documentHash ? _self.documentHash : documentHash // ignore: cast_nullable_to_non_nullable
as String?,pdfDownloadUrl: freezed == pdfDownloadUrl ? _self.pdfDownloadUrl : pdfDownloadUrl // ignore: cast_nullable_to_non_nullable
as String?,docxDownloadUrl: freezed == docxDownloadUrl ? _self.docxDownloadUrl : docxDownloadUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
