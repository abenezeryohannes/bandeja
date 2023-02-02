// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'system.variable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SystemVariableModel _$SystemVariableModelFromJson(Map<String, dynamic> json) {
  return _SystemVariableModel.fromJson(json);
}

/// @nodoc
mixin _$SystemVariableModel {
  int get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SystemVariableModelCopyWith<SystemVariableModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemVariableModelCopyWith<$Res> {
  factory $SystemVariableModelCopyWith(
          SystemVariableModel value, $Res Function(SystemVariableModel) then) =
      _$SystemVariableModelCopyWithImpl<$Res>;
  $Res call({int id, String key, String? value});
}

/// @nodoc
class _$SystemVariableModelCopyWithImpl<$Res>
    implements $SystemVariableModelCopyWith<$Res> {
  _$SystemVariableModelCopyWithImpl(this._value, this._then);

  final SystemVariableModel _value;
  // ignore: unused_field
  final $Res Function(SystemVariableModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? key = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_SystemVariableModelCopyWith<$Res>
    implements $SystemVariableModelCopyWith<$Res> {
  factory _$$_SystemVariableModelCopyWith(_$_SystemVariableModel value,
          $Res Function(_$_SystemVariableModel) then) =
      __$$_SystemVariableModelCopyWithImpl<$Res>;
  @override
  $Res call({int id, String key, String? value});
}

/// @nodoc
class __$$_SystemVariableModelCopyWithImpl<$Res>
    extends _$SystemVariableModelCopyWithImpl<$Res>
    implements _$$_SystemVariableModelCopyWith<$Res> {
  __$$_SystemVariableModelCopyWithImpl(_$_SystemVariableModel _value,
      $Res Function(_$_SystemVariableModel) _then)
      : super(_value, (v) => _then(v as _$_SystemVariableModel));

  @override
  _$_SystemVariableModel get _value => super._value as _$_SystemVariableModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? key = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_SystemVariableModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SystemVariableModel implements _SystemVariableModel {
  _$_SystemVariableModel({this.id = -1, this.key = '', this.value});

  factory _$_SystemVariableModel.fromJson(Map<String, dynamic> json) =>
      _$$_SystemVariableModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String key;
  @override
  final String? value;

  @override
  String toString() {
    return 'SystemVariableModel(id: $id, key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SystemVariableModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_SystemVariableModelCopyWith<_$_SystemVariableModel> get copyWith =>
      __$$_SystemVariableModelCopyWithImpl<_$_SystemVariableModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SystemVariableModelToJson(
      this,
    );
  }
}

abstract class _SystemVariableModel implements SystemVariableModel {
  factory _SystemVariableModel(
      {final int id,
      final String key,
      final String? value}) = _$_SystemVariableModel;

  factory _SystemVariableModel.fromJson(Map<String, dynamic> json) =
      _$_SystemVariableModel.fromJson;

  @override
  int get id;
  @override
  String get key;
  @override
  String? get value;
  @override
  @JsonKey(ignore: true)
  _$$_SystemVariableModelCopyWith<_$_SystemVariableModel> get copyWith =>
      throw _privateConstructorUsedError;
}
