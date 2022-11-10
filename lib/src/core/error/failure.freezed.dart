// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Failure {
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) cacheFailure,
    required TResult Function(String? message) unExpectedFailure,
    required TResult Function(String? message) notFound,
    required TResult Function(String? message, String? key) validationFailure,
    required TResult Function(String? message) noDataFailure,
    required TResult Function(String? message) serverFailure,
    required TResult Function(String? message) networkFailure,
    required TResult Function(String? message) unauthorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cacheFailure,
    required TResult Function(UnExpectedFailure value) unExpectedFailure,
    required TResult Function(NotFound value) notFound,
    required TResult Function(ValidationFailure value) validationFailure,
    required TResult Function(NoDataFailure value) noDataFailure,
    required TResult Function(ServerFailure value) serverFailure,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(UnAuthorizedFailure value) unauthorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res> implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  final Failure _value;
  // ignore: unused_field
  final $Res Function(Failure) _then;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$CacheFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$$CacheFailureCopyWith(
          _$CacheFailure value, $Res Function(_$CacheFailure) then) =
      __$$CacheFailureCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class __$$CacheFailureCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$$CacheFailureCopyWith<$Res> {
  __$$CacheFailureCopyWithImpl(
      _$CacheFailure _value, $Res Function(_$CacheFailure) _then)
      : super(_value, (v) => _then(v as _$CacheFailure));

  @override
  _$CacheFailure get _value => super._value as _$CacheFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$CacheFailure(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CacheFailure implements CacheFailure {
  _$CacheFailure(
      {this.message =
          "No connection, please connect to the Internet and try again."});

  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'Failure.cacheFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheFailure &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$CacheFailureCopyWith<_$CacheFailure> get copyWith =>
      __$$CacheFailureCopyWithImpl<_$CacheFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) cacheFailure,
    required TResult Function(String? message) unExpectedFailure,
    required TResult Function(String? message) notFound,
    required TResult Function(String? message, String? key) validationFailure,
    required TResult Function(String? message) noDataFailure,
    required TResult Function(String? message) serverFailure,
    required TResult Function(String? message) networkFailure,
    required TResult Function(String? message) unauthorized,
  }) {
    return cacheFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
  }) {
    return cacheFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
    required TResult orElse(),
  }) {
    if (cacheFailure != null) {
      return cacheFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cacheFailure,
    required TResult Function(UnExpectedFailure value) unExpectedFailure,
    required TResult Function(NotFound value) notFound,
    required TResult Function(ValidationFailure value) validationFailure,
    required TResult Function(NoDataFailure value) noDataFailure,
    required TResult Function(ServerFailure value) serverFailure,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(UnAuthorizedFailure value) unauthorized,
  }) {
    return cacheFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
  }) {
    return cacheFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
    required TResult orElse(),
  }) {
    if (cacheFailure != null) {
      return cacheFailure(this);
    }
    return orElse();
  }
}

abstract class CacheFailure implements Failure {
  factory CacheFailure({final String? message}) = _$CacheFailure;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$CacheFailureCopyWith<_$CacheFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnExpectedFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnExpectedFailureCopyWith(
          _$UnExpectedFailure value, $Res Function(_$UnExpectedFailure) then) =
      __$$UnExpectedFailureCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class __$$UnExpectedFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res>
    implements _$$UnExpectedFailureCopyWith<$Res> {
  __$$UnExpectedFailureCopyWithImpl(
      _$UnExpectedFailure _value, $Res Function(_$UnExpectedFailure) _then)
      : super(_value, (v) => _then(v as _$UnExpectedFailure));

  @override
  _$UnExpectedFailure get _value => super._value as _$UnExpectedFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UnExpectedFailure(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnExpectedFailure implements UnExpectedFailure {
  _$UnExpectedFailure(
      {this.message = "Sorry, Something went wrong, please try again later!"});

  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'Failure.unExpectedFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnExpectedFailure &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$UnExpectedFailureCopyWith<_$UnExpectedFailure> get copyWith =>
      __$$UnExpectedFailureCopyWithImpl<_$UnExpectedFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) cacheFailure,
    required TResult Function(String? message) unExpectedFailure,
    required TResult Function(String? message) notFound,
    required TResult Function(String? message, String? key) validationFailure,
    required TResult Function(String? message) noDataFailure,
    required TResult Function(String? message) serverFailure,
    required TResult Function(String? message) networkFailure,
    required TResult Function(String? message) unauthorized,
  }) {
    return unExpectedFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
  }) {
    return unExpectedFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
    required TResult orElse(),
  }) {
    if (unExpectedFailure != null) {
      return unExpectedFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cacheFailure,
    required TResult Function(UnExpectedFailure value) unExpectedFailure,
    required TResult Function(NotFound value) notFound,
    required TResult Function(ValidationFailure value) validationFailure,
    required TResult Function(NoDataFailure value) noDataFailure,
    required TResult Function(ServerFailure value) serverFailure,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(UnAuthorizedFailure value) unauthorized,
  }) {
    return unExpectedFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
  }) {
    return unExpectedFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
    required TResult orElse(),
  }) {
    if (unExpectedFailure != null) {
      return unExpectedFailure(this);
    }
    return orElse();
  }
}

