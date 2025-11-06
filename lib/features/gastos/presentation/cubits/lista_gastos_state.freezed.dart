// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lista_gastos_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ListaGastosState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<GastoEntity> gastos) loaded,
    required TResult Function(String mensaje) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<GastoEntity> gastos)? loaded,
    TResult? Function(String mensaje)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<GastoEntity> gastos)? loaded,
    TResult Function(String mensaje)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListaGastosLoading value) loading,
    required TResult Function(_ListaGastosLoaded value) loaded,
    required TResult Function(_ListaGastosError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListaGastosLoading value)? loading,
    TResult? Function(_ListaGastosLoaded value)? loaded,
    TResult? Function(_ListaGastosError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListaGastosLoading value)? loading,
    TResult Function(_ListaGastosLoaded value)? loaded,
    TResult Function(_ListaGastosError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListaGastosStateCopyWith<$Res> {
  factory $ListaGastosStateCopyWith(
    ListaGastosState value,
    $Res Function(ListaGastosState) then,
  ) = _$ListaGastosStateCopyWithImpl<$Res, ListaGastosState>;
}

/// @nodoc
class _$ListaGastosStateCopyWithImpl<$Res, $Val extends ListaGastosState>
    implements $ListaGastosStateCopyWith<$Res> {
  _$ListaGastosStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListaGastosState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ListaGastosLoadingImplCopyWith<$Res> {
  factory _$$ListaGastosLoadingImplCopyWith(
    _$ListaGastosLoadingImpl value,
    $Res Function(_$ListaGastosLoadingImpl) then,
  ) = __$$ListaGastosLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListaGastosLoadingImplCopyWithImpl<$Res>
    extends _$ListaGastosStateCopyWithImpl<$Res, _$ListaGastosLoadingImpl>
    implements _$$ListaGastosLoadingImplCopyWith<$Res> {
  __$$ListaGastosLoadingImplCopyWithImpl(
    _$ListaGastosLoadingImpl _value,
    $Res Function(_$ListaGastosLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ListaGastosState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ListaGastosLoadingImpl implements _ListaGastosLoading {
  const _$ListaGastosLoadingImpl();

  @override
  String toString() {
    return 'ListaGastosState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListaGastosLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<GastoEntity> gastos) loaded,
    required TResult Function(String mensaje) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<GastoEntity> gastos)? loaded,
    TResult? Function(String mensaje)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<GastoEntity> gastos)? loaded,
    TResult Function(String mensaje)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListaGastosLoading value) loading,
    required TResult Function(_ListaGastosLoaded value) loaded,
    required TResult Function(_ListaGastosError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListaGastosLoading value)? loading,
    TResult? Function(_ListaGastosLoaded value)? loaded,
    TResult? Function(_ListaGastosError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListaGastosLoading value)? loading,
    TResult Function(_ListaGastosLoaded value)? loaded,
    TResult Function(_ListaGastosError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ListaGastosLoading implements ListaGastosState {
  const factory _ListaGastosLoading() = _$ListaGastosLoadingImpl;
}

/// @nodoc
abstract class _$$ListaGastosLoadedImplCopyWith<$Res> {
  factory _$$ListaGastosLoadedImplCopyWith(
    _$ListaGastosLoadedImpl value,
    $Res Function(_$ListaGastosLoadedImpl) then,
  ) = __$$ListaGastosLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<GastoEntity> gastos});
}

/// @nodoc
class __$$ListaGastosLoadedImplCopyWithImpl<$Res>
    extends _$ListaGastosStateCopyWithImpl<$Res, _$ListaGastosLoadedImpl>
    implements _$$ListaGastosLoadedImplCopyWith<$Res> {
  __$$ListaGastosLoadedImplCopyWithImpl(
    _$ListaGastosLoadedImpl _value,
    $Res Function(_$ListaGastosLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ListaGastosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? gastos = null}) {
    return _then(
      _$ListaGastosLoadedImpl(
        gastos: null == gastos
            ? _value._gastos
            : gastos // ignore: cast_nullable_to_non_nullable
                  as List<GastoEntity>,
      ),
    );
  }
}

/// @nodoc

class _$ListaGastosLoadedImpl implements _ListaGastosLoaded {
  const _$ListaGastosLoadedImpl({required final List<GastoEntity> gastos})
    : _gastos = gastos;

  final List<GastoEntity> _gastos;
  @override
  List<GastoEntity> get gastos {
    if (_gastos is EqualUnmodifiableListView) return _gastos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gastos);
  }

  @override
  String toString() {
    return 'ListaGastosState.loaded(gastos: $gastos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListaGastosLoadedImpl &&
            const DeepCollectionEquality().equals(other._gastos, _gastos));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_gastos));

  /// Create a copy of ListaGastosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListaGastosLoadedImplCopyWith<_$ListaGastosLoadedImpl> get copyWith =>
      __$$ListaGastosLoadedImplCopyWithImpl<_$ListaGastosLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<GastoEntity> gastos) loaded,
    required TResult Function(String mensaje) error,
  }) {
    return loaded(gastos);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<GastoEntity> gastos)? loaded,
    TResult? Function(String mensaje)? error,
  }) {
    return loaded?.call(gastos);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<GastoEntity> gastos)? loaded,
    TResult Function(String mensaje)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(gastos);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListaGastosLoading value) loading,
    required TResult Function(_ListaGastosLoaded value) loaded,
    required TResult Function(_ListaGastosError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListaGastosLoading value)? loading,
    TResult? Function(_ListaGastosLoaded value)? loaded,
    TResult? Function(_ListaGastosError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListaGastosLoading value)? loading,
    TResult Function(_ListaGastosLoaded value)? loaded,
    TResult Function(_ListaGastosError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _ListaGastosLoaded implements ListaGastosState {
  const factory _ListaGastosLoaded({required final List<GastoEntity> gastos}) =
      _$ListaGastosLoadedImpl;

  List<GastoEntity> get gastos;

  /// Create a copy of ListaGastosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListaGastosLoadedImplCopyWith<_$ListaGastosLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListaGastosErrorImplCopyWith<$Res> {
  factory _$$ListaGastosErrorImplCopyWith(
    _$ListaGastosErrorImpl value,
    $Res Function(_$ListaGastosErrorImpl) then,
  ) = __$$ListaGastosErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String mensaje});
}

