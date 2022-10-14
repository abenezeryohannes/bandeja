// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        CodeSentState,
    required TResult Function() NotVerifiedState,
    required TResult Function() VerifiyingState,
    required TResult Function() ConfirmingState,
    required TResult Function(Failure failure) VerificationFailedState,
    required TResult Function(Failure failure) ConfirmationFailedState,
    required TResult Function(PhoneAuthCredential phoneAuthCredential)
        VerifiedState,
    required TResult Function(User user) ConfirmedState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeSentState<T> value) CodeSentState,
    required TResult Function(NotVerifiedState<T> value) NotVerifiedState,
    required TResult Function(VerifiyingState<T> value) VerifiyingState,
    required TResult Function(ConfirmingState<T> value) ConfirmingState,
    required TResult Function(VerificationFailedState<T> value)
        VerificationFailedState,
    required TResult Function(ConfirmationFailedState<T> value)
        ConfirmationFailedState,
    required TResult Function(VerifiedState<T> value) VerifiedState,
    required TResult Function(ConfirmedState<T> value) ConfirmedState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<T, $Res> {
  factory $AuthStateCopyWith(
          AuthState<T> value, $Res Function(AuthState<T>) then) =
      _$AuthStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<T, $Res> implements $AuthStateCopyWith<T, $Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState<T> _value;
  // ignore: unused_field
  final $Res Function(AuthState<T>) _then;
}

/// @nodoc
abstract class _$$CodeSentStateCopyWith<T, $Res> {
  factory _$$CodeSentStateCopyWith(
          _$CodeSentState<T> value, $Res Function(_$CodeSentState<T>) then) =
      __$$CodeSentStateCopyWithImpl<T, $Res>;
  $Res call({String verificationId, int? resendToken});
}

/// @nodoc
class __$$CodeSentStateCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements _$$CodeSentStateCopyWith<T, $Res> {
  __$$CodeSentStateCopyWithImpl(
      _$CodeSentState<T> _value, $Res Function(_$CodeSentState<T>) _then)
      : super(_value, (v) => _then(v as _$CodeSentState<T>));

  @override
  _$CodeSentState<T> get _value => super._value as _$CodeSentState<T>;

  @override
  $Res call({
    Object? verificationId = freezed,
    Object? resendToken = freezed,
  }) {
    return _then(_$CodeSentState<T>(
      verificationId: verificationId == freezed
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      resendToken: resendToken == freezed
          ? _value.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CodeSentState<T> implements CodeSentState<T> {
  _$CodeSentState({required this.verificationId, this.resendToken});

  @override
  final String verificationId;
  @override
  final int? resendToken;

  @override
  String toString() {
    return 'AuthState<$T>.CodeSentState(verificationId: $verificationId, resendToken: $resendToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeSentState<T> &&
            const DeepCollectionEquality()
                .equals(other.verificationId, verificationId) &&
            const DeepCollectionEquality()
                .equals(other.resendToken, resendToken));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(verificationId),
      const DeepCollectionEquality().hash(resendToken));

  @JsonKey(ignore: true)
  @override
  _$$CodeSentStateCopyWith<T, _$CodeSentState<T>> get copyWith =>
      __$$CodeSentStateCopyWithImpl<T, _$CodeSentState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        CodeSentState,
    required TResult Function() NotVerifiedState,
    required TResult Function() VerifiyingState,
    required TResult Function() ConfirmingState,
    required TResult Function(Failure failure) VerificationFailedState,
    required TResult Function(Failure failure) ConfirmationFailedState,
    required TResult Function(PhoneAuthCredential phoneAuthCredential)
        VerifiedState,
    required TResult Function(User user) ConfirmedState,
  }) {
    return CodeSentState(verificationId, resendToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
  }) {
    return CodeSentState?.call(verificationId, resendToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (CodeSentState != null) {
      return CodeSentState(verificationId, resendToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeSentState<T> value) CodeSentState,
    required TResult Function(NotVerifiedState<T> value) NotVerifiedState,
    required TResult Function(VerifiyingState<T> value) VerifiyingState,
    required TResult Function(ConfirmingState<T> value) ConfirmingState,
    required TResult Function(VerificationFailedState<T> value)
        VerificationFailedState,
    required TResult Function(ConfirmationFailedState<T> value)
        ConfirmationFailedState,
    required TResult Function(VerifiedState<T> value) VerifiedState,
    required TResult Function(ConfirmedState<T> value) ConfirmedState,
  }) {
    return CodeSentState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
  }) {
    return CodeSentState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (CodeSentState != null) {
      return CodeSentState(this);
    }
    return orElse();
  }
}

abstract class CodeSentState<T> implements AuthState<T> {
  factory CodeSentState(
      {required final String verificationId,
      final int? resendToken}) = _$CodeSentState<T>;