abstract class UnExpectedFailure implements Failure {
  factory UnExpectedFailure({final String? message}) = _$UnExpectedFailure;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$UnExpectedFailureCopyWith<_$UnExpectedFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$$NotFoundCopyWith(
          _$NotFound value, $Res Function(_$NotFound) then) =
      __$$NotFoundCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class __$$NotFoundCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$$NotFoundCopyWith<$Res> {
  __$$NotFoundCopyWithImpl(_$NotFound _value, $Res Function(_$NotFound) _then)
      : super(_value, (v) => _then(v as _$NotFound));

  @override
  _$NotFound get _value => super._value as _$NotFound;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$NotFound(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NotFound implements NotFound {
  _$NotFound({this.message = "Sorry, we couldn't find what your looking for!"});

  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'Failure.notFound(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFound &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$NotFoundCopyWith<_$NotFound> get copyWith =>
      __$$NotFoundCopyWithImpl<_$NotFound>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) cacheFailure,
    required TResult Function(String? message) unExpectedFailure,
    required TResult Function(String? message) notFound,
    required TResult Function(String? message, String? key) validationFailure,
    required TResult Function(String? message) noDataFailure,
    required TResult Function(String? message) serverFailure,
    required TResult Function(String? message) networkFailure,
    required TResult Function(String? message) unauthorized,
  }) {
    return notFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
  }) {
    return notFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cacheFailure,
    required TResult Function(UnExpectedFailure value) unExpectedFailure,
    required TResult Function(NotFound value) notFound,
    required TResult Function(ValidationFailure value) validationFailure,
    required TResult Function(NoDataFailure value) noDataFailure,
    required TResult Function(ServerFailure value) serverFailure,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(UnAuthorizedFailure value) unauthorized,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFound implements Failure {
  factory NotFound({final String? message}) = _$NotFound;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$NotFoundCopyWith<_$NotFound> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureCopyWith(
          _$ValidationFailure value, $Res Function(_$ValidationFailure) then) =
      __$$ValidationFailureCopyWithImpl<$Res>;
  @override
  $Res call({String? message, String? key});
}

/// @nodoc
class __$$ValidationFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res>
    implements _$$ValidationFailureCopyWith<$Res> {
  __$$ValidationFailureCopyWithImpl(
      _$ValidationFailure _value, $Res Function(_$ValidationFailure) _then)
      : super(_value, (v) => _then(v as _$ValidationFailure));

  @override
  _$ValidationFailure get _value => super._value as _$ValidationFailure;

  @override
  $Res call({
    Object? message = freezed,
    Object? key = freezed,
  }) {
    return _then(_$ValidationFailure(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ValidationFailure implements ValidationFailure {
  _$ValidationFailure(
      {this.message = "Sorry, wrong or incomplete form is presented.",
      this.key});

  @override
  @JsonKey()
  final String? message;
  @override
  final String? key;

  @override
  String toString() {
    return 'Failure.validationFailure(message: $message, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailure &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.key, key));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(key));

  @JsonKey(ignore: true)
  @override
  _$$ValidationFailureCopyWith<_$ValidationFailure> get copyWith =>
      __$$ValidationFailureCopyWithImpl<_$ValidationFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) cacheFailure,
    required TResult Function(String? message) unExpectedFailure,
    required TResult Function(String? message) notFound,
    required TResult Function(String? message, String? key) validationFailure,
    required TResult Function(String? message) noDataFailure,
    required TResult Function(String? message) serverFailure,
    required TResult Function(String? message) networkFailure,
    required TResult Function(String? message) unauthorized,
  }) {
    return validationFailure(message, key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
  }) {
    return validationFailure?.call(message, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
    required TResult orElse(),
  }) {
    if (validationFailure != null) {
      return validationFailure(message, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cacheFailure,
    required TResult Function(UnExpectedFailure value) unExpectedFailure,
    required TResult Function(NotFound value) notFound,
    required TResult Function(ValidationFailure value) validationFailure,
    required TResult Function(NoDataFailure value) noDataFailure,
    required TResult Function(ServerFailure value) serverFailure,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(UnAuthorizedFailure value) unauthorized,
  }) {
    return validationFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
  }) {
    return validationFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
    required TResult orElse(),
  }) {
    if (validationFailure != null) {
      return validationFailure(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure implements Failure {
  factory ValidationFailure({final String? message, final String? key}) =
      _$ValidationFailure;

  @override
  String? get message;
  String? get key;
  @override
  @JsonKey(ignore: true)
  _$$ValidationFailureCopyWith<_$ValidationFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoDataFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NoDataFailureCopyWith(
          _$NoDataFailure value, $Res Function(_$NoDataFailure) then) =
      __$$NoDataFailureCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class __$$NoDataFailureCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$$NoDataFailureCopyWith<$Res> {
  __$$NoDataFailureCopyWithImpl(
      _$NoDataFailure _value, $Res Function(_$NoDataFailure) _then)
      : super(_value, (v) => _then(v as _$NoDataFailure));

  @override
  _$NoDataFailure get _value => super._value as _$NoDataFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$NoDataFailure(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NoDataFailure implements NoDataFailure {
  _$NoDataFailure({this.message = "Sorry, there is no data here yet."});

  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'Failure.noDataFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoDataFailure &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$NoDataFailureCopyWith<_$NoDataFailure> get copyWith =>
      __$$NoDataFailureCopyWithImpl<_$NoDataFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) cacheFailure,
    required TResult Function(String? message) unExpectedFailure,
    required TResult Function(String? message) notFound,
    required TResult Function(String? message, String? key) validationFailure,
    required TResult Function(String? message) noDataFailure,
    required TResult Function(String? message) serverFailure,
    required TResult Function(String? message) networkFailure,
    required TResult Function(String? message) unauthorized,
  }) {
    return noDataFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
  }) {
    return noDataFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
    required TResult orElse(),
  }) {
    if (noDataFailure != null) {
      return noDataFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cacheFailure,
    required TResult Function(UnExpectedFailure value) unExpectedFailure,
    required TResult Function(NotFound value) notFound,
    required TResult Function(ValidationFailure value) validationFailure,
    required TResult Function(NoDataFailure value) noDataFailure,
    required TResult Function(ServerFailure value) serverFailure,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(UnAuthorizedFailure value) unauthorized,
  }) {
    return noDataFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
  }) {
    return noDataFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
    required TResult orElse(),
  }) {
    if (noDataFailure != null) {
      return noDataFailure(this);
    }
    return orElse();
  }
}

abstract class NoDataFailure implements Failure {
  factory NoDataFailure({final String? message}) = _$NoDataFailure;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$NoDataFailureCopyWith<_$NoDataFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerFailureCopyWith(
          _$ServerFailure value, $Res Function(_$ServerFailure) then) =
      __$$ServerFailureCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class __$$ServerFailureCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$$ServerFailureCopyWith<$Res> {
  __$$ServerFailureCopyWithImpl(
      _$ServerFailure _value, $Res Function(_$ServerFailure) _then)
      : super(_value, (v) => _then(v as _$ServerFailure));

  @override
  _$ServerFailure get _value => super._value as _$ServerFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ServerFailure(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ServerFailure implements ServerFailure {
  _$ServerFailure(
      {this.message =
          "Sorry, an error occurred on our part. Try again later."});

  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'Failure.serverFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailure &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$ServerFailureCopyWith<_$ServerFailure> get copyWith =>
      __$$ServerFailureCopyWithImpl<_$ServerFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) cacheFailure,
    required TResult Function(String? message) unExpectedFailure,
    required TResult Function(String? message) notFound,
    required TResult Function(String? message, String? key) validationFailure,
    required TResult Function(String? message) noDataFailure,
    required TResult Function(String? message) serverFailure,
    required TResult Function(String? message) networkFailure,
    required TResult Function(String? message) unauthorized,
  }) {
    return serverFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
  }) {
    return serverFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
    required TResult orElse(),
  }) {
    if (serverFailure != null) {
      return serverFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cacheFailure,
    required TResult Function(UnExpectedFailure value) unExpectedFailure,
    required TResult Function(NotFound value) notFound,
    required TResult Function(ValidationFailure value) validationFailure,
    required TResult Function(NoDataFailure value) noDataFailure,
    required TResult Function(ServerFailure value) serverFailure,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(UnAuthorizedFailure value) unauthorized,
  }) {
    return serverFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
  }) {
    return serverFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
    required TResult orElse(),
  }) {
    if (serverFailure != null) {
      return serverFailure(this);
    }
    return orElse();
  }
}

