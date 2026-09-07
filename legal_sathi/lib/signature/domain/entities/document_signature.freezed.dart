// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_signature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DocumentSignature {

 int get id; int get documentId; String get signerName; String get signerCnic; String get signerRole; String get signatureUri; bool get isOtpVerified; DateTime get signedAt; String? get signerEmail; String? get signerPhone; String? get ipAddress;
/// Create a copy of DocumentSignature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentSignatureCopyWith<DocumentSignature> get copyWith => _$DocumentSignatureCopyWithImpl<DocumentSignature>(this as DocumentSignature, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentSignature&&(identical(other.id, id) || other.id == id)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerCnic, signerCnic) || other.signerCnic == signerCnic)&&(identical(other.signerRole, signerRole) || other.signerRole == signerRole)&&(identical(other.signatureUri, signatureUri) || other.signatureUri == signatureUri)&&(identical(other.isOtpVerified, isOtpVerified) || other.isOtpVerified == isOtpVerified)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt)&&(identical(other.signerEmail, signerEmail) || other.signerEmail == signerEmail)&&(identical(other.signerPhone, signerPhone) || other.signerPhone == signerPhone)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress));
}


@override
int get hashCode => Object.hash(runtimeType,id,documentId,signerName,signerCnic,signerRole,signatureUri,isOtpVerified,signedAt,signerEmail,signerPhone,ipAddress);

@override
String toString() {
  return 'DocumentSignature(id: $id, documentId: $documentId, signerName: $signerName, signerCnic: $signerCnic, signerRole: $signerRole, signatureUri: $signatureUri, isOtpVerified: $isOtpVerified, signedAt: $signedAt, signerEmail: $signerEmail, signerPhone: $signerPhone, ipAddress: $ipAddress)';
}


}

/// @nodoc
abstract mixin class $DocumentSignatureCopyWith<$Res>  {
  factory $DocumentSignatureCopyWith(DocumentSignature value, $Res Function(DocumentSignature) _then) = _$DocumentSignatureCopyWithImpl;
@useResult
$Res call({
 int id, int documentId, String signerName, String signerCnic, String signerRole, String signatureUri, bool isOtpVerified, DateTime signedAt, String? signerEmail, String? signerPhone, String? ipAddress
});




}
/// @nodoc
class _$DocumentSignatureCopyWithImpl<$Res>
    implements $DocumentSignatureCopyWith<$Res> {
  _$DocumentSignatureCopyWithImpl(this._self, this._then);

  final DocumentSignature _self;
  final $Res Function(DocumentSignature) _then;

/// Create a copy of DocumentSignature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? documentId = null,Object? signerName = null,Object? signerCnic = null,Object? signerRole = null,Object? signatureUri = null,Object? isOtpVerified = null,Object? signedAt = null,Object? signerEmail = freezed,Object? signerPhone = freezed,Object? ipAddress = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as int,signerName: null == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String,signerCnic: null == signerCnic ? _self.signerCnic : signerCnic // ignore: cast_nullable_to_non_nullable
as String,signerRole: null == signerRole ? _self.signerRole : signerRole // ignore: cast_nullable_to_non_nullable
as String,signatureUri: null == signatureUri ? _self.signatureUri : signatureUri // ignore: cast_nullable_to_non_nullable
as String,isOtpVerified: null == isOtpVerified ? _self.isOtpVerified : isOtpVerified // ignore: cast_nullable_to_non_nullable
as bool,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,signerEmail: freezed == signerEmail ? _self.signerEmail : signerEmail // ignore: cast_nullable_to_non_nullable
as String?,signerPhone: freezed == signerPhone ? _self.signerPhone : signerPhone // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentSignature].
extension DocumentSignaturePatterns on DocumentSignature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentSignature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentSignature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentSignature value)  $default,){
final _that = this;
switch (_that) {
case _DocumentSignature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentSignature value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentSignature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int documentId,  String signerName,  String signerCnic,  String signerRole,  String signatureUri,  bool isOtpVerified,  DateTime signedAt,  String? signerEmail,  String? signerPhone,  String? ipAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentSignature() when $default != null:
return $default(_that.id,_that.documentId,_that.signerName,_that.signerCnic,_that.signerRole,_that.signatureUri,_that.isOtpVerified,_that.signedAt,_that.signerEmail,_that.signerPhone,_that.ipAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int documentId,  String signerName,  String signerCnic,  String signerRole,  String signatureUri,  bool isOtpVerified,  DateTime signedAt,  String? signerEmail,  String? signerPhone,  String? ipAddress)  $default,) {final _that = this;
switch (_that) {
case _DocumentSignature():
return $default(_that.id,_that.documentId,_that.signerName,_that.signerCnic,_that.signerRole,_that.signatureUri,_that.isOtpVerified,_that.signedAt,_that.signerEmail,_that.signerPhone,_that.ipAddress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int documentId,  String signerName,  String signerCnic,  String signerRole,  String signatureUri,  bool isOtpVerified,  DateTime signedAt,  String? signerEmail,  String? signerPhone,  String? ipAddress)?  $default,) {final _that = this;
switch (_that) {
case _DocumentSignature() when $default != null:
return $default(_that.id,_that.documentId,_that.signerName,_that.signerCnic,_that.signerRole,_that.signatureUri,_that.isOtpVerified,_that.signedAt,_that.signerEmail,_that.signerPhone,_that.ipAddress);case _:
  return null;

}
}

}

/// @nodoc


class _DocumentSignature implements DocumentSignature {
  const _DocumentSignature({required this.id, required this.documentId, required this.signerName, required this.signerCnic, required this.signerRole, required this.signatureUri, required this.isOtpVerified, required this.signedAt, this.signerEmail, this.signerPhone, this.ipAddress});
  

@override final  int id;
@override final  int documentId;
@override final  String signerName;
@override final  String signerCnic;
@override final  String signerRole;
@override final  String signatureUri;
@override final  bool isOtpVerified;
@override final  DateTime signedAt;
@override final  String? signerEmail;
@override final  String? signerPhone;
@override final  String? ipAddress;

/// Create a copy of DocumentSignature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentSignatureCopyWith<_DocumentSignature> get copyWith => __$DocumentSignatureCopyWithImpl<_DocumentSignature>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentSignature&&(identical(other.id, id) || other.id == id)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerCnic, signerCnic) || other.signerCnic == signerCnic)&&(identical(other.signerRole, signerRole) || other.signerRole == signerRole)&&(identical(other.signatureUri, signatureUri) || other.signatureUri == signatureUri)&&(identical(other.isOtpVerified, isOtpVerified) || other.isOtpVerified == isOtpVerified)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt)&&(identical(other.signerEmail, signerEmail) || other.signerEmail == signerEmail)&&(identical(other.signerPhone, signerPhone) || other.signerPhone == signerPhone)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress));
}


@override
int get hashCode => Object.hash(runtimeType,id,documentId,signerName,signerCnic,signerRole,signatureUri,isOtpVerified,signedAt,signerEmail,signerPhone,ipAddress);

@override
String toString() {
  return 'DocumentSignature(id: $id, documentId: $documentId, signerName: $signerName, signerCnic: $signerCnic, signerRole: $signerRole, signatureUri: $signatureUri, isOtpVerified: $isOtpVerified, signedAt: $signedAt, signerEmail: $signerEmail, signerPhone: $signerPhone, ipAddress: $ipAddress)';
}


}

