// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ad.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AdModel _$AdModelFromJson(Map<String, dynamic> json) {
  return _AdModel.fromJson(json);
}

/// @nodoc
mixin _$AdModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get banner => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  UserModel? get User => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdModelCopyWith<AdModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdModelCopyWith<$Res> {
  factory $AdModelCopyWith(AdModel value, $Res Function(AdModel) then) =
      _$AdModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int userId,
      String banner,
      String link,
      DateTime? createdAt,
      DateTime? updatedAt,
      UserModel? User});

  $UserModelCopyWith<$Res>? get User;
}

/// @nodoc
class _$AdModelCopyWithImpl<$Res> implements $AdModelCopyWith<$Res> {
  _$AdModelCopyWithImpl(this._value, this._then);

  final AdModel _value;
  // ignore: unused_field
  final $Res Function(AdModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? banner = freezed,
    Object? link = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? User = freezed,
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
      banner: banner == freezed
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      link: link == freezed
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      User: User == freezed
          ? _value.User
          : User // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }

  @override
  $UserModelCopyWith<$Res>? get User {
    if (_value.User == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.User!, (value) {
      return _then(_value.copyWith(User: value));
    });
  }
}

/// @nodoc
abstract class _$$_AdModelCopyWith<$Res> implements $AdModelCopyWith<$Res> {
  factory _$$_AdModelCopyWith(
          _$_AdModel value, $Res Function(_$_AdModel) then) =
      __$$_AdModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int userId,
      String banner,
      String link,
      DateTime? createdAt,
      DateTime? updatedAt,
      UserModel? User});

  @override
  $UserModelCopyWith<$Res>? get User;
}

/// @nodoc
class __$$_AdModelCopyWithImpl<$Res> extends _$AdModelCopyWithImpl<$Res>
    implements _$$_AdModelCopyWith<$Res> {
  __$$_AdModelCopyWithImpl(_$_AdModel _value, $Res Function(_$_AdModel) _then)
      : super(_value, (v) => _then(v as _$_AdModel));

  @override
  _$_AdModel get _value => super._value as _$_AdModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? banner = freezed,
    Object? link = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? User = freezed,
  }) {
    return _then(_$_AdModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      banner: banner == freezed
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      link: link == freezed
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      User: User == freezed
          ? _value.User
          : User // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AdModel implements _AdModel {
  _$_AdModel(
      {this.id = -1,
      this.userId = -1,
      required this.banner,
      this.link = '',
      this.createdAt,
      this.updatedAt,
      this.User});

  factory _$_AdModel.fromJson(Map<String, dynamic> json) =>
      _$$_AdModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int userId;
  @override
  final String banner;
  @override
  @JsonKey()
  final String link;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final UserModel? User;

  @override
  String toString() {
    return 'AdModel(id: $id, userId: $userId, banner: $banner, link: $link, createdAt: $createdAt, updatedAt: $updatedAt, User: $User)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.banner, banner) &&
            const DeepCollectionEquality().equals(other.link, link) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.User, User));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(banner),
      const DeepCollectionEquality().hash(link),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(User));

  @JsonKey(ignore: true)
  @override
  _$$_AdModelCopyWith<_$_AdModel> get copyWith =>
      __$$_AdModelCopyWithImpl<_$_AdModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AdModelToJson(
      this,
    );
  }
}

abstract class _AdModel implements AdModel {
  factory _AdModel(
      {final int id,
      final int userId,
      required final String banner,
      final String link,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final UserModel? User}) = _$_AdModel;

  factory _AdModel.fromJson(Map<String, dynamic> json) = _$_AdModel.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get banner;
  @override
  String get link;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  UserModel? get User;
  @override
  @JsonKey(ignore: true)
  _$$_AdModelCopyWith<_$_AdModel> get copyWith =>
      throw _privateConstructorUsedError;
}