abstract class ServerFailure implements Failure {
  factory ServerFailure({final String? message}) = _$ServerFailure;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ServerFailureCopyWith<_$ServerFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureCopyWith(
          _$NetworkFailure value, $Res Function(_$NetworkFailure) then) =
      __$$NetworkFailureCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class __$$NetworkFailureCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$$NetworkFailureCopyWith<$Res> {
  __$$NetworkFailureCopyWithImpl(
      _$NetworkFailure _value, $Res Function(_$NetworkFailure) _then)
      : super(_value, (v) => _then(v as _$NetworkFailure));

  @override
  _$NetworkFailure get _value => super._value as _$NetworkFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$NetworkFailure(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NetworkFailure implements NetworkFailure {
  _$NetworkFailure(
      {this.message =
          "No connection, please connect to the Internet and try again."});

  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'Failure.networkFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailure &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$NetworkFailureCopyWith<_$NetworkFailure> get copyWith =>
      __$$NetworkFailureCopyWithImpl<_$NetworkFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) cacheFailure,
    required TResult Function(String? message) unExpectedFailure,
    required TResult Function(String? message) notFound,
    required TResult Function(String? message, String? key) validationFailure,
    required TResult Function(String? message) noDataFailure,
    required TResult Function(String? message) serverFailure,
    required TResult Function(String? message) networkFailure,
    required TResult Function(String? message) unauthorized,
  }) {
    return networkFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
  }) {
    return networkFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
    required TResult orElse(),
  }) {
    if (networkFailure != null) {
      return networkFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cacheFailure,
    required TResult Function(UnExpectedFailure value) unExpectedFailure,
    required TResult Function(NotFound value) notFound,
    required TResult Function(ValidationFailure value) validationFailure,
    required TResult Function(NoDataFailure value) noDataFailure,
    required TResult Function(ServerFailure value) serverFailure,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(UnAuthorizedFailure value) unauthorized,
  }) {
    return networkFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
  }) {
    return networkFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
    required TResult orElse(),
  }) {
    if (networkFailure != null) {
      return networkFailure(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements Failure {
  factory NetworkFailure({final String? message}) = _$NetworkFailure;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$NetworkFailureCopyWith<_$NetworkFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnAuthorizedFailureCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnAuthorizedFailureCopyWith(_$UnAuthorizedFailure value,
          $Res Function(_$UnAuthorizedFailure) then) =
      __$$UnAuthorizedFailureCopyWithImpl<$Res>;
  @override
  $Res call({String? message});
}

/// @nodoc
class __$$UnAuthorizedFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res>
    implements _$$UnAuthorizedFailureCopyWith<$Res> {
  __$$UnAuthorizedFailureCopyWithImpl(
      _$UnAuthorizedFailure _value, $Res Function(_$UnAuthorizedFailure) _then)
      : super(_value, (v) => _then(v as _$UnAuthorizedFailure));

  @override
  _$UnAuthorizedFailure get _value => super._value as _$UnAuthorizedFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UnAuthorizedFailure(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnAuthorizedFailure implements UnAuthorizedFailure {
  _$UnAuthorizedFailure(
      {this.message = "Not authorized, please signup or login and try again."});

  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'Failure.unauthorized(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnAuthorizedFailure &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$UnAuthorizedFailureCopyWith<_$UnAuthorizedFailure> get copyWith =>
      __$$UnAuthorizedFailureCopyWithImpl<_$UnAuthorizedFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) cacheFailure,
    required TResult Function(String? message) unExpectedFailure,
    required TResult Function(String? message) notFound,
    required TResult Function(String? message, String? key) validationFailure,
    required TResult Function(String? message) noDataFailure,
    required TResult Function(String? message) serverFailure,
    required TResult Function(String? message) networkFailure,
    required TResult Function(String? message) unauthorized,
  }) {
    return unauthorized(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
  }) {
    return unauthorized?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? cacheFailure,
    TResult Function(String? message)? unExpectedFailure,
    TResult Function(String? message)? notFound,
    TResult Function(String? message, String? key)? validationFailure,
    TResult Function(String? message)? noDataFailure,
    TResult Function(String? message)? serverFailure,
    TResult Function(String? message)? networkFailure,
    TResult Function(String? message)? unauthorized,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cacheFailure,
    required TResult Function(UnExpectedFailure value) unExpectedFailure,
    required TResult Function(NotFound value) notFound,
    required TResult Function(ValidationFailure value) validationFailure,
    required TResult Function(NoDataFailure value) noDataFailure,
    required TResult Function(ServerFailure value) serverFailure,
    required TResult Function(NetworkFailure value) networkFailure,
    required TResult Function(UnAuthorizedFailure value) unauthorized,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cacheFailure,
    TResult Function(UnExpectedFailure value)? unExpectedFailure,
    TResult Function(NotFound value)? notFound,
    TResult Function(ValidationFailure value)? validationFailure,
    TResult Function(NoDataFailure value)? noDataFailure,
    TResult Function(ServerFailure value)? serverFailure,
    TResult Function(NetworkFailure value)? networkFailure,
    TResult Function(UnAuthorizedFailure value)? unauthorized,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class UnAuthorizedFailure implements Failure {
  factory UnAuthorizedFailure({final String? message}) = _$UnAuthorizedFailure;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$UnAuthorizedFailureCopyWith<_$UnAuthorizedFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
