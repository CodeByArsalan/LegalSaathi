// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_preview_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DocumentPreviewState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentPreviewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocumentPreviewState()';
}


}

/// @nodoc
class $DocumentPreviewStateCopyWith<$Res>  {
$DocumentPreviewStateCopyWith(DocumentPreviewState _, $Res Function(DocumentPreviewState) __);
}


/// Adds pattern-matching-related methods to [DocumentPreviewState].
extension DocumentPreviewStatePatterns on DocumentPreviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DocumentPreviewLoading value)?  loading,TResult Function( DocumentPreviewReady value)?  ready,TResult Function( DocumentPreviewFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DocumentPreviewLoading() when loading != null:
return loading(_that);case DocumentPreviewReady() when ready != null:
return ready(_that);case DocumentPreviewFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DocumentPreviewLoading value)  loading,required TResult Function( DocumentPreviewReady value)  ready,required TResult Function( DocumentPreviewFailure value)  failure,}){
final _that = this;
switch (_that) {
case DocumentPreviewLoading():
return loading(_that);case DocumentPreviewReady():
return ready(_that);case DocumentPreviewFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DocumentPreviewLoading value)?  loading,TResult? Function( DocumentPreviewReady value)?  ready,TResult? Function( DocumentPreviewFailure value)?  failure,}){
final _that = this;
switch (_that) {
case DocumentPreviewLoading() when loading != null:
return loading(_that);case DocumentPreviewReady() when ready != null:
return ready(_that);case DocumentPreviewFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( LegalDocument document,  List<DocumentSignature> signatures,  DocumentFormat? busyFormat,  Failure? failure,  int errorTick)?  ready,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DocumentPreviewLoading() when loading != null:
return loading();case DocumentPreviewReady() when ready != null:
return ready(_that.document,_that.signatures,_that.busyFormat,_that.failure,_that.errorTick);case DocumentPreviewFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( LegalDocument document,  List<DocumentSignature> signatures,  DocumentFormat? busyFormat,  Failure? failure,  int errorTick)  ready,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case DocumentPreviewLoading():
return loading();case DocumentPreviewReady():
return ready(_that.document,_that.signatures,_that.busyFormat,_that.failure,_that.errorTick);case DocumentPreviewFailure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( LegalDocument document,  List<DocumentSignature> signatures,  DocumentFormat? busyFormat,  Failure? failure,  int errorTick)?  ready,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case DocumentPreviewLoading() when loading != null:
return loading();case DocumentPreviewReady() when ready != null:
return ready(_that.document,_that.signatures,_that.busyFormat,_that.failure,_that.errorTick);case DocumentPreviewFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class DocumentPreviewLoading implements DocumentPreviewState {
  const DocumentPreviewLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentPreviewLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocumentPreviewState.loading()';
}


}




/// @nodoc


class DocumentPreviewReady implements DocumentPreviewState {
  const DocumentPreviewReady({required this.document, final  List<DocumentSignature> signatures = const <DocumentSignature>[], this.busyFormat, this.failure, this.errorTick = 0}): _signatures = signatures;
  

 final  LegalDocument document;
 final  List<DocumentSignature> _signatures;
@JsonKey() List<DocumentSignature> get signatures {
  if (_signatures is EqualUnmodifiableListView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_signatures);
}

 final  DocumentFormat? busyFormat;
 final  Failure? failure;
@JsonKey() final  int errorTick;

/// Create a copy of DocumentPreviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentPreviewReadyCopyWith<DocumentPreviewReady> get copyWith => _$DocumentPreviewReadyCopyWithImpl<DocumentPreviewReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentPreviewReady&&(identical(other.document, document) || other.document == document)&&const DeepCollectionEquality().equals(other._signatures, _signatures)&&(identical(other.busyFormat, busyFormat) || other.busyFormat == busyFormat)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.errorTick, errorTick) || other.errorTick == errorTick));
}


@override
int get hashCode => Object.hash(runtimeType,document,const DeepCollectionEquality().hash(_signatures),busyFormat,failure,errorTick);

@override
String toString() {
  return 'DocumentPreviewState.ready(document: $document, signatures: $signatures, busyFormat: $busyFormat, failure: $failure, errorTick: $errorTick)';
}


}

/// @nodoc
abstract mixin class $DocumentPreviewReadyCopyWith<$Res> implements $DocumentPreviewStateCopyWith<$Res> {
  factory $DocumentPreviewReadyCopyWith(DocumentPreviewReady value, $Res Function(DocumentPreviewReady) _then) = _$DocumentPreviewReadyCopyWithImpl;
@useResult
$Res call({
 LegalDocument document, List<DocumentSignature> signatures, DocumentFormat? busyFormat, Failure? failure, int errorTick
});


$LegalDocumentCopyWith<$Res> get document;

}
/// @nodoc
class _$DocumentPreviewReadyCopyWithImpl<$Res>
    implements $DocumentPreviewReadyCopyWith<$Res> {
  _$DocumentPreviewReadyCopyWithImpl(this._self, this._then);

  final DocumentPreviewReady _self;
  final $Res Function(DocumentPreviewReady) _then;

/// Create a copy of DocumentPreviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? document = null,Object? signatures = null,Object? busyFormat = freezed,Object? failure = freezed,Object? errorTick = null,}) {
  return _then(DocumentPreviewReady(
document: null == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as LegalDocument,signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<DocumentSignature>,busyFormat: freezed == busyFormat ? _self.busyFormat : busyFormat // ignore: cast_nullable_to_non_nullable
as DocumentFormat?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,errorTick: null == errorTick ? _self.errorTick : errorTick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DocumentPreviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalDocumentCopyWith<$Res> get document {
  
  return $LegalDocumentCopyWith<$Res>(_self.document, (value) {
    return _then(_self.copyWith(document: value));
  });
}
}

/// @nodoc


class DocumentPreviewFailure implements DocumentPreviewState {
  const DocumentPreviewFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of DocumentPreviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentPreviewFailureCopyWith<DocumentPreviewFailure> get copyWith => _$DocumentPreviewFailureCopyWithImpl<DocumentPreviewFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentPreviewFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'DocumentPreviewState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DocumentPreviewFailureCopyWith<$Res> implements $DocumentPreviewStateCopyWith<$Res> {
  factory $DocumentPreviewFailureCopyWith(DocumentPreviewFailure value, $Res Function(DocumentPreviewFailure) _then) = _$DocumentPreviewFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$DocumentPreviewFailureCopyWithImpl<$Res>
    implements $DocumentPreviewFailureCopyWith<$Res> {
  _$DocumentPreviewFailureCopyWithImpl(this._self, this._then);

  final DocumentPreviewFailure _self;
  final $Res Function(DocumentPreviewFailure) _then;

/// Create a copy of DocumentPreviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(DocumentPreviewFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
