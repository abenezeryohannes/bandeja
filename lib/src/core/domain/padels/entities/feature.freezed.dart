// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'feature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeatureModel _$FeatureModelFromJson(Map<String, dynamic> json) {
  return _InstrumentModel.fromJson(json);
}

/// @nodoc
mixin _$FeatureModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  PadelFeatureModel? get PadelFeature => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeatureModelCopyWith<FeatureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureModelCopyWith<$Res> {
  factory $FeatureModelCopyWith(
          FeatureModel value, $Res Function(FeatureModel) then) =
      _$FeatureModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      String icon,
      DateTime? createdAt,
      DateTime? updatedAt,
      PadelFeatureModel? PadelFeature});

  $PadelFeatureModelCopyWith<$Res>? get PadelFeature;
}

/// @nodoc
class _$FeatureModelCopyWithImpl<$Res> implements $FeatureModelCopyWith<$Res> {
  _$FeatureModelCopyWithImpl(this._value, this._then);

  final FeatureModel _value;
  // ignore: unused_field
  final $Res Function(FeatureModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? PadelFeature = freezed,
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
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      PadelFeature: PadelFeature == freezed
          ? _value.PadelFeature
          : PadelFeature // ignore: cast_nullable_to_non_nullable
              as PadelFeatureModel?,
    ));
  }

  @override
  $PadelFeatureModelCopyWith<$Res>? get PadelFeature {
    if (_value.PadelFeature == null) {
      return null;
    }

    return $PadelFeatureModelCopyWith<$Res>(_value.PadelFeature!, (value) {
      return _then(_value.copyWith(PadelFeature: value));
    });
  }
}

/// @nodoc
abstract class _$$_InstrumentModelCopyWith<$Res>
    implements $FeatureModelCopyWith<$Res> {
  factory _$$_InstrumentModelCopyWith(
          _$_InstrumentModel value, $Res Function(_$_InstrumentModel) then) =
      __$$_InstrumentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      String icon,
      DateTime? createdAt,
      DateTime? updatedAt,
      PadelFeatureModel? PadelFeature});

  @override
  $PadelFeatureModelCopyWith<$Res>? get PadelFeature;
}

/// @nodoc
class __$$_InstrumentModelCopyWithImpl<$Res>
    extends _$FeatureModelCopyWithImpl<$Res>
    implements _$$_InstrumentModelCopyWith<$Res> {
  __$$_InstrumentModelCopyWithImpl(
      _$_InstrumentModel _value, $Res Function(_$_InstrumentModel) _then)
      : super(_value, (v) => _then(v as _$_InstrumentModel));

  @override
  _$_InstrumentModel get _value => super._value as _$_InstrumentModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? PadelFeature = freezed,
  }) {
    return _then(_$_InstrumentModel(
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
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      PadelFeature: PadelFeature == freezed
          ? _value.PadelFeature
          : PadelFeature // ignore: cast_nullable_to_non_nullable
              as PadelFeatureModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InstrumentModel implements _InstrumentModel {
  _$_InstrumentModel(
      {this.id = -1,
      this.name = "",
      this.icon = "",
      this.createdAt,
      this.updatedAt,
      this.PadelFeature});

  factory _$_InstrumentModel.fromJson(Map<String, dynamic> json) =>
      _$$_InstrumentModelFromJson(json);

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
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final PadelFeatureModel? PadelFeature;

  @override
  String toString() {
    return 'FeatureModel(id: $id, name: $name, icon: $icon, createdAt: $createdAt, updatedAt: $updatedAt, PadelFeature: $PadelFeature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InstrumentModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.PadelFeature, PadelFeature));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(PadelFeature));

  @JsonKey(ignore: true)
  @override
  _$$_InstrumentModelCopyWith<_$_InstrumentModel> get copyWith =>
      __$$_InstrumentModelCopyWithImpl<_$_InstrumentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InstrumentModelToJson(
      this,
    );
  }
}

abstract class _InstrumentModel implements FeatureModel {
  factory _InstrumentModel(
      {final int id,
      final String name,
      final String icon,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final PadelFeatureModel? PadelFeature}) = _$_InstrumentModel;

  factory _InstrumentModel.fromJson(Map<String, dynamic> json) =
      _$_InstrumentModel.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  PadelFeatureModel? get PadelFeature;
  @override
  @JsonKey(ignore: true)
  _$$_InstrumentModelCopyWith<_$_InstrumentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
