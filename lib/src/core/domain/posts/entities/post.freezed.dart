// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  String? get whatsApp => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  bool get featured => throw _privateConstructorUsedError;
  int get postGroupId => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  bool get offer => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  PostGroupModel? get PostGroup => throw _privateConstructorUsedError;
  UserModel? get User => throw _privateConstructorUsedError;
  List<PostImageModel>? get PostImages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int userId,
      String title,
      String desc,
      String? whatsApp,
      String? phoneNumber,
      bool featured,
      int postGroupId,
      String price,
      bool offer,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt,
      PostGroupModel? PostGroup,
      UserModel? User,
      List<PostImageModel>? PostImages});

  $PostGroupModelCopyWith<$Res>? get PostGroup;
  $UserModelCopyWith<$Res>? get User;
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res> implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  final PostModel _value;
  // ignore: unused_field
  final $Res Function(PostModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? title = freezed,
    Object? desc = freezed,
    Object? whatsApp = freezed,
    Object? phoneNumber = freezed,
    Object? featured = freezed,
    Object? postGroupId = freezed,
    Object? price = freezed,
    Object? offer = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? PostGroup = freezed,
    Object? User = freezed,
    Object? PostImages = freezed,
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
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      whatsApp: whatsApp == freezed
          ? _value.whatsApp
          : whatsApp // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      featured: featured == freezed
          ? _value.featured
          : featured // ignore: cast_nullable_to_non_nullable
              as bool,
      postGroupId: postGroupId == freezed
          ? _value.postGroupId
          : postGroupId // ignore: cast_nullable_to_non_nullable
              as int,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      offer: offer == freezed
          ? _value.offer
          : offer // ignore: cast_nullable_to_non_nullable
              as bool,
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
      PostGroup: PostGroup == freezed
          ? _value.PostGroup
          : PostGroup // ignore: cast_nullable_to_non_nullable
              as PostGroupModel?,
      User: User == freezed
          ? _value.User
          : User // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      PostImages: PostImages == freezed
          ? _value.PostImages
          : PostImages // ignore: cast_nullable_to_non_nullable
              as List<PostImageModel>?,
    ));
  }

  @override
  $PostGroupModelCopyWith<$Res>? get PostGroup {
    if (_value.PostGroup == null) {
      return null;
    }

    return $PostGroupModelCopyWith<$Res>(_value.PostGroup!, (value) {
      return _then(_value.copyWith(PostGroup: value));
    });
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
abstract class _$$_PostModelCopyWith<$Res> implements $PostModelCopyWith<$Res> {
  factory _$$_PostModelCopyWith(
          _$_PostModel value, $Res Function(_$_PostModel) then) =
      __$$_PostModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int userId,
      String title,
      String desc,
      String? whatsApp,
      String? phoneNumber,
      bool featured,
      int postGroupId,
      String price,
      bool offer,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt,
      PostGroupModel? PostGroup,
      UserModel? User,
      List<PostImageModel>? PostImages});

  @override
  $PostGroupModelCopyWith<$Res>? get PostGroup;
  @override
  $UserModelCopyWith<$Res>? get User;
}

