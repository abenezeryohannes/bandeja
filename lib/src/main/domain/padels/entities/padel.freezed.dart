// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'padel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PadelModel _$PadelModelFromJson(Map<String, dynamic> json) {
  return _Padel.fromJson(json);
}

/// @nodoc
mixin _$PadelModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get durationId => throw _privateConstructorUsedError;
  int get padelGroupId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get banner => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  int? get locationId => throw _privateConstructorUsedError;
  int? get addressId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  bool get indoor => throw _privateConstructorUsedError;
  bool get onlyLadies => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  PadelGroupModel? get PadelGroup => throw _privateConstructorUsedError;
  List<FeatureModel>? get Features => throw _privateConstructorUsedError;
  LocationModel? get Location => throw _privateConstructorUsedError;
  DurationModel? get Duration => throw _privateConstructorUsedError;
  AddressModel? get Address => throw _privateConstructorUsedError;
  UserModel? get User => throw _privateConstructorUsedError;
  List<PadelScheduleModel>? get PadelSchedules =>
      throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PadelModelCopyWith<PadelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadelModelCopyWith<$Res> {
  factory $PadelModelCopyWith(
          PadelModel value, $Res Function(PadelModel) then) =
      _$PadelModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int userId,
      int durationId,
      int padelGroupId,
      String name,
      String banner,
      String avatar,
      int? locationId,
      int? addressId,
      DateTime startTime,
      DateTime endTime,
      String price,
      bool indoor,
      bool onlyLadies,
      bool enabled,
      PadelGroupModel? PadelGroup,
      List<FeatureModel>? Features,
      LocationModel? Location,
      DurationModel? Duration,
      AddressModel? Address,
      UserModel? User,
      List<PadelScheduleModel>? PadelSchedules,
      DateTime? createdAt,
      DateTime? updatedAt});

  $PadelGroupModelCopyWith<$Res>? get PadelGroup;
  $LocationModelCopyWith<$Res>? get Location;
  $DurationModelCopyWith<$Res>? get Duration;
  $AddressModelCopyWith<$Res>? get Address;
  $UserModelCopyWith<$Res>? get User;
}

/// @nodoc
class _$PadelModelCopyWithImpl<$Res> implements $PadelModelCopyWith<$Res> {
  _$PadelModelCopyWithImpl(this._value, this._then);

