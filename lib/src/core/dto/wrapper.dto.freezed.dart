// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wrapper.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WrapperDto<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() emptyState,
    required TResult Function(double percent) loadingState,
    required TResult Function(T value) loadedState,
    required TResult Function(Failure failure) errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyState<T> value) emptyState,
    required TResult Function(LoadingState<T> value) loadingState,
    required TResult Function(LoadedState<T> value) loadedState,
    required TResult Function(ErrorState<T> value) errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WrapperDtoCopyWith<T, $Res> {
  factory $WrapperDtoCopyWith(
          WrapperDto<T> value, $Res Function(WrapperDto<T>) then) =
      _$WrapperDtoCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$WrapperDtoCopyWithImpl<T, $Res>
    implements $WrapperDtoCopyWith<T, $Res> {
  _$WrapperDtoCopyWithImpl(this._value, this._then);

  final WrapperDto<T> _value;
  // ignore: unused_field
  final $Res Function(WrapperDto<T>) _then;
}

/// @nodoc
abstract class _$$EmptyStateCopyWith<T, $Res> {
  factory _$$EmptyStateCopyWith(
          _$EmptyState<T> value, $Res Function(_$EmptyState<T>) then) =
      __$$EmptyStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$EmptyStateCopyWithImpl<T, $Res>
    extends _$WrapperDtoCopyWithImpl<T, $Res>
    implements _$$EmptyStateCopyWith<T, $Res> {
  __$$EmptyStateCopyWithImpl(
      _$EmptyState<T> _value, $Res Function(_$EmptyState<T>) _then)
      : super(_value, (v) => _then(v as _$EmptyState<T>));

  @override
  _$EmptyState<T> get _value => super._value as _$EmptyState<T>;
}

/// @nodoc

class _$EmptyState<T> implements EmptyState<T> {
  _$EmptyState();

  @override
  String toString() {
    return 'WrapperDto<$T>.emptyState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmptyState<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() emptyState,
    required TResult Function(double percent) loadingState,
    required TResult Function(T value) loadedState,
    required TResult Function(Failure failure) errorState,
  }) {
    return emptyState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
  }) {
    return emptyState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
    required TResult orElse(),
  }) {
    if (emptyState != null) {
      return emptyState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyState<T> value) emptyState,
    required TResult Function(LoadingState<T> value) loadingState,
    required TResult Function(LoadedState<T> value) loadedState,
    required TResult Function(ErrorState<T> value) errorState,
  }) {
    return emptyState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
  }) {
    return emptyState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
    required TResult orElse(),
  }) {
    if (emptyState != null) {
      return emptyState(this);
    }
    return orElse();
  }
}

abstract class EmptyState<T> implements WrapperDto<T> {
  factory EmptyState() = _$EmptyState<T>;
}

/// @nodoc
abstract class _$$LoadingStateCopyWith<T, $Res> {
  factory _$$LoadingStateCopyWith(
          _$LoadingState<T> value, $Res Function(_$LoadingState<T>) then) =
      __$$LoadingStateCopyWithImpl<T, $Res>;
  $Res call({double percent});
}

/// @nodoc
class __$$LoadingStateCopyWithImpl<T, $Res>
    extends _$WrapperDtoCopyWithImpl<T, $Res>
    implements _$$LoadingStateCopyWith<T, $Res> {
  __$$LoadingStateCopyWithImpl(
      _$LoadingState<T> _value, $Res Function(_$LoadingState<T>) _then)
      : super(_value, (v) => _then(v as _$LoadingState<T>));

  @override
  _$LoadingState<T> get _value => super._value as _$LoadingState<T>;

  @override
  $Res call({
    Object? percent = freezed,
  }) {
    return _then(_$LoadingState<T>(
      percent: percent == freezed
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$LoadingState<T> implements LoadingState<T> {
  _$LoadingState({this.percent = 0});

  @override
  @JsonKey()
  final double percent;

  @override
  String toString() {
    return 'WrapperDto<$T>.loadingState(percent: $percent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingState<T> &&
            const DeepCollectionEquality().equals(other.percent, percent));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(percent));

  @JsonKey(ignore: true)
  @override
  _$$LoadingStateCopyWith<T, _$LoadingState<T>> get copyWith =>
      __$$LoadingStateCopyWithImpl<T, _$LoadingState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() emptyState,
    required TResult Function(double percent) loadingState,
    required TResult Function(T value) loadedState,
    required TResult Function(Failure failure) errorState,
  }) {
    return loadingState(percent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
  }) {
    return loadingState?.call(percent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
    required TResult orElse(),
  }) {
    if (loadingState != null) {
      return loadingState(percent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyState<T> value) emptyState,
    required TResult Function(LoadingState<T> value) loadingState,
    required TResult Function(LoadedState<T> value) loadedState,
    required TResult Function(ErrorState<T> value) errorState,
  }) {
    return loadingState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
  }) {
    return loadingState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
    required TResult orElse(),
  }) {
    if (loadingState != null) {
      return loadingState(this);
    }
    return orElse();
  }
}

