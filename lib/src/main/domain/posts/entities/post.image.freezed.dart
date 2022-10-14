// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'post.image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostImageModel _$PostImageModelFromJson(Map<String, dynamic> json) {
  return _PostImageModel.fromJson(json);
}

/// @nodoc
mixin _$PostImageModel {
  int get id => throw _privateConstructorUsedError;
  int get postId => throw _privateConstructorUsedError;
  String get img => throw _privateConstructorUsedError;
  PostModel? get Post => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostImageModelCopyWith<PostImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostImageModelCopyWith<$Res> {
  factory $PostImageModelCopyWith(
          PostImageModel value, $Res Function(PostImageModel) then) =
      _$PostImageModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int postId,
      String img,
      PostModel? Post,
      DateTime? createdAt,
      DateTime? updatedAt});

  $PostModelCopyWith<$Res>? get Post;
}

/// @nodoc
class _$PostImageModelCopyWithImpl<$Res>
    implements $PostImageModelCopyWith<$Res> {
  _$PostImageModelCopyWithImpl(this._value, this._then);

  final PostImageModel _value;
  // ignore: unused_field
  final $Res Function(PostImageModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? postId = freezed,
    Object? img = freezed,
    Object? Post = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      postId: postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      img: img == freezed
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String,
      Post: Post == freezed
          ? _value.Post
          : Post // ignore: cast_nullable_to_non_nullable
              as PostModel?,
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

  @override
  $PostModelCopyWith<$Res>? get Post {
    if (_value.Post == null) {
      return null;
    }

    return $PostModelCopyWith<$Res>(_value.Post!, (value) {
      return _then(_value.copyWith(Post: value));
    });
  }
}

/// @nodoc
abstract class _$$_PostImageModelCopyWith<$Res>
    implements $PostImageModelCopyWith<$Res> {
  factory _$$_PostImageModelCopyWith(
          _$_PostImageModel value, $Res Function(_$_PostImageModel) then) =
      __$$_PostImageModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int postId,
      String img,
      PostModel? Post,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $PostModelCopyWith<$Res>? get Post;
}

/// @nodoc
class __$$_PostImageModelCopyWithImpl<$Res>
    extends _$PostImageModelCopyWithImpl<$Res>
    implements _$$_PostImageModelCopyWith<$Res> {
  __$$_PostImageModelCopyWithImpl(
      _$_PostImageModel _value, $Res Function(_$_PostImageModel) _then)
      : super(_value, (v) => _then(v as _$_PostImageModel));

  @override
  _$_PostImageModel get _value => super._value as _$_PostImageModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? postId = freezed,
    Object? img = freezed,
    Object? Post = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_PostImageModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      postId: postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      img: img == freezed
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String,
      Post: Post == freezed
          ? _value.Post
          : Post // ignore: cast_nullable_to_non_nullable
              as PostModel?,
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
class _$_PostImageModel
    with DiagnosticableTreeMixin
    implements _PostImageModel {
  _$_PostImageModel(
      {this.id = -1,
      required this.postId,
      required this.img,
      this.Post,
      this.createdAt,
      this.updatedAt});

  factory _$_PostImageModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostImageModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int postId;
  @override
  final String img;
  @override
  final PostModel? Post;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostImageModel(id: $id, postId: $postId, img: $img, Post: $Post, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostImageModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('postId', postId))
      ..add(DiagnosticsProperty('img', img))
      ..add(DiagnosticsProperty('Post', Post))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostImageModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.postId, postId) &&
            const DeepCollectionEquality().equals(other.img, img) &&
            const DeepCollectionEquality().equals(other.Post, Post) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(postId),
      const DeepCollectionEquality().hash(img),
      const DeepCollectionEquality().hash(Post),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_PostImageModelCopyWith<_$_PostImageModel> get copyWith =>
      __$$_PostImageModelCopyWithImpl<_$_PostImageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostImageModelToJson(
      this,
    );
  }
}

abstract class _PostImageModel implements PostImageModel {
  factory _PostImageModel(
      {final int id,
      required final int postId,
      required final String img,
      final PostModel? Post,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_PostImageModel;

  factory _PostImageModel.fromJson(Map<String, dynamic> json) =
      _$_PostImageModel.fromJson;

  @override
  int get id;
  @override
  int get postId;
  @override
  String get img;
  @override
  PostModel? get Post;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PostImageModelCopyWith<_$_PostImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
