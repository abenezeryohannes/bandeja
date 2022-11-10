// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get UID => throw _privateConstructorUsedError;
  String? get emailAddress => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  int? get locationId => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<TokenModel>? get Tokens => throw _privateConstructorUsedError;
  TokenModel? get Token => throw _privateConstructorUsedError;
  SettingModel? get Setting => throw _privateConstructorUsedError;
  LocationModel? get Location => throw _privateConstructorUsedError;
  List<BookmarkModel>? get Bookmarks => throw _privateConstructorUsedError;
  List<PadelModel>? get Padels => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String fullName,
      String? avatar,
      String? UID,
      String? emailAddress,
      String? password,
      String role,
      int? locationId,
      String phoneNumber,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<TokenModel>? Tokens,
      TokenModel? Token,
      SettingModel? Setting,
      LocationModel? Location,
      List<BookmarkModel>? Bookmarks,
      List<PadelModel>? Padels});

  $TokenModelCopyWith<$Res>? get Token;
  $SettingModelCopyWith<$Res>? get Setting;
  $LocationModelCopyWith<$Res>? get Location;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  final UserModel _value;
  // ignore: unused_field
  final $Res Function(UserModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? avatar = freezed,
    Object? UID = freezed,
    Object? emailAddress = freezed,
    Object? password = freezed,
    Object? role = freezed,
    Object? locationId = freezed,
    Object? phoneNumber = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? Tokens = freezed,
    Object? Token = freezed,
    Object? Setting = freezed,
    Object? Location = freezed,
    Object? Bookmarks = freezed,
    Object? Padels = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      UID: UID == freezed
          ? _value.UID
          : UID // ignore: cast_nullable_to_non_nullable
              as String?,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: locationId == freezed
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as int?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
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
      Tokens: Tokens == freezed
          ? _value.Tokens
          : Tokens // ignore: cast_nullable_to_non_nullable
              as List<TokenModel>?,
      Token: Token == freezed
          ? _value.Token
          : Token // ignore: cast_nullable_to_non_nullable
              as TokenModel?,
      Setting: Setting == freezed
          ? _value.Setting
          : Setting // ignore: cast_nullable_to_non_nullable
              as SettingModel?,
      Location: Location == freezed
          ? _value.Location
          : Location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      Bookmarks: Bookmarks == freezed
          ? _value.Bookmarks
          : Bookmarks // ignore: cast_nullable_to_non_nullable
              as List<BookmarkModel>?,
      Padels: Padels == freezed
          ? _value.Padels
          : Padels // ignore: cast_nullable_to_non_nullable
              as List<PadelModel>?,
    ));
  }

  @override
  $TokenModelCopyWith<$Res>? get Token {
    if (_value.Token == null) {
      return null;
    }

    return $TokenModelCopyWith<$Res>(_value.Token!, (value) {
      return _then(_value.copyWith(Token: value));
    });
  }

  @override
  $SettingModelCopyWith<$Res>? get Setting {
    if (_value.Setting == null) {
      return null;
    }

    return $SettingModelCopyWith<$Res>(_value.Setting!, (value) {
      return _then(_value.copyWith(Setting: value));
    });
  }

  @override
  $LocationModelCopyWith<$Res>? get Location {
    if (_value.Location == null) {
      return null;
    }

    return $LocationModelCopyWith<$Res>(_value.Location!, (value) {
      return _then(_value.copyWith(Location: value));
    });
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String fullName,
      String? avatar,
      String? UID,
      String? emailAddress,
      String? password,
      String role,
      int? locationId,
      String phoneNumber,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<TokenModel>? Tokens,
      TokenModel? Token,
      SettingModel? Setting,
      LocationModel? Location,
      List<BookmarkModel>? Bookmarks,
      List<PadelModel>? Padels});

  @override
  $TokenModelCopyWith<$Res>? get Token;
  @override
  $SettingModelCopyWith<$Res>? get Setting;
  @override
  $LocationModelCopyWith<$Res>? get Location;
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, (v) => _then(v as _$_UserModel));

  @override
  _$_UserModel get _value => super._value as _$_UserModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? avatar = freezed,
    Object? UID = freezed,
    Object? emailAddress = freezed,
    Object? password = freezed,
    Object? role = freezed,
    Object? locationId = freezed,
    Object? phoneNumber = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? Tokens = freezed,
    Object? Token = freezed,
    Object? Setting = freezed,
    Object? Location = freezed,
    Object? Bookmarks = freezed,
    Object? Padels = freezed,
  }) {
    return _then(_$_UserModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      UID: UID == freezed
          ? _value.UID
          : UID // ignore: cast_nullable_to_non_nullable
              as String?,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: locationId == freezed
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as int?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
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
      Tokens: Tokens == freezed
          ? _value._Tokens
          : Tokens // ignore: cast_nullable_to_non_nullable
              as List<TokenModel>?,
      Token: Token == freezed
          ? _value.Token
          : Token // ignore: cast_nullable_to_non_nullable
              as TokenModel?,
      Setting: Setting == freezed
          ? _value.Setting
          : Setting // ignore: cast_nullable_to_non_nullable
              as SettingModel?,
      Location: Location == freezed
          ? _value.Location
          : Location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      Bookmarks: Bookmarks == freezed
          ? _value._Bookmarks
          : Bookmarks // ignore: cast_nullable_to_non_nullable
              as List<BookmarkModel>?,
      Padels: Padels == freezed
          ? _value._Padels
          : Padels // ignore: cast_nullable_to_non_nullable
              as List<PadelModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  _$_UserModel(
      {this.id = -1,
      this.fullName = '',
      this.avatar,
      this.UID,
      this.emailAddress,
      this.password,
      this.role = "user",
      this.locationId,
      this.phoneNumber = "",
      this.enabled = true,
      this.createdAt,
      this.updatedAt,
      final List<TokenModel>? Tokens,
      this.Token,
      this.Setting,
      this.Location,
      final List<BookmarkModel>? Bookmarks,
      final List<PadelModel>? Padels})
      : _Tokens = Tokens,
        _Bookmarks = Bookmarks,
        _Padels = Padels;

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String fullName;
  @override
  final String? avatar;
  @override
  final String? UID;
  @override
  final String? emailAddress;
  @override
  final String? password;
  @override
  @JsonKey()
  final String role;
  @override
  final int? locationId;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final bool enabled;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<TokenModel>? _Tokens;
  @override
  List<TokenModel>? get Tokens {
    final value = _Tokens;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final TokenModel? Token;
  @override
  final SettingModel? Setting;
  @override
  final LocationModel? Location;
  final List<BookmarkModel>? _Bookmarks;
  @override
  List<BookmarkModel>? get Bookmarks {
    final value = _Bookmarks;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
    return 'UserModel(id: $id, fullName: $fullName, avatar: $avatar, UID: $UID, emailAddress: $emailAddress, password: $password, role: $role, locationId: $locationId, phoneNumber: $phoneNumber, enabled: $enabled, createdAt: $createdAt, updatedAt: $updatedAt, Tokens: $Tokens, Token: $Token, Setting: $Setting, Location: $Location, Bookmarks: $Bookmarks, Padels: $Padels)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            const DeepCollectionEquality().equals(other.UID, UID) &&
            const DeepCollectionEquality()
                .equals(other.emailAddress, emailAddress) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.role, role) &&
            const DeepCollectionEquality()
                .equals(other.locationId, locationId) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other._Tokens, _Tokens) &&
            const DeepCollectionEquality().equals(other.Token, Token) &&
            const DeepCollectionEquality().equals(other.Setting, Setting) &&
            const DeepCollectionEquality().equals(other.Location, Location) &&
            const DeepCollectionEquality()
                .equals(other._Bookmarks, _Bookmarks) &&
            const DeepCollectionEquality().equals(other._Padels, _Padels));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(avatar),
      const DeepCollectionEquality().hash(UID),
      const DeepCollectionEquality().hash(emailAddress),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(role),
      const DeepCollectionEquality().hash(locationId),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(_Tokens),
      const DeepCollectionEquality().hash(Token),
      const DeepCollectionEquality().hash(Setting),
      const DeepCollectionEquality().hash(Location),
      const DeepCollectionEquality().hash(_Bookmarks),
      const DeepCollectionEquality().hash(_Padels));

  @JsonKey(ignore: true)
  @override
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  factory _UserModel(
      {final int id,
      final String fullName,
      final String? avatar,
      final String? UID,
      final String? emailAddress,
      final String? password,
      final String role,
      final int? locationId,
      final String phoneNumber,
      final bool enabled,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final List<TokenModel>? Tokens,
      final TokenModel? Token,
      final SettingModel? Setting,
      final LocationModel? Location,
      final List<BookmarkModel>? Bookmarks,
      final List<PadelModel>? Padels}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  int get id;
  @override
  String get fullName;
  @override
  String? get avatar;
  @override
  String? get UID;
  @override
  String? get emailAddress;
  @override
  String? get password;
  @override
  String get role;
  @override
  int? get locationId;
  @override
  String get phoneNumber;
  @override
  bool get enabled;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<TokenModel>? get Tokens;
  @override
  TokenModel? get Token;
  @override
  SettingModel? get Setting;
  @override
  LocationModel? get Location;
  @override
  List<BookmarkModel>? get Bookmarks;
  @override
  List<PadelModel>? get Padels;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