  final PadelModel _value;
  // ignore: unused_field
  final $Res Function(PadelModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? durationId = freezed,
    Object? padelGroupId = freezed,
    Object? name = freezed,
    Object? banner = freezed,
    Object? avatar = freezed,
    Object? locationId = freezed,
    Object? addressId = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? price = freezed,
    Object? indoor = freezed,
    Object? onlyLadies = freezed,
    Object? enabled = freezed,
    Object? PadelGroup = freezed,
    Object? Features = freezed,
    Object? Location = freezed,
    Object? Duration = freezed,
    Object? Address = freezed,
    Object? User = freezed,
    Object? PadelSchedules = freezed,
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
      durationId: durationId == freezed
          ? _value.durationId
          : durationId // ignore: cast_nullable_to_non_nullable
              as int,
      padelGroupId: padelGroupId == freezed
          ? _value.padelGroupId
          : padelGroupId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      banner: banner == freezed
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: locationId == freezed
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as int?,
      addressId: addressId == freezed
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      indoor: indoor == freezed
          ? _value.indoor
          : indoor // ignore: cast_nullable_to_non_nullable
              as bool,
      onlyLadies: onlyLadies == freezed
          ? _value.onlyLadies
          : onlyLadies // ignore: cast_nullable_to_non_nullable
              as bool,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      PadelGroup: PadelGroup == freezed
          ? _value.PadelGroup
          : PadelGroup // ignore: cast_nullable_to_non_nullable
              as PadelGroupModel?,
      Features: Features == freezed
          ? _value.Features
          : Features // ignore: cast_nullable_to_non_nullable
              as List<FeatureModel>?,
      Location: Location == freezed
          ? _value.Location
          : Location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      Duration: Duration == freezed
          ? _value.Duration
          : Duration // ignore: cast_nullable_to_non_nullable
              as DurationModel?,
      Address: Address == freezed
          ? _value.Address
          : Address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      User: User == freezed
          ? _value.User
          : User // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      PadelSchedules: PadelSchedules == freezed
          ? _value.PadelSchedules
          : PadelSchedules // ignore: cast_nullable_to_non_nullable
              as List<PadelScheduleModel>?,
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
  $PadelGroupModelCopyWith<$Res>? get PadelGroup {
    if (_value.PadelGroup == null) {
      return null;
    }

    return $PadelGroupModelCopyWith<$Res>(_value.PadelGroup!, (value) {
      return _then(_value.copyWith(PadelGroup: value));
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

  @override
  $DurationModelCopyWith<$Res>? get Duration {
    if (_value.Duration == null) {
      return null;
    }

    return $DurationModelCopyWith<$Res>(_value.Duration!, (value) {
      return _then(_value.copyWith(Duration: value));
    });
  }

  @override
  $AddressModelCopyWith<$Res>? get Address {
    if (_value.Address == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.Address!, (value) {
      return _then(_value.copyWith(Address: value));
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
abstract class _$$_PadelCopyWith<$Res> implements $PadelModelCopyWith<$Res> {
  factory _$$_PadelCopyWith(_$_Padel value, $Res Function(_$_Padel) then) =
      __$$_PadelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int userId,
      int durationId,
      int padelGroupId,
      String name,
      String banner,
      String avatar,
      int? locationId,
      int? addressId,
      DateTime startTime,
      DateTime endTime,
      String price,
      bool indoor,
      bool onlyLadies,
      bool enabled,
      PadelGroupModel? PadelGroup,
      List<FeatureModel>? Features,
      LocationModel? Location,
      DurationModel? Duration,
      AddressModel? Address,
      UserModel? User,
      List<PadelScheduleModel>? PadelSchedules,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $PadelGroupModelCopyWith<$Res>? get PadelGroup;
  @override
  $LocationModelCopyWith<$Res>? get Location;
  @override
  $DurationModelCopyWith<$Res>? get Duration;
  @override
  $AddressModelCopyWith<$Res>? get Address;
  @override
  $UserModelCopyWith<$Res>? get User;
}

/// @nodoc
class __$$_PadelCopyWithImpl<$Res> extends _$PadelModelCopyWithImpl<$Res>
    implements _$$_PadelCopyWith<$Res> {
  __$$_PadelCopyWithImpl(_$_Padel _value, $Res Function(_$_Padel) _then)
      : super(_value, (v) => _then(v as _$_Padel));

  @override
  _$_Padel get _value => super._value as _$_Padel;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? durationId = freezed,
    Object? padelGroupId = freezed,
    Object? name = freezed,
    Object? banner = freezed,
    Object? avatar = freezed,
    Object? locationId = freezed,
    Object? addressId = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? price = freezed,
    Object? indoor = freezed,
    Object? onlyLadies = freezed,
    Object? enabled = freezed,
    Object? PadelGroup = freezed,
    Object? Features = freezed,
    Object? Location = freezed,
    Object? Duration = freezed,
    Object? Address = freezed,
    Object? User = freezed,
    Object? PadelSchedules = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Padel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      durationId: durationId == freezed
          ? _value.durationId
          : durationId // ignore: cast_nullable_to_non_nullable
              as int,
      padelGroupId: padelGroupId == freezed
          ? _value.padelGroupId
          : padelGroupId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      banner: banner == freezed
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: locationId == freezed
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as int?,
      addressId: addressId == freezed
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      indoor: indoor == freezed
          ? _value.indoor
          : indoor // ignore: cast_nullable_to_non_nullable
              as bool,
      onlyLadies: onlyLadies == freezed
          ? _value.onlyLadies
          : onlyLadies // ignore: cast_nullable_to_non_nullable
              as bool,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      PadelGroup: PadelGroup == freezed
          ? _value.PadelGroup
          : PadelGroup // ignore: cast_nullable_to_non_nullable
              as PadelGroupModel?,
      Features: Features == freezed
          ? _value._Features
          : Features // ignore: cast_nullable_to_non_nullable
              as List<FeatureModel>?,
      Location: Location == freezed
          ? _value.Location
          : Location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      Duration: Duration == freezed
          ? _value.Duration
          : Duration // ignore: cast_nullable_to_non_nullable
              as DurationModel?,
      Address: Address == freezed
          ? _value.Address
          : Address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      User: User == freezed
          ? _value.User
          : User // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      PadelSchedules: PadelSchedules == freezed
          ? _value._PadelSchedules
          : PadelSchedules // ignore: cast_nullable_to_non_nullable
              as List<PadelScheduleModel>?,
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
class _$_Padel with DiagnosticableTreeMixin implements _Padel {
  _$_Padel(
      {this.id = -1,
      required this.userId,
      required this.durationId,
      required this.padelGroupId,
      this.name = '',
      this.banner = 'placeholder.jpg',
      this.avatar = 'placeholder.jpg',
      this.locationId,
      this.addressId,
      required this.startTime,
      required this.endTime,
      this.price = '0.0',
      this.indoor = false,
      this.onlyLadies = false,
      this.enabled = true,
      this.PadelGroup,
      final List<FeatureModel>? Features,
      this.Location,
      this.Duration,
      this.Address,
      this.User,
      final List<PadelScheduleModel>? PadelSchedules,
      this.createdAt,
      this.updatedAt})
      : _Features = Features,
        _PadelSchedules = PadelSchedules;

  factory _$_Padel.fromJson(Map<String, dynamic> json) =>
      _$$_PadelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int userId;
  @override
  final int durationId;
  @override
  final int padelGroupId;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String banner;
  @override
  @JsonKey()
  final String avatar;
  @override
  final int? locationId;
  @override
  final int? addressId;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  @JsonKey()
  final String price;
  @override
  @JsonKey()
  final bool indoor;
  @override
  @JsonKey()
  final bool onlyLadies;
  @override
  @JsonKey()
  final bool enabled;
  @override
  final PadelGroupModel? PadelGroup;
  final List<FeatureModel>? _Features;
  @override
  List<FeatureModel>? get Features {
    final value = _Features;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final LocationModel? Location;
  @override
  final DurationModel? Duration;
  @override
  final AddressModel? Address;
  @override
  final UserModel? User;
  final List<PadelScheduleModel>? _PadelSchedules;
  @override
  List<PadelScheduleModel>? get PadelSchedules {
    final value = _PadelSchedules;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PadelModel(id: $id, userId: $userId, durationId: $durationId, padelGroupId: $padelGroupId, name: $name, banner: $banner, avatar: $avatar, locationId: $locationId, addressId: $addressId, startTime: $startTime, endTime: $endTime, price: $price, indoor: $indoor, onlyLadies: $onlyLadies, enabled: $enabled, PadelGroup: $PadelGroup, Features: $Features, Location: $Location, Duration: $Duration, Address: $Address, User: $User, PadelSchedules: $PadelSchedules, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PadelModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('durationId', durationId))
      ..add(DiagnosticsProperty('padelGroupId', padelGroupId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('banner', banner))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('locationId', locationId))
      ..add(DiagnosticsProperty('addressId', addressId))
      ..add(DiagnosticsProperty('startTime', startTime))
      ..add(DiagnosticsProperty('endTime', endTime))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('indoor', indoor))
      ..add(DiagnosticsProperty('onlyLadies', onlyLadies))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('PadelGroup', PadelGroup))
      ..add(DiagnosticsProperty('Features', Features))
      ..add(DiagnosticsProperty('Location', Location))
      ..add(DiagnosticsProperty('Duration', Duration))
      ..add(DiagnosticsProperty('Address', Address))
      ..add(DiagnosticsProperty('User', User))
      ..add(DiagnosticsProperty('PadelSchedules', PadelSchedules))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Padel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.durationId, durationId) &&
            const DeepCollectionEquality()
                .equals(other.padelGroupId, padelGroupId) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.banner, banner) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            const DeepCollectionEquality()
                .equals(other.locationId, locationId) &&
            const DeepCollectionEquality().equals(other.addressId, addressId) &&
            const DeepCollectionEquality().equals(other.startTime, startTime) &&
            const DeepCollectionEquality().equals(other.endTime, endTime) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.indoor, indoor) &&
            const DeepCollectionEquality()
                .equals(other.onlyLadies, onlyLadies) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality()
                .equals(other.PadelGroup, PadelGroup) &&
            const DeepCollectionEquality().equals(other._Features, _Features) &&
            const DeepCollectionEquality().equals(other.Location, Location) &&
            const DeepCollectionEquality().equals(other.Duration, Duration) &&
            const DeepCollectionEquality().equals(other.Address, Address) &&
            const DeepCollectionEquality().equals(other.User, User) &&
            const DeepCollectionEquality()
                .equals(other._PadelSchedules, _PadelSchedules) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(userId),
        const DeepCollectionEquality().hash(durationId),
        const DeepCollectionEquality().hash(padelGroupId),
        const DeepCollectionEquality().hash(name),
        const DeepCollectionEquality().hash(banner),
        const DeepCollectionEquality().hash(avatar),
        const DeepCollectionEquality().hash(locationId),
        const DeepCollectionEquality().hash(addressId),
        const DeepCollectionEquality().hash(startTime),
        const DeepCollectionEquality().hash(endTime),
        const DeepCollectionEquality().hash(price),
        const DeepCollectionEquality().hash(indoor),
        const DeepCollectionEquality().hash(onlyLadies),
        const DeepCollectionEquality().hash(enabled),
        const DeepCollectionEquality().hash(PadelGroup),
        const DeepCollectionEquality().hash(_Features),
        const DeepCollectionEquality().hash(Location),
        const DeepCollectionEquality().hash(Duration),
        const DeepCollectionEquality().hash(Address),
        const DeepCollectionEquality().hash(User),
        const DeepCollectionEquality().hash(_PadelSchedules),
        const DeepCollectionEquality().hash(createdAt),
        const DeepCollectionEquality().hash(updatedAt)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_PadelCopyWith<_$_Padel> get copyWith =>
      __$$_PadelCopyWithImpl<_$_Padel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PadelToJson(
      this,
    );
  }
}

abstract class _Padel implements PadelModel {
  factory _Padel(
      {final int id,
      required final int userId,
      required final int durationId,
      required final int padelGroupId,
      final String name,
      final String banner,
      final String avatar,
      final int? locationId,
      final int? addressId,
      required final DateTime startTime,
      required final DateTime endTime,
      final String price,
      final bool indoor,
      final bool onlyLadies,
      final bool enabled,
      final PadelGroupModel? PadelGroup,
      final List<FeatureModel>? Features,
      final LocationModel? Location,
      final DurationModel? Duration,
      final AddressModel? Address,
      final UserModel? User,
      final List<PadelScheduleModel>? PadelSchedules,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_Padel;

  factory _Padel.fromJson(Map<String, dynamic> json) = _$_Padel.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  int get durationId;
  @override
  int get padelGroupId;
  @override
  String get name;
  @override
  String get banner;
  @override
  String get avatar;
  @override
  int? get locationId;
  @override
  int? get addressId;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get price;
  @override
  bool get indoor;
  @override
  bool get onlyLadies;
  @override
  bool get enabled;
  @override
  PadelGroupModel? get PadelGroup;
  @override
  List<FeatureModel>? get Features;
  @override
  LocationModel? get Location;
  @override
  DurationModel? get Duration;
  @override
  AddressModel? get Address;
  @override
  UserModel? get User;
  @override
  List<PadelScheduleModel>? get PadelSchedules;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PadelCopyWith<_$_Padel> get copyWith =>
      throw _privateConstructorUsedError;
}
