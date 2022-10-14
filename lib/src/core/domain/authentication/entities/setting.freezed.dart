// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SettingModel _$SettingModelFromJson(Map<String, dynamic> json) {
  return _SettingModel.fromJson(json);
}

/// @nodoc
mixin _$SettingModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  bool get bookingNotification => throw _privateConstructorUsedError;
  bool get faceId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingModelCopyWith<SettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingModelCopyWith<$Res> {
  factory $SettingModelCopyWith(
          SettingModel value, $Res Function(SettingModel) then) =
      _$SettingModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int userId,
      bool bookingNotification,
      bool faceId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$SettingModelCopyWithImpl<$Res> implements $SettingModelCopyWith<$Res> {
  _$SettingModelCopyWithImpl(this._value, this._then);

  final SettingModel _value;
  // ignore: unused_field
  final $Res Function(SettingModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? bookingNotification = freezed,
    Object? faceId = freezed,
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
      bookingNotification: bookingNotification == freezed
          ? _value.bookingNotification
          : bookingNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      faceId: faceId == freezed
          ? _value.faceId
          : faceId // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$_SettingModelCopyWith<$Res>
    implements $SettingModelCopyWith<$Res> {
  factory _$$_SettingModelCopyWith(
          _$_SettingModel value, $Res Function(_$_SettingModel) then) =
      __$$_SettingModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int userId,
      bool bookingNotification,
      bool faceId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_SettingModelCopyWithImpl<$Res>
    extends _$SettingModelCopyWithImpl<$Res>
    implements _$$_SettingModelCopyWith<$Res> {
  __$$_SettingModelCopyWithImpl(
      _$_SettingModel _value, $Res Function(_$_SettingModel) _then)
      : super(_value, (v) => _then(v as _$_SettingModel));

  @override
  _$_SettingModel get _value => super._value as _$_SettingModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? bookingNotification = freezed,
    Object? faceId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_SettingModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      bookingNotification: bookingNotification == freezed
          ? _value.bookingNotification
          : bookingNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      faceId: faceId == freezed
          ? _value.faceId
          : faceId // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$_SettingModel implements _SettingModel {
  _$_SettingModel(
      {this.id = -1,
      required this.userId,
      this.bookingNotification = true,
      this.faceId = true,
      this.createdAt,
      this.updatedAt});

  factory _$_SettingModel.fromJson(Map<String, dynamic> json) =>
      _$$_SettingModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int userId;
  @override
  @JsonKey()
  final bool bookingNotification;
  @override
  @JsonKey()
  final bool faceId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'SettingModel(id: $id, userId: $userId, bookingNotification: $bookingNotification, faceId: $faceId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.bookingNotification, bookingNotification) &&
            const DeepCollectionEquality().equals(other.faceId, faceId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(bookingNotification),
      const DeepCollectionEquality().hash(faceId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_SettingModelCopyWith<_$_SettingModel> get copyWith =>
      __$$_SettingModelCopyWithImpl<_$_SettingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingModelToJson(
      this,
    );
  }
}

abstract class _SettingModel implements SettingModel {
  factory _SettingModel(
      {final int id,
      required final int userId,
      final bool bookingNotification,
      final bool faceId,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_SettingModel;

  factory _SettingModel.fromJson(Map<String, dynamic> json) =
      _$_SettingModel.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  bool get bookingNotification;
  @override
  bool get faceId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_SettingModelCopyWith<_$_SettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}
