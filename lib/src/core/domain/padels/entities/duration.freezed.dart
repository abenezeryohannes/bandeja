// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'duration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DurationModel _$DurationModelFromJson(Map<String, dynamic> json) {
  return _DurationModel.fromJson(json);
}

/// @nodoc
mixin _$DurationModel {
  int get id => throw _privateConstructorUsedError;
  int get minute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DurationModelCopyWith<DurationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DurationModelCopyWith<$Res> {
  factory $DurationModelCopyWith(
          DurationModel value, $Res Function(DurationModel) then) =
      _$DurationModelCopyWithImpl<$Res>;
  $Res call({int id, int minute});
}

/// @nodoc
class _$DurationModelCopyWithImpl<$Res>
    implements $DurationModelCopyWith<$Res> {
  _$DurationModelCopyWithImpl(this._value, this._then);

  final DurationModel _value;
  // ignore: unused_field
  final $Res Function(DurationModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? minute = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      minute: minute == freezed
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_DurationModelCopyWith<$Res>
    implements $DurationModelCopyWith<$Res> {
  factory _$$_DurationModelCopyWith(
          _$_DurationModel value, $Res Function(_$_DurationModel) then) =
      __$$_DurationModelCopyWithImpl<$Res>;
  @override
  $Res call({int id, int minute});
}

/// @nodoc
class __$$_DurationModelCopyWithImpl<$Res>
    extends _$DurationModelCopyWithImpl<$Res>
    implements _$$_DurationModelCopyWith<$Res> {
  __$$_DurationModelCopyWithImpl(
      _$_DurationModel _value, $Res Function(_$_DurationModel) _then)
      : super(_value, (v) => _then(v as _$_DurationModel));

  @override
  _$_DurationModel get _value => super._value as _$_DurationModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? minute = freezed,
  }) {
    return _then(_$_DurationModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      minute: minute == freezed
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DurationModel implements _DurationModel {
  _$_DurationModel({this.id = -1, this.minute = 0});

  factory _$_DurationModel.fromJson(Map<String, dynamic> json) =>
      _$$_DurationModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int minute;

  @override
  String toString() {
    return 'DurationModel(id: $id, minute: $minute)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DurationModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.minute, minute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(minute));

  @JsonKey(ignore: true)
  @override
  _$$_DurationModelCopyWith<_$_DurationModel> get copyWith =>
      __$$_DurationModelCopyWithImpl<_$_DurationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DurationModelToJson(
      this,
    );
  }
}

abstract class _DurationModel implements DurationModel {
  factory _DurationModel({final int id, final int minute}) = _$_DurationModel;

  factory _DurationModel.fromJson(Map<String, dynamic> json) =
      _$_DurationModel.fromJson;

  @override
  int get id;
  @override
  int get minute;
  @override
  @JsonKey(ignore: true)
  _$$_DurationModelCopyWith<_$_DurationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
