// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'promo.code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PromoCodeModel _$PromoCodeModelFromJson(Map<String, dynamic> json) {
  return _PromoCodeModel.fromJson(json);
}

/// @nodoc
mixin _$PromoCodeModel {
  int get id => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;
  int get padelId => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  int get maxBooking => throw _privateConstructorUsedError;
  int get leftForBooking => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromoCodeModelCopyWith<PromoCodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromoCodeModelCopyWith<$Res> {
  factory $PromoCodeModelCopyWith(
          PromoCodeModel value, $Res Function(PromoCodeModel) then) =
      _$PromoCodeModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int? userId,
      int padelId,
      String code,
      int maxBooking,
      int leftForBooking,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PromoCodeModelCopyWithImpl<$Res>
    implements $PromoCodeModelCopyWith<$Res> {
  _$PromoCodeModelCopyWithImpl(this._value, this._then);

  final PromoCodeModel _value;
  // ignore: unused_field
  final $Res Function(PromoCodeModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? padelId = freezed,
    Object? code = freezed,
    Object? maxBooking = freezed,
    Object? leftForBooking = freezed,
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
              as int?,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      maxBooking: maxBooking == freezed
          ? _value.maxBooking
          : maxBooking // ignore: cast_nullable_to_non_nullable
              as int,
      leftForBooking: leftForBooking == freezed
          ? _value.leftForBooking
          : leftForBooking // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_PromoCodeModelCopyWith<$Res>
    implements $PromoCodeModelCopyWith<$Res> {
  factory _$$_PromoCodeModelCopyWith(
          _$_PromoCodeModel value, $Res Function(_$_PromoCodeModel) then) =
      __$$_PromoCodeModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int? userId,
      int padelId,
      String code,
      int maxBooking,
      int leftForBooking,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_PromoCodeModelCopyWithImpl<$Res>
    extends _$PromoCodeModelCopyWithImpl<$Res>
    implements _$$_PromoCodeModelCopyWith<$Res> {
  __$$_PromoCodeModelCopyWithImpl(
      _$_PromoCodeModel _value, $Res Function(_$_PromoCodeModel) _then)
      : super(_value, (v) => _then(v as _$_PromoCodeModel));

  @override
  _$_PromoCodeModel get _value => super._value as _$_PromoCodeModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? padelId = freezed,
    Object? code = freezed,
    Object? maxBooking = freezed,
    Object? leftForBooking = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_PromoCodeModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      maxBooking: maxBooking == freezed
          ? _value.maxBooking
          : maxBooking // ignore: cast_nullable_to_non_nullable
              as int,
      leftForBooking: leftForBooking == freezed
          ? _value.leftForBooking
          : leftForBooking // ignore: cast_nullable_to_non_nullable
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
class _$_PromoCodeModel implements _PromoCodeModel {
  _$_PromoCodeModel(
      {this.id = -1,
      required this.userId,
      required this.padelId,
      this.code = '',
      this.maxBooking = 0,
      this.leftForBooking = 0,
      this.createdAt,
      this.updatedAt});

  factory _$_PromoCodeModel.fromJson(Map<String, dynamic> json) =>
      _$$_PromoCodeModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int? userId;
  @override
  final int padelId;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final int maxBooking;
  @override
  @JsonKey()
  final int leftForBooking;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PromoCodeModel(id: $id, userId: $userId, padelId: $padelId, code: $code, maxBooking: $maxBooking, leftForBooking: $leftForBooking, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PromoCodeModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.padelId, padelId) &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality()
                .equals(other.maxBooking, maxBooking) &&
            const DeepCollectionEquality()
                .equals(other.leftForBooking, leftForBooking) &&
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
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(maxBooking),
      const DeepCollectionEquality().hash(leftForBooking),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_PromoCodeModelCopyWith<_$_PromoCodeModel> get copyWith =>
      __$$_PromoCodeModelCopyWithImpl<_$_PromoCodeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PromoCodeModelToJson(
      this,
    );
  }
}

abstract class _PromoCodeModel implements PromoCodeModel {
  factory _PromoCodeModel(
      {final int id,
      required final int? userId,
      required final int padelId,
      final String code,
      final int maxBooking,
      final int leftForBooking,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_PromoCodeModel;

  factory _PromoCodeModel.fromJson(Map<String, dynamic> json) =
      _$_PromoCodeModel.fromJson;

  @override
  int get id;
  @override
  int? get userId;
  @override
  int get padelId;
  @override
  String get code;
  @override
  int get maxBooking;
  @override
  int get leftForBooking;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PromoCodeModelCopyWith<_$_PromoCodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
