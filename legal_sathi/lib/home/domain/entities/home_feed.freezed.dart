// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeFeed {

 List<LegalTemplate> get featuredTemplates; List<TemplateCategory> get categories; List<LegalDocument> get recentDocuments; int get completedCount;
/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeFeedCopyWith<HomeFeed> get copyWith => _$HomeFeedCopyWithImpl<HomeFeed>(this as HomeFeed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeed&&const DeepCollectionEquality().equals(other.featuredTemplates, featuredTemplates)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.recentDocuments, recentDocuments)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(featuredTemplates),const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(recentDocuments),completedCount);

@override
String toString() {
  return 'HomeFeed(featuredTemplates: $featuredTemplates, categories: $categories, recentDocuments: $recentDocuments, completedCount: $completedCount)';
}


}

/// @nodoc
abstract mixin class $HomeFeedCopyWith<$Res>  {
  factory $HomeFeedCopyWith(HomeFeed value, $Res Function(HomeFeed) _then) = _$HomeFeedCopyWithImpl;
@useResult
$Res call({
 List<LegalTemplate> featuredTemplates, List<TemplateCategory> categories, List<LegalDocument> recentDocuments, int completedCount
});




}
/// @nodoc
class _$HomeFeedCopyWithImpl<$Res>
    implements $HomeFeedCopyWith<$Res> {
  _$HomeFeedCopyWithImpl(this._self, this._then);

  final HomeFeed _self;
  final $Res Function(HomeFeed) _then;

/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? featuredTemplates = null,Object? categories = null,Object? recentDocuments = null,Object? completedCount = null,}) {
  return _then(_self.copyWith(
featuredTemplates: null == featuredTemplates ? _self.featuredTemplates : featuredTemplates // ignore: cast_nullable_to_non_nullable
as List<LegalTemplate>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<TemplateCategory>,recentDocuments: null == recentDocuments ? _self.recentDocuments : recentDocuments // ignore: cast_nullable_to_non_nullable
as List<LegalDocument>,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeFeed].
extension HomeFeedPatterns on HomeFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeFeed value)  $default,){
final _that = this;
switch (_that) {
case _HomeFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeFeed value)?  $default,){
final _that = this;
switch (_that) {
case _HomeFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LegalTemplate> featuredTemplates,  List<TemplateCategory> categories,  List<LegalDocument> recentDocuments,  int completedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeFeed() when $default != null:
return $default(_that.featuredTemplates,_that.categories,_that.recentDocuments,_that.completedCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LegalTemplate> featuredTemplates,  List<TemplateCategory> categories,  List<LegalDocument> recentDocuments,  int completedCount)  $default,) {final _that = this;
switch (_that) {
case _HomeFeed():
return $default(_that.featuredTemplates,_that.categories,_that.recentDocuments,_that.completedCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LegalTemplate> featuredTemplates,  List<TemplateCategory> categories,  List<LegalDocument> recentDocuments,  int completedCount)?  $default,) {final _that = this;
switch (_that) {
case _HomeFeed() when $default != null:
return $default(_that.featuredTemplates,_that.categories,_that.recentDocuments,_that.completedCount);case _:
  return null;

}
}

}

/// @nodoc


class _HomeFeed implements HomeFeed {
  const _HomeFeed({required final  List<LegalTemplate> featuredTemplates, required final  List<TemplateCategory> categories, required final  List<LegalDocument> recentDocuments, required this.completedCount}): _featuredTemplates = featuredTemplates,_categories = categories,_recentDocuments = recentDocuments;
  

 final  List<LegalTemplate> _featuredTemplates;
@override List<LegalTemplate> get featuredTemplates {
  if (_featuredTemplates is EqualUnmodifiableListView) return _featuredTemplates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredTemplates);
}

 final  List<TemplateCategory> _categories;
@override List<TemplateCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<LegalDocument> _recentDocuments;
@override List<LegalDocument> get recentDocuments {
  if (_recentDocuments is EqualUnmodifiableListView) return _recentDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentDocuments);
}

@override final  int completedCount;

/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeFeedCopyWith<_HomeFeed> get copyWith => __$HomeFeedCopyWithImpl<_HomeFeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeFeed&&const DeepCollectionEquality().equals(other._featuredTemplates, _featuredTemplates)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._recentDocuments, _recentDocuments)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_featuredTemplates),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_recentDocuments),completedCount);

@override
String toString() {
  return 'HomeFeed(featuredTemplates: $featuredTemplates, categories: $categories, recentDocuments: $recentDocuments, completedCount: $completedCount)';
}


}

/// @nodoc
abstract mixin class _$HomeFeedCopyWith<$Res> implements $HomeFeedCopyWith<$Res> {
  factory _$HomeFeedCopyWith(_HomeFeed value, $Res Function(_HomeFeed) _then) = __$HomeFeedCopyWithImpl;
@override @useResult
$Res call({
 List<LegalTemplate> featuredTemplates, List<TemplateCategory> categories, List<LegalDocument> recentDocuments, int completedCount
});




}
/// @nodoc
class __$HomeFeedCopyWithImpl<$Res>
    implements _$HomeFeedCopyWith<$Res> {
  __$HomeFeedCopyWithImpl(this._self, this._then);

  final _HomeFeed _self;
  final $Res Function(_HomeFeed) _then;

/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? featuredTemplates = null,Object? categories = null,Object? recentDocuments = null,Object? completedCount = null,}) {
  return _then(_HomeFeed(
featuredTemplates: null == featuredTemplates ? _self._featuredTemplates : featuredTemplates // ignore: cast_nullable_to_non_nullable
as List<LegalTemplate>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<TemplateCategory>,recentDocuments: null == recentDocuments ? _self._recentDocuments : recentDocuments // ignore: cast_nullable_to_non_nullable
as List<LegalDocument>,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
