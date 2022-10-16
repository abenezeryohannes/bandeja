// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'padel.price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PadelPriceModel _$PadelPriceModelFromJson(Map<String, dynamic> json) {
  return _PadelPriceModel.fromJson(json);
}

/// @nodoc
mixin _$PadelPriceModel {
  dynamic get id => throw _privateConstructorUsedError;
  int get padelId => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PadelPriceModelCopyWith<PadelPriceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadelPriceModelCopyWith<$Res> {
  factory $PadelPriceModelCopyWith(
          PadelPriceModel value, $Res Function(PadelPriceModel) then) =
      _$PadelPriceModelCopyWithImpl<$Res>;
  $Res call(
      {dynamic id,
      int padelId,
      double price,
      DateTime startTime,
      DateTime endTime,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PadelPriceModelCopyWithImpl<$Res>
    implements $PadelPriceModelCopyWith<$Res> {
  _$PadelPriceModelCopyWithImpl(this._value, this._then);

  final PadelPriceModel _value;
  // ignore: unused_field
  final $Res Function(PadelPriceModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? padelId = freezed,
    Object? price = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
abstract class _$$_PadelPriceModelCopyWith<$Res>
    implements $PadelPriceModelCopyWith<$Res> {
  factory _$$_PadelPriceModelCopyWith(
          _$_PadelPriceModel value, $Res Function(_$_PadelPriceModel) then) =
      __$$_PadelPriceModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic id,
      int padelId,
      double price,
      DateTime startTime,
      DateTime endTime,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_PadelPriceModelCopyWithImpl<$Res>
    extends _$PadelPriceModelCopyWithImpl<$Res>
    implements _$$_PadelPriceModelCopyWith<$Res> {
  __$$_PadelPriceModelCopyWithImpl(
      _$_PadelPriceModel _value, $Res Function(_$_PadelPriceModel) _then)
      : super(_value, (v) => _then(v as _$_PadelPriceModel));

  @override
  _$_PadelPriceModel get _value => super._value as _$_PadelPriceModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? padelId = freezed,
    Object? price = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_PadelPriceModel(
      id: id == freezed ? _value.id : id,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
class _$_PadelPriceModel implements _PadelPriceModel {
  _$_PadelPriceModel(
      {this.id = -1,
      required this.padelId,
      this.price = 0,
      required this.startTime,
      required this.endTime,
      this.createdAt,
      this.updatedAt});

  factory _$_PadelPriceModel.fromJson(Map<String, dynamic> json) =>
      _$$_PadelPriceModelFromJson(json);

  @override
  @JsonKey()
  final dynamic id;
  @override
  final int padelId;
  @override
  @JsonKey()
  final double price;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PadelPriceModel(id: $id, padelId: $padelId, price: $price, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PadelPriceModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.padelId, padelId) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.startTime, startTime) &&
            const DeepCollectionEquality().equals(other.endTime, endTime) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(padelId),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(startTime),
      const DeepCollectionEquality().hash(endTime),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_PadelPriceModelCopyWith<_$_PadelPriceModel> get copyWith =>
      __$$_PadelPriceModelCopyWithImpl<_$_PadelPriceModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PadelPriceModelToJson(
      this,
    );
  }
}

abstract class _PadelPriceModel implements PadelPriceModel {
  factory _PadelPriceModel(
      {final dynamic id,
      required final int padelId,
      final double price,
      required final DateTime startTime,
      required final DateTime endTime,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_PadelPriceModel;

  factory _PadelPriceModel.fromJson(Map<String, dynamic> json) =
      _$_PadelPriceModel.fromJson;

  @override
  dynamic get id;
  @override
  int get padelId;
  @override
  double get price;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PadelPriceModelCopyWith<_$_PadelPriceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
