// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bookmark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookmarkModel _$BookmarkModelFromJson(Map<String, dynamic> json) {
  return _BookmarkModel.fromJson(json);
}

/// @nodoc
mixin _$BookmarkModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get padelId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookmarkModelCopyWith<BookmarkModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkModelCopyWith<$Res> {
  factory $BookmarkModelCopyWith(
          BookmarkModel value, $Res Function(BookmarkModel) then) =
      _$BookmarkModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int userId,
      int padelId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$BookmarkModelCopyWithImpl<$Res>
    implements $BookmarkModelCopyWith<$Res> {
  _$BookmarkModelCopyWithImpl(this._value, this._then);

  final BookmarkModel _value;
  // ignore: unused_field
  final $Res Function(BookmarkModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? padelId = freezed,
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
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$_BookmarkModelCopyWith<$Res>
    implements $BookmarkModelCopyWith<$Res> {
  factory _$$_BookmarkModelCopyWith(
          _$_BookmarkModel value, $Res Function(_$_BookmarkModel) then) =
      __$$_BookmarkModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int userId,
      int padelId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_BookmarkModelCopyWithImpl<$Res>
    extends _$BookmarkModelCopyWithImpl<$Res>
    implements _$$_BookmarkModelCopyWith<$Res> {
  __$$_BookmarkModelCopyWithImpl(
      _$_BookmarkModel _value, $Res Function(_$_BookmarkModel) _then)
      : super(_value, (v) => _then(v as _$_BookmarkModel));

  @override
  _$_BookmarkModel get _value => super._value as _$_BookmarkModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? padelId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_BookmarkModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$_BookmarkModel with DiagnosticableTreeMixin implements _BookmarkModel {
  _$_BookmarkModel(
      {this.id = -1,
      required this.userId,
      required this.padelId,
      this.createdAt,
      this.updatedAt});

  factory _$_BookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$$_BookmarkModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int userId;
  @override
  final int padelId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookmarkModel(id: $id, userId: $userId, padelId: $padelId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookmarkModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('padelId', padelId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookmarkModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.padelId, padelId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(padelId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_BookmarkModelCopyWith<_$_BookmarkModel> get copyWith =>
      __$$_BookmarkModelCopyWithImpl<_$_BookmarkModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookmarkModelToJson(
      this,
    );
  }
}

abstract class _BookmarkModel implements BookmarkModel {
  factory _BookmarkModel(
      {final int id,
      required final int userId,
      required final int padelId,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_BookmarkModel;

  factory _BookmarkModel.fromJson(Map<String, dynamic> json) =
      _$_BookmarkModel.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  int get padelId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_BookmarkModelCopyWith<_$_BookmarkModel> get copyWith =>
      throw _privateConstructorUsedError;
}
