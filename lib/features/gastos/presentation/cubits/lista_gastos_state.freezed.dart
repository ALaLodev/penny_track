// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lista_gastos_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListaGastosState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListaGastosState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListaGastosState()';
}


}

/// @nodoc
class $ListaGastosStateCopyWith<$Res>  {
$ListaGastosStateCopyWith(ListaGastosState _, $Res Function(ListaGastosState) __);
}


/// Adds pattern-matching-related methods to [ListaGastosState].
extension ListaGastosStatePatterns on ListaGastosState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ListaGastosLoading value)?  loading,TResult Function( _ListaGastosLoaded value)?  loaded,TResult Function( _ListaGastosError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListaGastosLoading() when loading != null:
return loading(_that);case _ListaGastosLoaded() when loaded != null:
return loaded(_that);case _ListaGastosError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ListaGastosLoading value)  loading,required TResult Function( _ListaGastosLoaded value)  loaded,required TResult Function( _ListaGastosError value)  error,}){
final _that = this;
switch (_that) {
case _ListaGastosLoading():
return loading(_that);case _ListaGastosLoaded():
return loaded(_that);case _ListaGastosError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ListaGastosLoading value)?  loading,TResult? Function( _ListaGastosLoaded value)?  loaded,TResult? Function( _ListaGastosError value)?  error,}){
final _that = this;
switch (_that) {
case _ListaGastosLoading() when loading != null:
return loading(_that);case _ListaGastosLoaded() when loaded != null:
return loaded(_that);case _ListaGastosError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<GastoEntity> gastos)?  loaded,TResult Function( String mensaje)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListaGastosLoading() when loading != null:
return loading();case _ListaGastosLoaded() when loaded != null:
return loaded(_that.gastos);case _ListaGastosError() when error != null:
return error(_that.mensaje);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<GastoEntity> gastos)  loaded,required TResult Function( String mensaje)  error,}) {final _that = this;
switch (_that) {
case _ListaGastosLoading():
return loading();case _ListaGastosLoaded():
return loaded(_that.gastos);case _ListaGastosError():
return error(_that.mensaje);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<GastoEntity> gastos)?  loaded,TResult? Function( String mensaje)?  error,}) {final _that = this;
switch (_that) {
case _ListaGastosLoading() when loading != null:
return loading();case _ListaGastosLoaded() when loaded != null:
return loaded(_that.gastos);case _ListaGastosError() when error != null:
return error(_that.mensaje);case _:
  return null;

}
}

}

/// @nodoc


class _ListaGastosLoading implements ListaGastosState {
  const _ListaGastosLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListaGastosLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ListaGastosState.loading()';
}


}




/// @nodoc


class _ListaGastosLoaded implements ListaGastosState {
  const _ListaGastosLoaded({required final  List<GastoEntity> gastos}): _gastos = gastos;
  

 final  List<GastoEntity> _gastos;
 List<GastoEntity> get gastos {
  if (_gastos is EqualUnmodifiableListView) return _gastos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gastos);
}


/// Create a copy of ListaGastosState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListaGastosLoadedCopyWith<_ListaGastosLoaded> get copyWith => __$ListaGastosLoadedCopyWithImpl<_ListaGastosLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListaGastosLoaded&&const DeepCollectionEquality().equals(other._gastos, _gastos));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_gastos));

@override
String toString() {
  return 'ListaGastosState.loaded(gastos: $gastos)';
}


}

/// @nodoc
abstract mixin class _$ListaGastosLoadedCopyWith<$Res> implements $ListaGastosStateCopyWith<$Res> {
  factory _$ListaGastosLoadedCopyWith(_ListaGastosLoaded value, $Res Function(_ListaGastosLoaded) _then) = __$ListaGastosLoadedCopyWithImpl;
@useResult
$Res call({
 List<GastoEntity> gastos
});




}
/// @nodoc
class __$ListaGastosLoadedCopyWithImpl<$Res>
    implements _$ListaGastosLoadedCopyWith<$Res> {
  __$ListaGastosLoadedCopyWithImpl(this._self, this._then);

  final _ListaGastosLoaded _self;
  final $Res Function(_ListaGastosLoaded) _then;

/// Create a copy of ListaGastosState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? gastos = null,}) {
  return _then(_ListaGastosLoaded(
gastos: null == gastos ? _self._gastos : gastos // ignore: cast_nullable_to_non_nullable
as List<GastoEntity>,
  ));
}


}

/// @nodoc


class _ListaGastosError implements ListaGastosState {
  const _ListaGastosError({required this.mensaje});
  

 final  String mensaje;

/// Create a copy of ListaGastosState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListaGastosErrorCopyWith<_ListaGastosError> get copyWith => __$ListaGastosErrorCopyWithImpl<_ListaGastosError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListaGastosError&&(identical(other.mensaje, mensaje) || other.mensaje == mensaje));
}


@override
int get hashCode => Object.hash(runtimeType,mensaje);

@override
String toString() {
  return 'ListaGastosState.error(mensaje: $mensaje)';
}


}

/// @nodoc
abstract mixin class _$ListaGastosErrorCopyWith<$Res> implements $ListaGastosStateCopyWith<$Res> {
  factory _$ListaGastosErrorCopyWith(_ListaGastosError value, $Res Function(_ListaGastosError) _then) = __$ListaGastosErrorCopyWithImpl;
@useResult
$Res call({
 String mensaje
});




}
/// @nodoc
class __$ListaGastosErrorCopyWithImpl<$Res>
    implements _$ListaGastosErrorCopyWith<$Res> {
  __$ListaGastosErrorCopyWithImpl(this._self, this._then);

  final _ListaGastosError _self;
  final $Res Function(_ListaGastosError) _then;

/// Create a copy of ListaGastosState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mensaje = null,}) {
  return _then(_ListaGastosError(
mensaje: null == mensaje ? _self.mensaje : mensaje // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