  String get verificationId;
  int? get resendToken;
  @JsonKey(ignore: true)
  _$$CodeSentStateCopyWith<T, _$CodeSentState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotVerifiedStateCopyWith<T, $Res> {
  factory _$$NotVerifiedStateCopyWith(_$NotVerifiedState<T> value,
          $Res Function(_$NotVerifiedState<T>) then) =
      __$$NotVerifiedStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$NotVerifiedStateCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements _$$NotVerifiedStateCopyWith<T, $Res> {
  __$$NotVerifiedStateCopyWithImpl(
      _$NotVerifiedState<T> _value, $Res Function(_$NotVerifiedState<T>) _then)
      : super(_value, (v) => _then(v as _$NotVerifiedState<T>));

  @override
  _$NotVerifiedState<T> get _value => super._value as _$NotVerifiedState<T>;
}

/// @nodoc

class _$NotVerifiedState<T> implements NotVerifiedState<T> {
  _$NotVerifiedState();

  @override
  String toString() {
    return 'AuthState<$T>.NotVerifiedState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotVerifiedState<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        CodeSentState,
    required TResult Function() NotVerifiedState,
    required TResult Function() VerifiyingState,
    required TResult Function() ConfirmingState,
    required TResult Function(Failure failure) VerificationFailedState,
    required TResult Function(Failure failure) ConfirmationFailedState,
    required TResult Function(PhoneAuthCredential phoneAuthCredential)
        VerifiedState,
    required TResult Function(User user) ConfirmedState,
  }) {
    return NotVerifiedState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
  }) {
    return NotVerifiedState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (NotVerifiedState != null) {
      return NotVerifiedState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeSentState<T> value) CodeSentState,
    required TResult Function(NotVerifiedState<T> value) NotVerifiedState,
    required TResult Function(VerifiyingState<T> value) VerifiyingState,
    required TResult Function(ConfirmingState<T> value) ConfirmingState,
    required TResult Function(VerificationFailedState<T> value)
        VerificationFailedState,
    required TResult Function(ConfirmationFailedState<T> value)
        ConfirmationFailedState,
    required TResult Function(VerifiedState<T> value) VerifiedState,
    required TResult Function(ConfirmedState<T> value) ConfirmedState,
  }) {
    return NotVerifiedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
  }) {
    return NotVerifiedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (NotVerifiedState != null) {
      return NotVerifiedState(this);
    }
    return orElse();
  }
}

abstract class NotVerifiedState<T> implements AuthState<T> {
  factory NotVerifiedState() = _$NotVerifiedState<T>;
}

/// @nodoc
abstract class _$$VerifiyingStateCopyWith<T, $Res> {
  factory _$$VerifiyingStateCopyWith(_$VerifiyingState<T> value,
          $Res Function(_$VerifiyingState<T>) then) =
      __$$VerifiyingStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$VerifiyingStateCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements _$$VerifiyingStateCopyWith<T, $Res> {
  __$$VerifiyingStateCopyWithImpl(
      _$VerifiyingState<T> _value, $Res Function(_$VerifiyingState<T>) _then)
      : super(_value, (v) => _then(v as _$VerifiyingState<T>));

  @override
  _$VerifiyingState<T> get _value => super._value as _$VerifiyingState<T>;
}

/// @nodoc

class _$VerifiyingState<T> implements VerifiyingState<T> {
  _$VerifiyingState();

