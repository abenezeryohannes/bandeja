// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) {
  return _TokenModel.fromJson(json);
}

/// @nodoc
mixin _$TokenModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  DateTime? get validUntil => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenModelCopyWith<TokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenModelCopyWith<$Res> {
  factory $TokenModelCopyWith(
          TokenModel value, $Res Function(TokenModel) then) =
      _$TokenModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int userId,
      String token,
      DateTime? validUntil,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$TokenModelCopyWithImpl<$Res> implements $TokenModelCopyWith<$Res> {
  _$TokenModelCopyWithImpl(this._value, this._then);

  final TokenModel _value;
  // ignore: unused_field
  final $Res Function(TokenModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? token = freezed,
    Object? validUntil = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      validUntil: validUntil == freezed
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_TokenModelCopyWith<$Res>
    implements $TokenModelCopyWith<$Res> {
  factory _$$_TokenModelCopyWith(
          _$_TokenModel value, $Res Function(_$_TokenModel) then) =
      __$$_TokenModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int userId,
      String token,
      DateTime? validUntil,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_TokenModelCopyWithImpl<$Res> extends _$TokenModelCopyWithImpl<$Res>
    implements _$$_TokenModelCopyWith<$Res> {
  __$$_TokenModelCopyWithImpl(
      _$_TokenModel _value, $Res Function(_$_TokenModel) _then)
      : super(_value, (v) => _then(v as _$_TokenModel));

  @override
  _$_TokenModel get _value => super._value as _$_TokenModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? token = freezed,
    Object? validUntil = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_TokenModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      validUntil: validUntil == freezed
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenModel with DiagnosticableTreeMixin implements _TokenModel {
  _$_TokenModel(
      {this.id = -1,
      required this.userId,
      this.token = "token",
      this.validUntil,
      this.createdAt,
      this.updatedAt});

  factory _$_TokenModel.fromJson(Map<String, dynamic> json) =>
      _$$_TokenModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int userId;
  @override
  @JsonKey()
  final String token;
  @override
  final DateTime? validUntil;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TokenModel(id: $id, userId: $userId, token: $token, validUntil: $validUntil, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TokenModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('validUntil', validUntil))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality()
                .equals(other.validUntil, validUntil) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(validUntil),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_TokenModelCopyWith<_$_TokenModel> get copyWith =>
      __$$_TokenModelCopyWithImpl<_$_TokenModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenModelToJson(
      this,
    );
  }
}

abstract class _TokenModel implements TokenModel {
  factory _TokenModel(
      {final int id,
      required final int userId,
      final String token,
      final DateTime? validUntil,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_TokenModel;

  factory _TokenModel.fromJson(Map<String, dynamic> json) =
      _$_TokenModel.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get token;
  @override
  DateTime? get validUntil;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_TokenModelCopyWith<_$_TokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}