/// @nodoc
class __$$ListaGastosErrorImplCopyWithImpl<$Res>
    extends _$ListaGastosStateCopyWithImpl<$Res, _$ListaGastosErrorImpl>
    implements _$$ListaGastosErrorImplCopyWith<$Res> {
  __$$ListaGastosErrorImplCopyWithImpl(
    _$ListaGastosErrorImpl _value,
    $Res Function(_$ListaGastosErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ListaGastosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mensaje = null}) {
    return _then(
      _$ListaGastosErrorImpl(
        mensaje: null == mensaje
            ? _value.mensaje
            : mensaje // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ListaGastosErrorImpl implements _ListaGastosError {
  const _$ListaGastosErrorImpl({required this.mensaje});

  @override
  final String mensaje;

  @override
  String toString() {
    return 'ListaGastosState.error(mensaje: $mensaje)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListaGastosErrorImpl &&
            (identical(other.mensaje, mensaje) || other.mensaje == mensaje));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mensaje);

  /// Create a copy of ListaGastosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListaGastosErrorImplCopyWith<_$ListaGastosErrorImpl> get copyWith =>
      __$$ListaGastosErrorImplCopyWithImpl<_$ListaGastosErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<GastoEntity> gastos) loaded,
    required TResult Function(String mensaje) error,
  }) {
    return error(mensaje);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<GastoEntity> gastos)? loaded,
    TResult? Function(String mensaje)? error,
  }) {
    return error?.call(mensaje);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<GastoEntity> gastos)? loaded,
    TResult Function(String mensaje)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(mensaje);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListaGastosLoading value) loading,
    required TResult Function(_ListaGastosLoaded value) loaded,
    required TResult Function(_ListaGastosError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListaGastosLoading value)? loading,
    TResult? Function(_ListaGastosLoaded value)? loaded,
    TResult? Function(_ListaGastosError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListaGastosLoading value)? loading,
    TResult Function(_ListaGastosLoaded value)? loaded,
    TResult Function(_ListaGastosError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ListaGastosError implements ListaGastosState {
  const factory _ListaGastosError({required final String mensaje}) =
      _$ListaGastosErrorImpl;

  String get mensaje;

  /// Create a copy of ListaGastosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListaGastosErrorImplCopyWith<_$ListaGastosErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