  @override
  String toString() {
    return 'AuthState<$T>.VerifiyingState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VerifiyingState<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        CodeSentState,
    required TResult Function() NotVerifiedState,
    required TResult Function() VerifiyingState,
    required TResult Function() ConfirmingState,
    required TResult Function(Failure failure) VerificationFailedState,
    required TResult Function(Failure failure) ConfirmationFailedState,
    required TResult Function(PhoneAuthCredential phoneAuthCredential)
        VerifiedState,
    required TResult Function(User user) ConfirmedState,
  }) {
    return VerifiyingState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
  }) {
    return VerifiyingState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (VerifiyingState != null) {
      return VerifiyingState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeSentState<T> value) CodeSentState,
    required TResult Function(NotVerifiedState<T> value) NotVerifiedState,
    required TResult Function(VerifiyingState<T> value) VerifiyingState,
    required TResult Function(ConfirmingState<T> value) ConfirmingState,
    required TResult Function(VerificationFailedState<T> value)
        VerificationFailedState,
    required TResult Function(ConfirmationFailedState<T> value)
        ConfirmationFailedState,
    required TResult Function(VerifiedState<T> value) VerifiedState,
    required TResult Function(ConfirmedState<T> value) ConfirmedState,
  }) {
    return VerifiyingState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
  }) {
    return VerifiyingState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (VerifiyingState != null) {
      return VerifiyingState(this);
    }
    return orElse();
  }
}

abstract class VerifiyingState<T> implements AuthState<T> {
  factory VerifiyingState() = _$VerifiyingState<T>;
}

/// @nodoc
abstract class _$$ConfirmingStateCopyWith<T, $Res> {
  factory _$$ConfirmingStateCopyWith(_$ConfirmingState<T> value,
          $Res Function(_$ConfirmingState<T>) then) =
      __$$ConfirmingStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ConfirmingStateCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements _$$ConfirmingStateCopyWith<T, $Res> {
  __$$ConfirmingStateCopyWithImpl(
      _$ConfirmingState<T> _value, $Res Function(_$ConfirmingState<T>) _then)
      : super(_value, (v) => _then(v as _$ConfirmingState<T>));

  @override
  _$ConfirmingState<T> get _value => super._value as _$ConfirmingState<T>;
}

/// @nodoc

class _$ConfirmingState<T> implements ConfirmingState<T> {
  _$ConfirmingState();

  @override
  String toString() {
    return 'AuthState<$T>.ConfirmingState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConfirmingState<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        CodeSentState,
    required TResult Function() NotVerifiedState,
    required TResult Function() VerifiyingState,
    required TResult Function() ConfirmingState,
    required TResult Function(Failure failure) VerificationFailedState,
    required TResult Function(Failure failure) ConfirmationFailedState,
    required TResult Function(PhoneAuthCredential phoneAuthCredential)
        VerifiedState,
    required TResult Function(User user) ConfirmedState,
  }) {
    return ConfirmingState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
  }) {
    return ConfirmingState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (ConfirmingState != null) {
      return ConfirmingState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeSentState<T> value) CodeSentState,
    required TResult Function(NotVerifiedState<T> value) NotVerifiedState,
    required TResult Function(VerifiyingState<T> value) VerifiyingState,
    required TResult Function(ConfirmingState<T> value) ConfirmingState,
    required TResult Function(VerificationFailedState<T> value)
        VerificationFailedState,
    required TResult Function(ConfirmationFailedState<T> value)
        ConfirmationFailedState,
    required TResult Function(VerifiedState<T> value) VerifiedState,
    required TResult Function(ConfirmedState<T> value) ConfirmedState,
  }) {
    return ConfirmingState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
  }) {
    return ConfirmingState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (ConfirmingState != null) {
      return ConfirmingState(this);
    }
    return orElse();
  }
}

abstract class ConfirmingState<T> implements AuthState<T> {
  factory ConfirmingState() = _$ConfirmingState<T>;
}

