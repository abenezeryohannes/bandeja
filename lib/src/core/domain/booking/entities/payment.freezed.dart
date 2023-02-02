// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) {
  return _PaymentModel.fromJson(json);
}

/// @nodoc
mixin _$PaymentModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String? get paymentId => throw _privateConstructorUsedError;
  String? get ref => throw _privateConstructorUsedError;
  String? get tranId => throw _privateConstructorUsedError;
  String? get trackId => throw _privateConstructorUsedError;
  String get paymentType => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentModelCopyWith<PaymentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentModelCopyWith<$Res> {
  factory $PaymentModelCopyWith(
          PaymentModel value, $Res Function(PaymentModel) then) =
      _$PaymentModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int userId,
      String? paymentId,
      String? ref,
      String? tranId,
      String? trackId,
      String paymentType,
      double amount,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PaymentModelCopyWithImpl<$Res> implements $PaymentModelCopyWith<$Res> {
  _$PaymentModelCopyWithImpl(this._value, this._then);

  final PaymentModel _value;
  // ignore: unused_field
  final $Res Function(PaymentModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? paymentId = freezed,
    Object? ref = freezed,
    Object? tranId = freezed,
    Object? trackId = freezed,
    Object? paymentType = freezed,
    Object? amount = freezed,
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
      paymentId: paymentId == freezed
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String?,
      ref: ref == freezed
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String?,
      tranId: tranId == freezed
          ? _value.tranId
          : tranId // ignore: cast_nullable_to_non_nullable
              as String?,
      trackId: trackId == freezed
          ? _value.trackId
          : trackId // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentType: paymentType == freezed
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
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
abstract class _$$_PaymentModelCopyWith<$Res>
    implements $PaymentModelCopyWith<$Res> {
  factory _$$_PaymentModelCopyWith(
          _$_PaymentModel value, $Res Function(_$_PaymentModel) then) =
      __$$_PaymentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int userId,
      String? paymentId,
      String? ref,
      String? tranId,
      String? trackId,
      String paymentType,
      double amount,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_PaymentModelCopyWithImpl<$Res>
    extends _$PaymentModelCopyWithImpl<$Res>
    implements _$$_PaymentModelCopyWith<$Res> {
  __$$_PaymentModelCopyWithImpl(
      _$_PaymentModel _value, $Res Function(_$_PaymentModel) _then)
      : super(_value, (v) => _then(v as _$_PaymentModel));

  @override
  _$_PaymentModel get _value => super._value as _$_PaymentModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? paymentId = freezed,
    Object? ref = freezed,
    Object? tranId = freezed,
    Object? trackId = freezed,
    Object? paymentType = freezed,
    Object? amount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_PaymentModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentId: paymentId == freezed
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String?,
      ref: ref == freezed
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String?,
      tranId: tranId == freezed
          ? _value.tranId
          : tranId // ignore: cast_nullable_to_non_nullable
              as String?,
      trackId: trackId == freezed
          ? _value.trackId
          : trackId // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentType: paymentType == freezed
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
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
class _$_PaymentModel implements _PaymentModel {
  _$_PaymentModel(
      {this.id = -1,
      required this.userId,
      this.paymentId,
      this.ref,
      this.tranId,
      this.trackId,
      this.paymentType = 'unknown',
      this.amount = 0,
      this.createdAt,
      this.updatedAt});

  factory _$_PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int userId;
  @override
  final String? paymentId;
  @override
  final String? ref;
  @override
  final String? tranId;
  @override
  final String? trackId;
  @override
  @JsonKey()
  final String paymentType;
  @override
  @JsonKey()
  final double amount;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PaymentModel(id: $id, userId: $userId, paymentId: $paymentId, ref: $ref, tranId: $tranId, trackId: $trackId, paymentType: $paymentType, amount: $amount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.paymentId, paymentId) &&
            const DeepCollectionEquality().equals(other.ref, ref) &&
            const DeepCollectionEquality().equals(other.tranId, tranId) &&
            const DeepCollectionEquality().equals(other.trackId, trackId) &&
            const DeepCollectionEquality()
                .equals(other.paymentType, paymentType) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(paymentId),
      const DeepCollectionEquality().hash(ref),
      const DeepCollectionEquality().hash(tranId),
      const DeepCollectionEquality().hash(trackId),
      const DeepCollectionEquality().hash(paymentType),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_PaymentModelCopyWith<_$_PaymentModel> get copyWith =>
      __$$_PaymentModelCopyWithImpl<_$_PaymentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentModelToJson(
      this,
    );
  }
}

abstract class _PaymentModel implements PaymentModel {
  factory _PaymentModel(
      {final int id,
      required final int userId,
      final String? paymentId,
      final String? ref,
      final String? tranId,
      final String? trackId,
      final String paymentType,
      final double amount,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_PaymentModel;

  factory _PaymentModel.fromJson(Map<String, dynamic> json) =
      _$_PaymentModel.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String? get paymentId;
  @override
  String? get ref;
  @override
  String? get tranId;
  @override
  String? get trackId;
  @override
  String get paymentType;
  @override
  double get amount;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentModelCopyWith<_$_PaymentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
