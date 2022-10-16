// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'post.group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostGroupModel _$PostGroupModelFromJson(Map<String, dynamic> json) {
  return _PostGroupModel.fromJson(json);
}

/// @nodoc
mixin _$PostGroupModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostGroupModelCopyWith<PostGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostGroupModelCopyWith<$Res> {
  factory $PostGroupModelCopyWith(
          PostGroupModel value, $Res Function(PostGroupModel) then) =
      _$PostGroupModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      String? icon,
      String? color,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PostGroupModelCopyWithImpl<$Res>
    implements $PostGroupModelCopyWith<$Res> {
  _$PostGroupModelCopyWithImpl(this._value, this._then);

  final PostGroupModel _value;
  // ignore: unused_field
  final $Res Function(PostGroupModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
              as String?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ));
  }
}

/// @nodoc
abstract class _$$_PostGroupModelCopyWith<$Res>
    implements $PostGroupModelCopyWith<$Res> {
  factory _$$_PostGroupModelCopyWith(
          _$_PostGroupModel value, $Res Function(_$_PostGroupModel) then) =
      __$$_PostGroupModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      String? icon,
      String? color,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_PostGroupModelCopyWithImpl<$Res>
    extends _$PostGroupModelCopyWithImpl<$Res>
    implements _$$_PostGroupModelCopyWith<$Res> {
  __$$_PostGroupModelCopyWithImpl(
      _$_PostGroupModel _value, $Res Function(_$_PostGroupModel) _then)
      : super(_value, (v) => _then(v as _$_PostGroupModel));

  @override
  _$_PostGroupModel get _value => super._value as _$_PostGroupModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_PostGroupModel(
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
              as String?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostGroupModel
    with DiagnosticableTreeMixin
    implements _PostGroupModel {
  _$_PostGroupModel(
      {this.id = -1,
      this.name = '',
      this.icon,
      this.color,
      this.enabled = true,
      this.createdAt,
      this.updatedAt});

  factory _$_PostGroupModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostGroupModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? icon;
  @override
  final String? color;
  @override
  @JsonKey()
  final bool enabled;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostGroupModel(id: $id, name: $name, icon: $icon, color: $color, enabled: $enabled, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostGroupModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostGroupModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_PostGroupModelCopyWith<_$_PostGroupModel> get copyWith =>
      __$$_PostGroupModelCopyWithImpl<_$_PostGroupModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostGroupModelToJson(
      this,
    );
  }
}

abstract class _PostGroupModel implements PostGroupModel {
  factory _PostGroupModel(
      {final int id,
      final String name,
      final String? icon,
      final String? color,
      final bool enabled,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_PostGroupModel;

  factory _PostGroupModel.fromJson(Map<String, dynamic> json) =
      _$_PostGroupModel.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get icon;
  @override
  String? get color;
  @override
  bool get enabled;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PostGroupModelCopyWith<_$_PostGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}