/// @nodoc
abstract class _$$VerificationFailedStateCopyWith<T, $Res> {
  factory _$$VerificationFailedStateCopyWith(_$VerificationFailedState<T> value,
          $Res Function(_$VerificationFailedState<T>) then) =
      __$$VerificationFailedStateCopyWithImpl<T, $Res>;
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$VerificationFailedStateCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements _$$VerificationFailedStateCopyWith<T, $Res> {
  __$$VerificationFailedStateCopyWithImpl(_$VerificationFailedState<T> _value,
      $Res Function(_$VerificationFailedState<T>) _then)
      : super(_value, (v) => _then(v as _$VerificationFailedState<T>));

  @override
  _$VerificationFailedState<T> get _value =>
      super._value as _$VerificationFailedState<T>;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_$VerificationFailedState<T>(
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

class _$VerificationFailedState<T> implements VerificationFailedState<T> {
  _$VerificationFailedState({required this.failure});

  @override
  final Failure failure;

  @override
  String toString() {
    return 'AuthState<$T>.VerificationFailedState(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationFailedState<T> &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  _$$VerificationFailedStateCopyWith<T, _$VerificationFailedState<T>>
      get copyWith => __$$VerificationFailedStateCopyWithImpl<T,
          _$VerificationFailedState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        CodeSentState,
    required TResult Function() NotVerifiedState,
    required TResult Function() VerifiyingState,
    required TResult Function() ConfirmingState,
    required TResult Function(Failure failure) VerificationFailedState,
    required TResult Function(Failure failure) ConfirmationFailedState,
    required TResult Function(PhoneAuthCredential phoneAuthCredential)
        VerifiedState,
    required TResult Function(User user) ConfirmedState,
  }) {
    return VerificationFailedState(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
  }) {
    return VerificationFailedState?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (VerificationFailedState != null) {
      return VerificationFailedState(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeSentState<T> value) CodeSentState,
    required TResult Function(NotVerifiedState<T> value) NotVerifiedState,
    required TResult Function(VerifiyingState<T> value) VerifiyingState,
    required TResult Function(ConfirmingState<T> value) ConfirmingState,
    required TResult Function(VerificationFailedState<T> value)
        VerificationFailedState,
    required TResult Function(ConfirmationFailedState<T> value)
        ConfirmationFailedState,
    required TResult Function(VerifiedState<T> value) VerifiedState,
    required TResult Function(ConfirmedState<T> value) ConfirmedState,
  }) {
    return VerificationFailedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
  }) {
    return VerificationFailedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (VerificationFailedState != null) {
      return VerificationFailedState(this);
    }
    return orElse();
  }
}

abstract class VerificationFailedState<T> implements AuthState<T> {
  factory VerificationFailedState({required final Failure failure}) =
      _$VerificationFailedState<T>;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$VerificationFailedStateCopyWith<T, _$VerificationFailedState<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmationFailedStateCopyWith<T, $Res> {
  factory _$$ConfirmationFailedStateCopyWith(_$ConfirmationFailedState<T> value,
          $Res Function(_$ConfirmationFailedState<T>) then) =
      __$$ConfirmationFailedStateCopyWithImpl<T, $Res>;
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$ConfirmationFailedStateCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements _$$ConfirmationFailedStateCopyWith<T, $Res> {
  __$$ConfirmationFailedStateCopyWithImpl(_$ConfirmationFailedState<T> _value,
      $Res Function(_$ConfirmationFailedState<T>) _then)
      : super(_value, (v) => _then(v as _$ConfirmationFailedState<T>));

  @override
  _$ConfirmationFailedState<T> get _value =>
      super._value as _$ConfirmationFailedState<T>;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_$ConfirmationFailedState<T>(
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

class _$ConfirmationFailedState<T> implements ConfirmationFailedState<T> {
  _$ConfirmationFailedState({required this.failure});

  @override
  final Failure failure;

  @override
  String toString() {
    return 'AuthState<$T>.ConfirmationFailedState(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmationFailedState<T> &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  _$$ConfirmationFailedStateCopyWith<T, _$ConfirmationFailedState<T>>
      get copyWith => __$$ConfirmationFailedStateCopyWithImpl<T,
          _$ConfirmationFailedState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        CodeSentState,
    required TResult Function() NotVerifiedState,
    required TResult Function() VerifiyingState,
    required TResult Function() ConfirmingState,
    required TResult Function(Failure failure) VerificationFailedState,
    required TResult Function(Failure failure) ConfirmationFailedState,
    required TResult Function(PhoneAuthCredential phoneAuthCredential)
        VerifiedState,
    required TResult Function(User user) ConfirmedState,
  }) {
    return ConfirmationFailedState(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
  }) {
    return ConfirmationFailedState?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (ConfirmationFailedState != null) {
      return ConfirmationFailedState(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeSentState<T> value) CodeSentState,
    required TResult Function(NotVerifiedState<T> value) NotVerifiedState,
    required TResult Function(VerifiyingState<T> value) VerifiyingState,
    required TResult Function(ConfirmingState<T> value) ConfirmingState,
    required TResult Function(VerificationFailedState<T> value)
        VerificationFailedState,
    required TResult Function(ConfirmationFailedState<T> value)
        ConfirmationFailedState,
    required TResult Function(VerifiedState<T> value) VerifiedState,
    required TResult Function(ConfirmedState<T> value) ConfirmedState,
  }) {
    return ConfirmationFailedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
  }) {
    return ConfirmationFailedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (ConfirmationFailedState != null) {
      return ConfirmationFailedState(this);
    }
    return orElse();
  }
}

abstract class ConfirmationFailedState<T> implements AuthState<T> {
  factory ConfirmationFailedState({required final Failure failure}) =
      _$ConfirmationFailedState<T>;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$ConfirmationFailedStateCopyWith<T, _$ConfirmationFailedState<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifiedStateCopyWith<T, $Res> {
  factory _$$VerifiedStateCopyWith(
          _$VerifiedState<T> value, $Res Function(_$VerifiedState<T>) then) =
      __$$VerifiedStateCopyWithImpl<T, $Res>;
  $Res call({PhoneAuthCredential phoneAuthCredential});
}

/// @nodoc
class __$$VerifiedStateCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements _$$VerifiedStateCopyWith<T, $Res> {
  __$$VerifiedStateCopyWithImpl(
      _$VerifiedState<T> _value, $Res Function(_$VerifiedState<T>) _then)
      : super(_value, (v) => _then(v as _$VerifiedState<T>));

  @override
  _$VerifiedState<T> get _value => super._value as _$VerifiedState<T>;

  @override
  $Res call({
    Object? phoneAuthCredential = freezed,
  }) {
    return _then(_$VerifiedState<T>(
      phoneAuthCredential: phoneAuthCredential == freezed
          ? _value.phoneAuthCredential
          : phoneAuthCredential // ignore: cast_nullable_to_non_nullable
              as PhoneAuthCredential,
    ));
  }
}

/// @nodoc

class _$VerifiedState<T> implements VerifiedState<T> {
  _$VerifiedState({required this.phoneAuthCredential});

  @override
  final PhoneAuthCredential phoneAuthCredential;

  @override
  String toString() {
    return 'AuthState<$T>.VerifiedState(phoneAuthCredential: $phoneAuthCredential)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifiedState<T> &&
            const DeepCollectionEquality()
                .equals(other.phoneAuthCredential, phoneAuthCredential));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(phoneAuthCredential));

  @JsonKey(ignore: true)
  @override
  _$$VerifiedStateCopyWith<T, _$VerifiedState<T>> get copyWith =>
      __$$VerifiedStateCopyWithImpl<T, _$VerifiedState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        CodeSentState,
    required TResult Function() NotVerifiedState,
    required TResult Function() VerifiyingState,
    required TResult Function() ConfirmingState,
    required TResult Function(Failure failure) VerificationFailedState,
    required TResult Function(Failure failure) ConfirmationFailedState,
    required TResult Function(PhoneAuthCredential phoneAuthCredential)
        VerifiedState,
    required TResult Function(User user) ConfirmedState,
  }) {
    return VerifiedState(phoneAuthCredential);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
  }) {
    return VerifiedState?.call(phoneAuthCredential);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (VerifiedState != null) {
      return VerifiedState(phoneAuthCredential);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeSentState<T> value) CodeSentState,
    required TResult Function(NotVerifiedState<T> value) NotVerifiedState,
    required TResult Function(VerifiyingState<T> value) VerifiyingState,
    required TResult Function(ConfirmingState<T> value) ConfirmingState,
    required TResult Function(VerificationFailedState<T> value)
        VerificationFailedState,
    required TResult Function(ConfirmationFailedState<T> value)
        ConfirmationFailedState,
    required TResult Function(VerifiedState<T> value) VerifiedState,
    required TResult Function(ConfirmedState<T> value) ConfirmedState,
  }) {
    return VerifiedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
  }) {
    return VerifiedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (VerifiedState != null) {
      return VerifiedState(this);
    }
    return orElse();
  }
}