abstract class LoadingState<T> implements WrapperDto<T> {
  factory LoadingState({final double percent}) = _$LoadingState<T>;

  double get percent;
  @JsonKey(ignore: true)
  _$$LoadingStateCopyWith<T, _$LoadingState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedStateCopyWith<T, $Res> {
  factory _$$LoadedStateCopyWith(
          _$LoadedState<T> value, $Res Function(_$LoadedState<T>) then) =
      __$$LoadedStateCopyWithImpl<T, $Res>;
  $Res call({T value});
}

/// @nodoc
class __$$LoadedStateCopyWithImpl<T, $Res>
    extends _$WrapperDtoCopyWithImpl<T, $Res>
    implements _$$LoadedStateCopyWith<T, $Res> {
  __$$LoadedStateCopyWithImpl(
      _$LoadedState<T> _value, $Res Function(_$LoadedState<T>) _then)
      : super(_value, (v) => _then(v as _$LoadedState<T>));

  @override
  _$LoadedState<T> get _value => super._value as _$LoadedState<T>;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$LoadedState<T>(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$LoadedState<T> implements LoadedState<T> {
  _$LoadedState({required this.value});

  @override
  final T value;

  @override
  String toString() {
    return 'WrapperDto<$T>.loadedState(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedState<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$LoadedStateCopyWith<T, _$LoadedState<T>> get copyWith =>
      __$$LoadedStateCopyWithImpl<T, _$LoadedState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() emptyState,
    required TResult Function(double percent) loadingState,
    required TResult Function(T value) loadedState,
    required TResult Function(Failure failure) errorState,
  }) {
    return loadedState(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
  }) {
    return loadedState?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
    required TResult orElse(),
  }) {
    if (loadedState != null) {
      return loadedState(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyState<T> value) emptyState,
    required TResult Function(LoadingState<T> value) loadingState,
    required TResult Function(LoadedState<T> value) loadedState,
    required TResult Function(ErrorState<T> value) errorState,
  }) {
    return loadedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
  }) {
    return loadedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
    required TResult orElse(),
  }) {
    if (loadedState != null) {
      return loadedState(this);
    }
    return orElse();
  }
}

abstract class LoadedState<T> implements WrapperDto<T> {
  factory LoadedState({required final T value}) = _$LoadedState<T>;

  T get value;
  @JsonKey(ignore: true)
  _$$LoadedStateCopyWith<T, _$LoadedState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorStateCopyWith<T, $Res> {
  factory _$$ErrorStateCopyWith(
          _$ErrorState<T> value, $Res Function(_$ErrorState<T>) then) =
      __$$ErrorStateCopyWithImpl<T, $Res>;
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$ErrorStateCopyWithImpl<T, $Res>
    extends _$WrapperDtoCopyWithImpl<T, $Res>
    implements _$$ErrorStateCopyWith<T, $Res> {
  __$$ErrorStateCopyWithImpl(
      _$ErrorState<T> _value, $Res Function(_$ErrorState<T>) _then)
      : super(_value, (v) => _then(v as _$ErrorState<T>));

  @override
  _$ErrorState<T> get _value => super._value as _$ErrorState<T>;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_$ErrorState<T>(
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }

  @override
  $FailureCopyWith<$Res> get failure {
    return $FailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$ErrorState<T> implements ErrorState<T> {
  _$ErrorState({required this.failure});

  @override
  final Failure failure;

  @override
  String toString() {
    return 'WrapperDto<$T>.errorState(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorState<T> &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  _$$ErrorStateCopyWith<T, _$ErrorState<T>> get copyWith =>
      __$$ErrorStateCopyWithImpl<T, _$ErrorState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() emptyState,
    required TResult Function(double percent) loadingState,
    required TResult Function(T value) loadedState,
    required TResult Function(Failure failure) errorState,
  }) {
    return errorState(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
  }) {
    return errorState?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? emptyState,
    TResult Function(double percent)? loadingState,
    TResult Function(T value)? loadedState,
    TResult Function(Failure failure)? errorState,
    required TResult orElse(),
  }) {
    if (errorState != null) {
      return errorState(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmptyState<T> value) emptyState,
    required TResult Function(LoadingState<T> value) loadingState,
    required TResult Function(LoadedState<T> value) loadedState,
    required TResult Function(ErrorState<T> value) errorState,
  }) {
    return errorState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
  }) {
    return errorState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmptyState<T> value)? emptyState,
    TResult Function(LoadingState<T> value)? loadingState,
    TResult Function(LoadedState<T> value)? loadedState,
    TResult Function(ErrorState<T> value)? errorState,
    required TResult orElse(),
  }) {
    if (errorState != null) {
      return errorState(this);
    }
    return orElse();
  }
}

abstract class ErrorState<T> implements WrapperDto<T> {
  factory ErrorState({required final Failure failure}) = _$ErrorState<T>;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$ErrorStateCopyWith<T, _$ErrorState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