/// @nodoc
abstract mixin class _$DocumentSignatureCopyWith<$Res> implements $DocumentSignatureCopyWith<$Res> {
  factory _$DocumentSignatureCopyWith(_DocumentSignature value, $Res Function(_DocumentSignature) _then) = __$DocumentSignatureCopyWithImpl;
@override @useResult
$Res call({
 int id, int documentId, String signerName, String signerCnic, String signerRole, String signatureUri, bool isOtpVerified, DateTime signedAt, String? signerEmail, String? signerPhone, String? ipAddress
});




}
/// @nodoc
class __$DocumentSignatureCopyWithImpl<$Res>
    implements _$DocumentSignatureCopyWith<$Res> {
  __$DocumentSignatureCopyWithImpl(this._self, this._then);

  final _DocumentSignature _self;
  final $Res Function(_DocumentSignature) _then;

/// Create a copy of DocumentSignature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? documentId = null,Object? signerName = null,Object? signerCnic = null,Object? signerRole = null,Object? signatureUri = null,Object? isOtpVerified = null,Object? signedAt = null,Object? signerEmail = freezed,Object? signerPhone = freezed,Object? ipAddress = freezed,}) {
  return _then(_DocumentSignature(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as int,signerName: null == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String,signerCnic: null == signerCnic ? _self.signerCnic : signerCnic // ignore: cast_nullable_to_non_nullable
as String,signerRole: null == signerRole ? _self.signerRole : signerRole // ignore: cast_nullable_to_non_nullable
as String,signatureUri: null == signatureUri ? _self.signatureUri : signatureUri // ignore: cast_nullable_to_non_nullable
as String,isOtpVerified: null == isOtpVerified ? _self.isOtpVerified : isOtpVerified // ignore: cast_nullable_to_non_nullable
as bool,signedAt: null == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime,signerEmail: freezed == signerEmail ? _self.signerEmail : signerEmail // ignore: cast_nullable_to_non_nullable
as String?,signerPhone: freezed == signerPhone ? _self.signerPhone : signerPhone // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
