// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_builder_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DocumentBuilderState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentBuilderState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocumentBuilderState()';
}


}

/// @nodoc
class $DocumentBuilderStateCopyWith<$Res>  {
$DocumentBuilderStateCopyWith(DocumentBuilderState _, $Res Function(DocumentBuilderState) __);
}


/// Adds pattern-matching-related methods to [DocumentBuilderState].
extension DocumentBuilderStatePatterns on DocumentBuilderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DocumentBuilderLoading value)?  loading,TResult Function( DocumentBuilderReady value)?  ready,TResult Function( DocumentBuilderFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DocumentBuilderLoading() when loading != null:
return loading(_that);case DocumentBuilderReady() when ready != null:
return ready(_that);case DocumentBuilderFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DocumentBuilderLoading value)  loading,required TResult Function( DocumentBuilderReady value)  ready,required TResult Function( DocumentBuilderFailure value)  failure,}){
final _that = this;
switch (_that) {
case DocumentBuilderLoading():
return loading(_that);case DocumentBuilderReady():
return ready(_that);case DocumentBuilderFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DocumentBuilderLoading value)?  loading,TResult? Function( DocumentBuilderReady value)?  ready,TResult? Function( DocumentBuilderFailure value)?  failure,}){
final _that = this;
switch (_that) {
case DocumentBuilderLoading() when loading != null:
return loading(_that);case DocumentBuilderReady() when ready != null:
return ready(_that);case DocumentBuilderFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( LegalTemplate template,  List<List<TemplateField>> steps,  LegalDocument? document,  DocumentGeneration? generation,  int currentStep,  Map<String, String> answers,  bool saving,  int invalidTick,  int draftTick,  int errorTick,  Failure? error)?  ready,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DocumentBuilderLoading() when loading != null:
return loading();case DocumentBuilderReady() when ready != null:
return ready(_that.template,_that.steps,_that.document,_that.generation,_that.currentStep,_that.answers,_that.saving,_that.invalidTick,_that.draftTick,_that.errorTick,_that.error);case DocumentBuilderFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( LegalTemplate template,  List<List<TemplateField>> steps,  LegalDocument? document,  DocumentGeneration? generation,  int currentStep,  Map<String, String> answers,  bool saving,  int invalidTick,  int draftTick,  int errorTick,  Failure? error)  ready,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case DocumentBuilderLoading():
return loading();case DocumentBuilderReady():
return ready(_that.template,_that.steps,_that.document,_that.generation,_that.currentStep,_that.answers,_that.saving,_that.invalidTick,_that.draftTick,_that.errorTick,_that.error);case DocumentBuilderFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( LegalTemplate template,  List<List<TemplateField>> steps,  LegalDocument? document,  DocumentGeneration? generation,  int currentStep,  Map<String, String> answers,  bool saving,  int invalidTick,  int draftTick,  int errorTick,  Failure? error)?  ready,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case DocumentBuilderLoading() when loading != null:
return loading();case DocumentBuilderReady() when ready != null:
return ready(_that.template,_that.steps,_that.document,_that.generation,_that.currentStep,_that.answers,_that.saving,_that.invalidTick,_that.draftTick,_that.errorTick,_that.error);case DocumentBuilderFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class DocumentBuilderLoading implements DocumentBuilderState {
  const DocumentBuilderLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentBuilderLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocumentBuilderState.loading()';
}


}




/// @nodoc


class DocumentBuilderReady implements DocumentBuilderState {
  const DocumentBuilderReady({required this.template, required final  List<List<TemplateField>> steps, this.document, this.generation, this.currentStep = 0, final  Map<String, String> answers = const <String, String>{}, this.saving = false, this.invalidTick = 0, this.draftTick = 0, this.errorTick = 0, this.error}): _steps = steps,_answers = answers;
  

 final  LegalTemplate template;
 final  List<List<TemplateField>> _steps;
 List<List<TemplateField>> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

 final  LegalDocument? document;
 final  DocumentGeneration? generation;
@JsonKey() final  int currentStep;
 final  Map<String, String> _answers;
@JsonKey() Map<String, String> get answers {
  if (_answers is EqualUnmodifiableMapView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answers);
}

@JsonKey() final  bool saving;
@JsonKey() final  int invalidTick;
@JsonKey() final  int draftTick;
@JsonKey() final  int errorTick;
 final  Failure? error;

/// Create a copy of DocumentBuilderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentBuilderReadyCopyWith<DocumentBuilderReady> get copyWith => _$DocumentBuilderReadyCopyWithImpl<DocumentBuilderReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentBuilderReady&&(identical(other.template, template) || other.template == template)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.document, document) || other.document == document)&&(identical(other.generation, generation) || other.generation == generation)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&const DeepCollectionEquality().equals(other._answers, _answers)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.invalidTick, invalidTick) || other.invalidTick == invalidTick)&&(identical(other.draftTick, draftTick) || other.draftTick == draftTick)&&(identical(other.errorTick, errorTick) || other.errorTick == errorTick)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,template,const DeepCollectionEquality().hash(_steps),document,generation,currentStep,const DeepCollectionEquality().hash(_answers),saving,invalidTick,draftTick,errorTick,error);

@override
String toString() {
  return 'DocumentBuilderState.ready(template: $template, steps: $steps, document: $document, generation: $generation, currentStep: $currentStep, answers: $answers, saving: $saving, invalidTick: $invalidTick, draftTick: $draftTick, errorTick: $errorTick, error: $error)';
}


}

/// @nodoc
abstract mixin class $DocumentBuilderReadyCopyWith<$Res> implements $DocumentBuilderStateCopyWith<$Res> {
  factory $DocumentBuilderReadyCopyWith(DocumentBuilderReady value, $Res Function(DocumentBuilderReady) _then) = _$DocumentBuilderReadyCopyWithImpl;
@useResult
$Res call({
 LegalTemplate template, List<List<TemplateField>> steps, LegalDocument? document, DocumentGeneration? generation, int currentStep, Map<String, String> answers, bool saving, int invalidTick, int draftTick, int errorTick, Failure? error
});


$LegalTemplateCopyWith<$Res> get template;$LegalDocumentCopyWith<$Res>? get document;$DocumentGenerationCopyWith<$Res>? get generation;

}
/// @nodoc
class _$DocumentBuilderReadyCopyWithImpl<$Res>
    implements $DocumentBuilderReadyCopyWith<$Res> {
  _$DocumentBuilderReadyCopyWithImpl(this._self, this._then);

  final DocumentBuilderReady _self;
  final $Res Function(DocumentBuilderReady) _then;

/// Create a copy of DocumentBuilderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? template = null,Object? steps = null,Object? document = freezed,Object? generation = freezed,Object? currentStep = null,Object? answers = null,Object? saving = null,Object? invalidTick = null,Object? draftTick = null,Object? errorTick = null,Object? error = freezed,}) {
  return _then(DocumentBuilderReady(
template: null == template ? _self.template : template // ignore: cast_nullable_to_non_nullable
as LegalTemplate,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<List<TemplateField>>,document: freezed == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as LegalDocument?,generation: freezed == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as DocumentGeneration?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,invalidTick: null == invalidTick ? _self.invalidTick : invalidTick // ignore: cast_nullable_to_non_nullable
as int,draftTick: null == draftTick ? _self.draftTick : draftTick // ignore: cast_nullable_to_non_nullable
as int,errorTick: null == errorTick ? _self.errorTick : errorTick // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of DocumentBuilderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTemplateCopyWith<$Res> get template {
  
  return $LegalTemplateCopyWith<$Res>(_self.template, (value) {
    return _then(_self.copyWith(template: value));
  });
}/// Create a copy of DocumentBuilderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalDocumentCopyWith<$Res>? get document {
    if (_self.document == null) {
    return null;
  }

  return $LegalDocumentCopyWith<$Res>(_self.document!, (value) {
    return _then(_self.copyWith(document: value));
  });
}/// Create a copy of DocumentBuilderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentGenerationCopyWith<$Res>? get generation {
    if (_self.generation == null) {
    return null;
  }

  return $DocumentGenerationCopyWith<$Res>(_self.generation!, (value) {
    return _then(_self.copyWith(generation: value));
  });
}
}

/// @nodoc


class DocumentBuilderFailure implements DocumentBuilderState {
  const DocumentBuilderFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of DocumentBuilderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentBuilderFailureCopyWith<DocumentBuilderFailure> get copyWith => _$DocumentBuilderFailureCopyWithImpl<DocumentBuilderFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentBuilderFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'DocumentBuilderState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DocumentBuilderFailureCopyWith<$Res> implements $DocumentBuilderStateCopyWith<$Res> {
  factory $DocumentBuilderFailureCopyWith(DocumentBuilderFailure value, $Res Function(DocumentBuilderFailure) _then) = _$DocumentBuilderFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$DocumentBuilderFailureCopyWithImpl<$Res>
    implements $DocumentBuilderFailureCopyWith<$Res> {
  _$DocumentBuilderFailureCopyWithImpl(this._self, this._then);

  final DocumentBuilderFailure _self;
  final $Res Function(DocumentBuilderFailure) _then;

/// Create a copy of DocumentBuilderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(DocumentBuilderFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
