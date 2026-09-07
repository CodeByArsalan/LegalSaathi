// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signature_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignatureState {

 int get documentId; SignatureStep get step; bool get isSendingCode; bool get isSigning;/// The identity the code was sent to. Submitting reuses it rather than
/// re-reading the form, so the signature cannot name a different contact
/// than the one the code was verified against.
 SignerIdentity? get signer; SigningOtp? get ticket; DocumentSignature? get signed; Failure? get failure;
/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureStateCopyWith<SignatureState> get copyWith => _$SignatureStateCopyWithImpl<SignatureState>(this as SignatureState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureState&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.step, step) || other.step == step)&&(identical(other.isSendingCode, isSendingCode) || other.isSendingCode == isSendingCode)&&(identical(other.isSigning, isSigning) || other.isSigning == isSigning)&&(identical(other.signer, signer) || other.signer == signer)&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.signed, signed) || other.signed == signed)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,documentId,step,isSendingCode,isSigning,signer,ticket,signed,failure);

@override
String toString() {
  return 'SignatureState(documentId: $documentId, step: $step, isSendingCode: $isSendingCode, isSigning: $isSigning, signer: $signer, ticket: $ticket, signed: $signed, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $SignatureStateCopyWith<$Res>  {
  factory $SignatureStateCopyWith(SignatureState value, $Res Function(SignatureState) _then) = _$SignatureStateCopyWithImpl;
@useResult
$Res call({
 int documentId, SignatureStep step, bool isSendingCode, bool isSigning, SignerIdentity? signer, SigningOtp? ticket, DocumentSignature? signed, Failure? failure
});


$SignerIdentityCopyWith<$Res>? get signer;$SigningOtpCopyWith<$Res>? get ticket;$DocumentSignatureCopyWith<$Res>? get signed;

}
/// @nodoc
class _$SignatureStateCopyWithImpl<$Res>
    implements $SignatureStateCopyWith<$Res> {
  _$SignatureStateCopyWithImpl(this._self, this._then);

  final SignatureState _self;
  final $Res Function(SignatureState) _then;

/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documentId = null,Object? step = null,Object? isSendingCode = null,Object? isSigning = null,Object? signer = freezed,Object? ticket = freezed,Object? signed = freezed,Object? failure = freezed,}) {
  return _then(_self.copyWith(
documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as int,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SignatureStep,isSendingCode: null == isSendingCode ? _self.isSendingCode : isSendingCode // ignore: cast_nullable_to_non_nullable
as bool,isSigning: null == isSigning ? _self.isSigning : isSigning // ignore: cast_nullable_to_non_nullable
as bool,signer: freezed == signer ? _self.signer : signer // ignore: cast_nullable_to_non_nullable
as SignerIdentity?,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as SigningOtp?,signed: freezed == signed ? _self.signed : signed // ignore: cast_nullable_to_non_nullable
as DocumentSignature?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignerIdentityCopyWith<$Res>? get signer {
    if (_self.signer == null) {
    return null;
  }

  return $SignerIdentityCopyWith<$Res>(_self.signer!, (value) {
    return _then(_self.copyWith(signer: value));
  });
}/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SigningOtpCopyWith<$Res>? get ticket {
    if (_self.ticket == null) {
    return null;
  }

  return $SigningOtpCopyWith<$Res>(_self.ticket!, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentSignatureCopyWith<$Res>? get signed {
    if (_self.signed == null) {
    return null;
  }

  return $DocumentSignatureCopyWith<$Res>(_self.signed!, (value) {
    return _then(_self.copyWith(signed: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignatureState].
extension SignatureStatePatterns on SignatureState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignatureState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignatureState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignatureState value)  $default,){
final _that = this;
switch (_that) {
case _SignatureState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignatureState value)?  $default,){
final _that = this;
switch (_that) {
case _SignatureState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int documentId,  SignatureStep step,  bool isSendingCode,  bool isSigning,  SignerIdentity? signer,  SigningOtp? ticket,  DocumentSignature? signed,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignatureState() when $default != null:
return $default(_that.documentId,_that.step,_that.isSendingCode,_that.isSigning,_that.signer,_that.ticket,_that.signed,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int documentId,  SignatureStep step,  bool isSendingCode,  bool isSigning,  SignerIdentity? signer,  SigningOtp? ticket,  DocumentSignature? signed,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _SignatureState():
return $default(_that.documentId,_that.step,_that.isSendingCode,_that.isSigning,_that.signer,_that.ticket,_that.signed,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int documentId,  SignatureStep step,  bool isSendingCode,  bool isSigning,  SignerIdentity? signer,  SigningOtp? ticket,  DocumentSignature? signed,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _SignatureState() when $default != null:
return $default(_that.documentId,_that.step,_that.isSendingCode,_that.isSigning,_that.signer,_that.ticket,_that.signed,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _SignatureState implements SignatureState {
  const _SignatureState({required this.documentId, this.step = SignatureStep.capture, this.isSendingCode = false, this.isSigning = false, this.signer, this.ticket, this.signed, this.failure});
  

@override final  int documentId;
@override@JsonKey() final  SignatureStep step;
@override@JsonKey() final  bool isSendingCode;
@override@JsonKey() final  bool isSigning;
/// The identity the code was sent to. Submitting reuses it rather than
/// re-reading the form, so the signature cannot name a different contact
/// than the one the code was verified against.
@override final  SignerIdentity? signer;
@override final  SigningOtp? ticket;
@override final  DocumentSignature? signed;
@override final  Failure? failure;

/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureStateCopyWith<_SignatureState> get copyWith => __$SignatureStateCopyWithImpl<_SignatureState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignatureState&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.step, step) || other.step == step)&&(identical(other.isSendingCode, isSendingCode) || other.isSendingCode == isSendingCode)&&(identical(other.isSigning, isSigning) || other.isSigning == isSigning)&&(identical(other.signer, signer) || other.signer == signer)&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.signed, signed) || other.signed == signed)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,documentId,step,isSendingCode,isSigning,signer,ticket,signed,failure);

@override
String toString() {
  return 'SignatureState(documentId: $documentId, step: $step, isSendingCode: $isSendingCode, isSigning: $isSigning, signer: $signer, ticket: $ticket, signed: $signed, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$SignatureStateCopyWith<$Res> implements $SignatureStateCopyWith<$Res> {
  factory _$SignatureStateCopyWith(_SignatureState value, $Res Function(_SignatureState) _then) = __$SignatureStateCopyWithImpl;
@override @useResult
$Res call({
 int documentId, SignatureStep step, bool isSendingCode, bool isSigning, SignerIdentity? signer, SigningOtp? ticket, DocumentSignature? signed, Failure? failure
});


@override $SignerIdentityCopyWith<$Res>? get signer;@override $SigningOtpCopyWith<$Res>? get ticket;@override $DocumentSignatureCopyWith<$Res>? get signed;

}
/// @nodoc
class __$SignatureStateCopyWithImpl<$Res>
    implements _$SignatureStateCopyWith<$Res> {
  __$SignatureStateCopyWithImpl(this._self, this._then);

  final _SignatureState _self;
  final $Res Function(_SignatureState) _then;

/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documentId = null,Object? step = null,Object? isSendingCode = null,Object? isSigning = null,Object? signer = freezed,Object? ticket = freezed,Object? signed = freezed,Object? failure = freezed,}) {
  return _then(_SignatureState(
documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as int,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SignatureStep,isSendingCode: null == isSendingCode ? _self.isSendingCode : isSendingCode // ignore: cast_nullable_to_non_nullable
as bool,isSigning: null == isSigning ? _self.isSigning : isSigning // ignore: cast_nullable_to_non_nullable
as bool,signer: freezed == signer ? _self.signer : signer // ignore: cast_nullable_to_non_nullable
as SignerIdentity?,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as SigningOtp?,signed: freezed == signed ? _self.signed : signed // ignore: cast_nullable_to_non_nullable
as DocumentSignature?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignerIdentityCopyWith<$Res>? get signer {
    if (_self.signer == null) {
    return null;
  }

  return $SignerIdentityCopyWith<$Res>(_self.signer!, (value) {
    return _then(_self.copyWith(signer: value));
  });
}/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SigningOtpCopyWith<$Res>? get ticket {
    if (_self.ticket == null) {
    return null;
  }

  return $SigningOtpCopyWith<$Res>(_self.ticket!, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentSignatureCopyWith<$Res>? get signed {
    if (_self.signed == null) {
    return null;
  }

  return $DocumentSignatureCopyWith<$Res>(_self.signed!, (value) {
    return _then(_self.copyWith(signed: value));
  });
}
}

// dart format on