/// @nodoc
class __$$_PostModelCopyWithImpl<$Res> extends _$PostModelCopyWithImpl<$Res>
    implements _$$_PostModelCopyWith<$Res> {
  __$$_PostModelCopyWithImpl(
      _$_PostModel _value, $Res Function(_$_PostModel) _then)
      : super(_value, (v) => _then(v as _$_PostModel));

  @override
  _$_PostModel get _value => super._value as _$_PostModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? title = freezed,
    Object? desc = freezed,
    Object? whatsApp = freezed,
    Object? phoneNumber = freezed,
    Object? featured = freezed,
    Object? postGroupId = freezed,
    Object? price = freezed,
    Object? offer = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? PostGroup = freezed,
    Object? User = freezed,
    Object? PostImages = freezed,
  }) {
    return _then(_$_PostModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      whatsApp: whatsApp == freezed
          ? _value.whatsApp
          : whatsApp // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      featured: featured == freezed
          ? _value.featured
          : featured // ignore: cast_nullable_to_non_nullable
              as bool,
      postGroupId: postGroupId == freezed
          ? _value.postGroupId
          : postGroupId // ignore: cast_nullable_to_non_nullable
              as int,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      offer: offer == freezed
          ? _value.offer
          : offer // ignore: cast_nullable_to_non_nullable
              as bool,
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
      PostGroup: PostGroup == freezed
          ? _value.PostGroup
          : PostGroup // ignore: cast_nullable_to_non_nullable
              as PostGroupModel?,
      User: User == freezed
          ? _value.User
          : User // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      PostImages: PostImages == freezed
          ? _value._PostImages
          : PostImages // ignore: cast_nullable_to_non_nullable
              as List<PostImageModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostModel implements _PostModel {
  _$_PostModel(
      {this.id = -1,
      required this.userId,
      this.title = '',
      this.desc = '',
      this.whatsApp,
      this.phoneNumber,
      this.featured = false,
      required this.postGroupId,
      this.price = '0.0',
      this.offer = true,
      this.enabled = true,
      this.createdAt,
      this.updatedAt,
      this.PostGroup,
      this.User,
      final List<PostImageModel>? PostImages})
      : _PostImages = PostImages;

  factory _$_PostModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int userId;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String desc;
  @override
  final String? whatsApp;
  @override
  final String? phoneNumber;
  @override
  @JsonKey()
  final bool featured;
  @override
  final int postGroupId;
  @override
  @JsonKey()
  final String price;
  @override
  @JsonKey()
  final bool offer;
  @override
  @JsonKey()
  final bool enabled;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final PostGroupModel? PostGroup;
  @override
  final UserModel? User;
  final List<PostImageModel>? _PostImages;
  @override
  List<PostImageModel>? get PostImages {
    final value = _PostImages;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PostModel(id: $id, userId: $userId, title: $title, desc: $desc, whatsApp: $whatsApp, phoneNumber: $phoneNumber, featured: $featured, postGroupId: $postGroupId, price: $price, offer: $offer, enabled: $enabled, createdAt: $createdAt, updatedAt: $updatedAt, PostGroup: $PostGroup, User: $User, PostImages: $PostImages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.desc, desc) &&
            const DeepCollectionEquality().equals(other.whatsApp, whatsApp) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.featured, featured) &&
            const DeepCollectionEquality()
                .equals(other.postGroupId, postGroupId) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.offer, offer) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.PostGroup, PostGroup) &&
            const DeepCollectionEquality().equals(other.User, User) &&
            const DeepCollectionEquality()
                .equals(other._PostImages, _PostImages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(desc),
      const DeepCollectionEquality().hash(whatsApp),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(featured),
      const DeepCollectionEquality().hash(postGroupId),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(offer),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(PostGroup),
      const DeepCollectionEquality().hash(User),
      const DeepCollectionEquality().hash(_PostImages));

  @JsonKey(ignore: true)
  @override
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      __$$_PostModelCopyWithImpl<_$_PostModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostModelToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  factory _PostModel(
      {final int id,
      required final int userId,
      final String title,
      final String desc,
      final String? whatsApp,
      final String? phoneNumber,
      final bool featured,
      required final int postGroupId,
      final String price,
      final bool offer,
      final bool enabled,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final PostGroupModel? PostGroup,
      final UserModel? User,
      final List<PostImageModel>? PostImages}) = _$_PostModel;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$_PostModel.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get title;
  @override
  String get desc;
  @override
  String? get whatsApp;
  @override
  String? get phoneNumber;
  @override
  bool get featured;
  @override
  int get postGroupId;
  @override
  String get price;
  @override
  bool get offer;
  @override
  bool get enabled;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  PostGroupModel? get PostGroup;
  @override
  UserModel? get User;
  @override
  List<PostImageModel>? get PostImages;
  @override
  @JsonKey(ignore: true)
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}
