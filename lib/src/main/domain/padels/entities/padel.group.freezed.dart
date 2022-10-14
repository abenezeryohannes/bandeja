// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'padel.group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PadelGroupModel _$PadelGroupModelFromJson(Map<String, dynamic> json) {
  return _PadelGroupModel.fromJson(json);
}

/// @nodoc
mixin _$PadelGroupModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int get sequence => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<PadelModel>? get Padels => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PadelGroupModelCopyWith<PadelGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadelGroupModelCopyWith<$Res> {
  factory $PadelGroupModelCopyWith(
          PadelGroupModel value, $Res Function(PadelGroupModel) then) =
      _$PadelGroupModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      String icon,
      String? color,
      int sequence,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<PadelModel>? Padels});
}

/// @nodoc
class _$PadelGroupModelCopyWithImpl<$Res>
    implements $PadelGroupModelCopyWith<$Res> {
  _$PadelGroupModelCopyWithImpl(this._value, this._then);

  final PadelGroupModel _value;
  // ignore: unused_field
  final $Res Function(PadelGroupModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? sequence = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? Padels = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      sequence: sequence == freezed
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      Padels: Padels == freezed
          ? _value.Padels
          : Padels // ignore: cast_nullable_to_non_nullable
              as List<PadelModel>?,
    ));
  }
}

/// @nodoc
abstract class _$$_PadelGroupModelCopyWith<$Res>
    implements $PadelGroupModelCopyWith<$Res> {
  factory _$$_PadelGroupModelCopyWith(
          _$_PadelGroupModel value, $Res Function(_$_PadelGroupModel) then) =
      __$$_PadelGroupModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      String icon,
      String? color,
      int sequence,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<PadelModel>? Padels});
}

/// @nodoc
class __$$_PadelGroupModelCopyWithImpl<$Res>
    extends _$PadelGroupModelCopyWithImpl<$Res>
    implements _$$_PadelGroupModelCopyWith<$Res> {
  __$$_PadelGroupModelCopyWithImpl(
      _$_PadelGroupModel _value, $Res Function(_$_PadelGroupModel) _then)
      : super(_value, (v) => _then(v as _$_PadelGroupModel));

  @override
  _$_PadelGroupModel get _value => super._value as _$_PadelGroupModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? sequence = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? Padels = freezed,
  }) {
    return _then(_$_PadelGroupModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      sequence: sequence == freezed
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      Padels: Padels == freezed
          ? _value._Padels
          : Padels // ignore: cast_nullable_to_non_nullable
              as List<PadelModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PadelGroupModel implements _PadelGroupModel {
  _$_PadelGroupModel(
      {this.id = -1,
      this.name = '',
      this.icon = '',
      this.color,
      this.sequence = 1,
      this.enabled = true,
      this.createdAt,
      this.updatedAt,
      final List<PadelModel>? Padels})
      : _Padels = Padels;

  factory _$_PadelGroupModel.fromJson(Map<String, dynamic> json) =>
      _$$_PadelGroupModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String icon;
  @override
  final String? color;
  @override
  @JsonKey()
  final int sequence;
  @override
  @JsonKey()
  final bool enabled;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<PadelModel>? _Padels;
  @override
  List<PadelModel>? get Padels {
    final value = _Padels;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PadelGroupModel(id: $id, name: $name, icon: $icon, color: $color, sequence: $sequence, enabled: $enabled, createdAt: $createdAt, updatedAt: $updatedAt, Padels: $Padels)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PadelGroupModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.sequence, sequence) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other._Padels, _Padels));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(sequence),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(_Padels));

  @JsonKey(ignore: true)
  @override
  _$$_PadelGroupModelCopyWith<_$_PadelGroupModel> get copyWith =>
      __$$_PadelGroupModelCopyWithImpl<_$_PadelGroupModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PadelGroupModelToJson(
      this,
    );
  }
}

abstract class _PadelGroupModel implements PadelGroupModel {
  factory _PadelGroupModel(
      {final int id,
      final String name,
      final String icon,
      final String? color,
      final int sequence,
      final bool enabled,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final List<PadelModel>? Padels}) = _$_PadelGroupModel;

  factory _PadelGroupModel.fromJson(Map<String, dynamic> json) =
      _$_PadelGroupModel.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  String? get color;
  @override
  int get sequence;
  @override
  bool get enabled;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<PadelModel>? get Padels;
  @override
  @JsonKey(ignore: true)
  _$$_PadelGroupModelCopyWith<_$_PadelGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}
