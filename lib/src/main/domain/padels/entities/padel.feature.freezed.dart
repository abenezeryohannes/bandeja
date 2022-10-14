// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'padel.feature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PadelFeatureModel _$PadelFeatureModelFromJson(Map<String, dynamic> json) {
  return _PadelFeatureModel.fromJson(json);
}

/// @nodoc
mixin _$PadelFeatureModel {
  int get id => throw _privateConstructorUsedError;
  int get padelId => throw _privateConstructorUsedError;
  int get featureId => throw _privateConstructorUsedError;
  bool get free => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PadelFeatureModelCopyWith<PadelFeatureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadelFeatureModelCopyWith<$Res> {
  factory $PadelFeatureModelCopyWith(
          PadelFeatureModel value, $Res Function(PadelFeatureModel) then) =
      _$PadelFeatureModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int padelId,
      int featureId,
      bool free,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PadelFeatureModelCopyWithImpl<$Res>
    implements $PadelFeatureModelCopyWith<$Res> {
  _$PadelFeatureModelCopyWithImpl(this._value, this._then);

  final PadelFeatureModel _value;
  // ignore: unused_field
  final $Res Function(PadelFeatureModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? padelId = freezed,
    Object? featureId = freezed,
    Object? free = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
      featureId: featureId == freezed
          ? _value.featureId
          : featureId // ignore: cast_nullable_to_non_nullable
              as int,
      free: free == freezed
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_PadelFeatureModelCopyWith<$Res>
    implements $PadelFeatureModelCopyWith<$Res> {
  factory _$$_PadelFeatureModelCopyWith(_$_PadelFeatureModel value,
          $Res Function(_$_PadelFeatureModel) then) =
      __$$_PadelFeatureModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int padelId,
      int featureId,
      bool free,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_PadelFeatureModelCopyWithImpl<$Res>
    extends _$PadelFeatureModelCopyWithImpl<$Res>
    implements _$$_PadelFeatureModelCopyWith<$Res> {
  __$$_PadelFeatureModelCopyWithImpl(
      _$_PadelFeatureModel _value, $Res Function(_$_PadelFeatureModel) _then)
      : super(_value, (v) => _then(v as _$_PadelFeatureModel));

  @override
  _$_PadelFeatureModel get _value => super._value as _$_PadelFeatureModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? padelId = freezed,
    Object? featureId = freezed,
    Object? free = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_PadelFeatureModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
      featureId: featureId == freezed
          ? _value.featureId
          : featureId // ignore: cast_nullable_to_non_nullable
              as int,
      free: free == freezed
          ? _value.free
          : free // ignore: cast_nullable_to_non_nullable
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
class _$_PadelFeatureModel
    with DiagnosticableTreeMixin
    implements _PadelFeatureModel {
  _$_PadelFeatureModel(
      {this.id = -1,
      required this.padelId,
      required this.featureId,
      this.free = true,
      this.createdAt,
      this.updatedAt});

  factory _$_PadelFeatureModel.fromJson(Map<String, dynamic> json) =>
      _$$_PadelFeatureModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int padelId;
  @override
  final int featureId;
  @override
  @JsonKey()
  final bool free;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PadelFeatureModel(id: $id, padelId: $padelId, featureId: $featureId, free: $free, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PadelFeatureModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('padelId', padelId))
      ..add(DiagnosticsProperty('featureId', featureId))
      ..add(DiagnosticsProperty('free', free))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PadelFeatureModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.padelId, padelId) &&
            const DeepCollectionEquality().equals(other.featureId, featureId) &&
            const DeepCollectionEquality().equals(other.free, free) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(padelId),
      const DeepCollectionEquality().hash(featureId),
      const DeepCollectionEquality().hash(free),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_PadelFeatureModelCopyWith<_$_PadelFeatureModel> get copyWith =>
      __$$_PadelFeatureModelCopyWithImpl<_$_PadelFeatureModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PadelFeatureModelToJson(
      this,
    );
  }
}

abstract class _PadelFeatureModel implements PadelFeatureModel {
  factory _PadelFeatureModel(
      {final int id,
      required final int padelId,
      required final int featureId,
      final bool free,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_PadelFeatureModel;

  factory _PadelFeatureModel.fromJson(Map<String, dynamic> json) =
      _$_PadelFeatureModel.fromJson;

  @override
  int get id;
  @override
  int get padelId;
  @override
  int get featureId;
  @override
  bool get free;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PadelFeatureModelCopyWith<_$_PadelFeatureModel> get copyWith =>
      throw _privateConstructorUsedError;
}
