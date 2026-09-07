// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TemplateListState {

 bool get isLoading; List<TemplateCategory> get categories;/// Already narrowed by [selectedCategoryId] and [query]: whoever serves the
/// catalogue does the filtering, so there is nothing left to hide locally.
 List<LegalTemplate> get templates; int? get selectedCategoryId; String get query; Failure? get failure;
/// Create a copy of TemplateListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateListStateCopyWith<TemplateListState> get copyWith => _$TemplateListStateCopyWithImpl<TemplateListState>(this as TemplateListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.templates, templates)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.query, query) || other.query == query)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(templates),selectedCategoryId,query,failure);

@override
String toString() {
  return 'TemplateListState(isLoading: $isLoading, categories: $categories, templates: $templates, selectedCategoryId: $selectedCategoryId, query: $query, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $TemplateListStateCopyWith<$Res>  {
  factory $TemplateListStateCopyWith(TemplateListState value, $Res Function(TemplateListState) _then) = _$TemplateListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TemplateCategory> categories, List<LegalTemplate> templates, int? selectedCategoryId, String query, Failure? failure
});




}
/// @nodoc
class _$TemplateListStateCopyWithImpl<$Res>
    implements $TemplateListStateCopyWith<$Res> {
  _$TemplateListStateCopyWithImpl(this._self, this._then);

  final TemplateListState _self;
  final $Res Function(TemplateListState) _then;

/// Create a copy of TemplateListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? categories = null,Object? templates = null,Object? selectedCategoryId = freezed,Object? query = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<TemplateCategory>,templates: null == templates ? _self.templates : templates // ignore: cast_nullable_to_non_nullable
as List<LegalTemplate>,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateListState].
extension TemplateListStatePatterns on TemplateListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateListState value)  $default,){
final _that = this;
switch (_that) {
case _TemplateListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateListState value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<TemplateCategory> categories,  List<LegalTemplate> templates,  int? selectedCategoryId,  String query,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateListState() when $default != null:
return $default(_that.isLoading,_that.categories,_that.templates,_that.selectedCategoryId,_that.query,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<TemplateCategory> categories,  List<LegalTemplate> templates,  int? selectedCategoryId,  String query,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _TemplateListState():
return $default(_that.isLoading,_that.categories,_that.templates,_that.selectedCategoryId,_that.query,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<TemplateCategory> categories,  List<LegalTemplate> templates,  int? selectedCategoryId,  String query,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _TemplateListState() when $default != null:
return $default(_that.isLoading,_that.categories,_that.templates,_that.selectedCategoryId,_that.query,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _TemplateListState implements TemplateListState {
  const _TemplateListState({this.isLoading = true, final  List<TemplateCategory> categories = const <TemplateCategory>[], final  List<LegalTemplate> templates = const <LegalTemplate>[], this.selectedCategoryId, this.query = '', this.failure}): _categories = categories,_templates = templates;
  

@override@JsonKey() final  bool isLoading;
 final  List<TemplateCategory> _categories;
@override@JsonKey() List<TemplateCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

/// Already narrowed by [selectedCategoryId] and [query]: whoever serves the
/// catalogue does the filtering, so there is nothing left to hide locally.
 final  List<LegalTemplate> _templates;
/// Already narrowed by [selectedCategoryId] and [query]: whoever serves the
/// catalogue does the filtering, so there is nothing left to hide locally.
@override@JsonKey() List<LegalTemplate> get templates {
  if (_templates is EqualUnmodifiableListView) return _templates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_templates);
}

@override final  int? selectedCategoryId;
@override@JsonKey() final  String query;
@override final  Failure? failure;

/// Create a copy of TemplateListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateListStateCopyWith<_TemplateListState> get copyWith => __$TemplateListStateCopyWithImpl<_TemplateListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._templates, _templates)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.query, query) || other.query == query)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_templates),selectedCategoryId,query,failure);

@override
String toString() {
  return 'TemplateListState(isLoading: $isLoading, categories: $categories, templates: $templates, selectedCategoryId: $selectedCategoryId, query: $query, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$TemplateListStateCopyWith<$Res> implements $TemplateListStateCopyWith<$Res> {
  factory _$TemplateListStateCopyWith(_TemplateListState value, $Res Function(_TemplateListState) _then) = __$TemplateListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TemplateCategory> categories, List<LegalTemplate> templates, int? selectedCategoryId, String query, Failure? failure
});




}
/// @nodoc
class __$TemplateListStateCopyWithImpl<$Res>
    implements _$TemplateListStateCopyWith<$Res> {
  __$TemplateListStateCopyWithImpl(this._self, this._then);

  final _TemplateListState _self;
  final $Res Function(_TemplateListState) _then;

/// Create a copy of TemplateListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? categories = null,Object? templates = null,Object? selectedCategoryId = freezed,Object? query = null,Object? failure = freezed,}) {
  return _then(_TemplateListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<TemplateCategory>,templates: null == templates ? _self._templates : templates // ignore: cast_nullable_to_non_nullable
as List<LegalTemplate>,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
