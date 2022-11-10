// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'padel.padel.group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PadelPadelGroupModel _$PadelPadelGroupModelFromJson(Map<String, dynamic> json) {
  return _PadelPadelGroup.fromJson(json);
}

/// @nodoc
mixin _$PadelPadelGroupModel {
  int get id => throw _privateConstructorUsedError;
  int? get padelGroupId => throw _privateConstructorUsedError;
  int? get padelId => throw _privateConstructorUsedError; // PadelModel? Padel,
// PadelGroupModel? PadelGroup,
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PadelPadelGroupModelCopyWith<PadelPadelGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadelPadelGroupModelCopyWith<$Res> {
  factory $PadelPadelGroupModelCopyWith(PadelPadelGroupModel value,
          $Res Function(PadelPadelGroupModel) then) =
      _$PadelPadelGroupModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int? padelGroupId,
      int? padelId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PadelPadelGroupModelCopyWithImpl<$Res>
    implements $PadelPadelGroupModelCopyWith<$Res> {
  _$PadelPadelGroupModelCopyWithImpl(this._value, this._then);

  final PadelPadelGroupModel _value;
  // ignore: unused_field
  final $Res Function(PadelPadelGroupModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? padelGroupId = freezed,
    Object? padelId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      padelGroupId: padelGroupId == freezed
          ? _value.padelGroupId
          : padelGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$_PadelPadelGroupCopyWith<$Res>
    implements $PadelPadelGroupModelCopyWith<$Res> {
  factory _$$_PadelPadelGroupCopyWith(
          _$_PadelPadelGroup value, $Res Function(_$_PadelPadelGroup) then) =
      __$$_PadelPadelGroupCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int? padelGroupId,
      int? padelId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_PadelPadelGroupCopyWithImpl<$Res>
    extends _$PadelPadelGroupModelCopyWithImpl<$Res>
    implements _$$_PadelPadelGroupCopyWith<$Res> {
  __$$_PadelPadelGroupCopyWithImpl(
      _$_PadelPadelGroup _value, $Res Function(_$_PadelPadelGroup) _then)
      : super(_value, (v) => _then(v as _$_PadelPadelGroup));

  @override
  _$_PadelPadelGroup get _value => super._value as _$_PadelPadelGroup;

  @override
  $Res call({
    Object? id = freezed,
    Object? padelGroupId = freezed,
    Object? padelId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_PadelPadelGroup(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      padelGroupId: padelGroupId == freezed
          ? _value.padelGroupId
          : padelGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$_PadelPadelGroup implements _PadelPadelGroup {
  _$_PadelPadelGroup(
      {this.id = -1,
      this.padelGroupId,
      this.padelId,
      this.createdAt,
      this.updatedAt});

  factory _$_PadelPadelGroup.fromJson(Map<String, dynamic> json) =>
      _$$_PadelPadelGroupFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int? padelGroupId;
  @override
  final int? padelId;
// PadelModel? Padel,
// PadelGroupModel? PadelGroup,
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PadelPadelGroupModel(id: $id, padelGroupId: $padelGroupId, padelId: $padelId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PadelPadelGroup &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.padelGroupId, padelGroupId) &&
            const DeepCollectionEquality().equals(other.padelId, padelId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(padelGroupId),
      const DeepCollectionEquality().hash(padelId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_PadelPadelGroupCopyWith<_$_PadelPadelGroup> get copyWith =>
      __$$_PadelPadelGroupCopyWithImpl<_$_PadelPadelGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PadelPadelGroupToJson(
      this,
    );
  }
}

abstract class _PadelPadelGroup implements PadelPadelGroupModel {
  factory _PadelPadelGroup(
      {final int id,
      final int? padelGroupId,
      final int? padelId,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_PadelPadelGroup;

  factory _PadelPadelGroup.fromJson(Map<String, dynamic> json) =
      _$_PadelPadelGroup.fromJson;

  @override
  int get id;
  @override
  int? get padelGroupId;
  @override
  int? get padelId;
  @override // PadelModel? Padel,
// PadelGroupModel? PadelGroup,
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PadelPadelGroupCopyWith<_$_PadelPadelGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