abstract class VerifiedState<T> implements AuthState<T> {
  factory VerifiedState(
          {required final PhoneAuthCredential phoneAuthCredential}) =
      _$VerifiedState<T>;

  PhoneAuthCredential get phoneAuthCredential;
  @JsonKey(ignore: true)
  _$$VerifiedStateCopyWith<T, _$VerifiedState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmedStateCopyWith<T, $Res> {
  factory _$$ConfirmedStateCopyWith(
          _$ConfirmedState<T> value, $Res Function(_$ConfirmedState<T>) then) =
      __$$ConfirmedStateCopyWithImpl<T, $Res>;
  $Res call({User user});
}

/// @nodoc
class __$$ConfirmedStateCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements _$$ConfirmedStateCopyWith<T, $Res> {
  __$$ConfirmedStateCopyWithImpl(
      _$ConfirmedState<T> _value, $Res Function(_$ConfirmedState<T>) _then)
      : super(_value, (v) => _then(v as _$ConfirmedState<T>));

  @override
  _$ConfirmedState<T> get _value => super._value as _$ConfirmedState<T>;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$ConfirmedState<T>(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$ConfirmedState<T> implements ConfirmedState<T> {
  _$ConfirmedState({required this.user});

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState<$T>.ConfirmedState(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmedState<T> &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$ConfirmedStateCopyWith<T, _$ConfirmedState<T>> get copyWith =>
      __$$ConfirmedStateCopyWithImpl<T, _$ConfirmedState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        CodeSentState,
    required TResult Function() NotVerifiedState,
    required TResult Function() VerifiyingState,
    required TResult Function() ConfirmingState,
    required TResult Function(Failure failure) VerificationFailedState,
    required TResult Function(Failure failure) ConfirmationFailedState,
    required TResult Function(PhoneAuthCredential phoneAuthCredential)
        VerifiedState,
    required TResult Function(User user) ConfirmedState,
  }) {
    return ConfirmedState(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
  }) {
    return ConfirmedState?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? CodeSentState,
    TResult Function()? NotVerifiedState,
    TResult Function()? VerifiyingState,
    TResult Function()? ConfirmingState,
    TResult Function(Failure failure)? VerificationFailedState,
    TResult Function(Failure failure)? ConfirmationFailedState,
    TResult Function(PhoneAuthCredential phoneAuthCredential)? VerifiedState,
    TResult Function(User user)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (ConfirmedState != null) {
      return ConfirmedState(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeSentState<T> value) CodeSentState,
    required TResult Function(NotVerifiedState<T> value) NotVerifiedState,
    required TResult Function(VerifiyingState<T> value) VerifiyingState,
    required TResult Function(ConfirmingState<T> value) ConfirmingState,
    required TResult Function(VerificationFailedState<T> value)
        VerificationFailedState,
    required TResult Function(ConfirmationFailedState<T> value)
        ConfirmationFailedState,
    required TResult Function(VerifiedState<T> value) VerifiedState,
    required TResult Function(ConfirmedState<T> value) ConfirmedState,
  }) {
    return ConfirmedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
  }) {
    return ConfirmedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeSentState<T> value)? CodeSentState,
    TResult Function(NotVerifiedState<T> value)? NotVerifiedState,
    TResult Function(VerifiyingState<T> value)? VerifiyingState,
    TResult Function(ConfirmingState<T> value)? ConfirmingState,
    TResult Function(VerificationFailedState<T> value)? VerificationFailedState,
    TResult Function(ConfirmationFailedState<T> value)? ConfirmationFailedState,
    TResult Function(VerifiedState<T> value)? VerifiedState,
    TResult Function(ConfirmedState<T> value)? ConfirmedState,
    required TResult orElse(),
  }) {
    if (ConfirmedState != null) {
      return ConfirmedState(this);
    }
    return orElse();
  }
}

abstract class ConfirmedState<T> implements AuthState<T> {
  factory ConfirmedState({required final User user}) = _$ConfirmedState<T>;

  User get user;
  @JsonKey(ignore: true)
  _$$ConfirmedStateCopyWith<T, _$ConfirmedState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
