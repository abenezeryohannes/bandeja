// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'padel.order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PadelOrderModel _$PadelOrderModelFromJson(Map<String, dynamic> json) {
  return _PadelOrderModel.fromJson(json);
}

/// @nodoc
mixin _$PadelOrderModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get padelId => throw _privateConstructorUsedError;
  int get padelScheduleId => throw _privateConstructorUsedError;
  int? get promoCodeId => throw _privateConstructorUsedError;
  int? get paymentId => throw _privateConstructorUsedError;
  String? get barCode => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  UserModel? get User => throw _privateConstructorUsedError;
  PaymentModel? get Payment => throw _privateConstructorUsedError;
  PromoCodeModel? get PromoCode => throw _privateConstructorUsedError;
  PadelModel? get Padel => throw _privateConstructorUsedError;
  PadelScheduleModel? get PadelSchedule => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PadelOrderModelCopyWith<PadelOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadelOrderModelCopyWith<$Res> {
  factory $PadelOrderModelCopyWith(
          PadelOrderModel value, $Res Function(PadelOrderModel) then) =
      _$PadelOrderModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int userId,
      int padelId,
      int padelScheduleId,
      int? promoCodeId,
      int? paymentId,
      String? barCode,
      String status,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt,
      UserModel? User,
      PaymentModel? Payment,
      PromoCodeModel? PromoCode,
      PadelModel? Padel,
      PadelScheduleModel? PadelSchedule});

  $UserModelCopyWith<$Res>? get User;
  $PaymentModelCopyWith<$Res>? get Payment;
  $PromoCodeModelCopyWith<$Res>? get PromoCode;
  $PadelModelCopyWith<$Res>? get Padel;
  $PadelScheduleModelCopyWith<$Res>? get PadelSchedule;
}

/// @nodoc
class _$PadelOrderModelCopyWithImpl<$Res>
    implements $PadelOrderModelCopyWith<$Res> {
  _$PadelOrderModelCopyWithImpl(this._value, this._then);

  final PadelOrderModel _value;
  // ignore: unused_field
  final $Res Function(PadelOrderModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? padelId = freezed,
    Object? padelScheduleId = freezed,
    Object? promoCodeId = freezed,
    Object? paymentId = freezed,
    Object? barCode = freezed,
    Object? status = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? User = freezed,
    Object? Payment = freezed,
    Object? PromoCode = freezed,
    Object? Padel = freezed,
    Object? PadelSchedule = freezed,
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
      padelScheduleId: padelScheduleId == freezed
          ? _value.padelScheduleId
          : padelScheduleId // ignore: cast_nullable_to_non_nullable
              as int,
      promoCodeId: promoCodeId == freezed
          ? _value.promoCodeId
          : promoCodeId // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentId: paymentId == freezed
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as int?,
      barCode: barCode == freezed
          ? _value.barCode
          : barCode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
      User: User == freezed
          ? _value.User
          : User // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      Payment: Payment == freezed
          ? _value.Payment
          : Payment // ignore: cast_nullable_to_non_nullable
              as PaymentModel?,
      PromoCode: PromoCode == freezed
          ? _value.PromoCode
          : PromoCode // ignore: cast_nullable_to_non_nullable
              as PromoCodeModel?,
      Padel: Padel == freezed
          ? _value.Padel
          : Padel // ignore: cast_nullable_to_non_nullable
              as PadelModel?,
      PadelSchedule: PadelSchedule == freezed
          ? _value.PadelSchedule
          : PadelSchedule // ignore: cast_nullable_to_non_nullable
              as PadelScheduleModel?,
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

  @override
  $PaymentModelCopyWith<$Res>? get Payment {
    if (_value.Payment == null) {
      return null;
    }

    return $PaymentModelCopyWith<$Res>(_value.Payment!, (value) {
      return _then(_value.copyWith(Payment: value));
    });
  }

  @override
  $PromoCodeModelCopyWith<$Res>? get PromoCode {
    if (_value.PromoCode == null) {
      return null;
    }

    return $PromoCodeModelCopyWith<$Res>(_value.PromoCode!, (value) {
      return _then(_value.copyWith(PromoCode: value));
    });
  }

  @override
  $PadelModelCopyWith<$Res>? get Padel {
    if (_value.Padel == null) {
      return null;
    }

    return $PadelModelCopyWith<$Res>(_value.Padel!, (value) {
      return _then(_value.copyWith(Padel: value));
    });
  }

  @override
  $PadelScheduleModelCopyWith<$Res>? get PadelSchedule {
    if (_value.PadelSchedule == null) {
      return null;
    }

    return $PadelScheduleModelCopyWith<$Res>(_value.PadelSchedule!, (value) {
      return _then(_value.copyWith(PadelSchedule: value));
    });
  }
}

/// @nodoc
abstract class _$$_PadelOrderModelCopyWith<$Res>
    implements $PadelOrderModelCopyWith<$Res> {
  factory _$$_PadelOrderModelCopyWith(
          _$_PadelOrderModel value, $Res Function(_$_PadelOrderModel) then) =
      __$$_PadelOrderModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int userId,
      int padelId,
      int padelScheduleId,
      int? promoCodeId,
      int? paymentId,
      String? barCode,
      String status,
      bool enabled,
      DateTime? createdAt,
      DateTime? updatedAt,
      UserModel? User,
      PaymentModel? Payment,
      PromoCodeModel? PromoCode,
      PadelModel? Padel,
      PadelScheduleModel? PadelSchedule});

  @override
  $UserModelCopyWith<$Res>? get User;
  @override
  $PaymentModelCopyWith<$Res>? get Payment;
  @override
  $PromoCodeModelCopyWith<$Res>? get PromoCode;
  @override
  $PadelModelCopyWith<$Res>? get Padel;
  @override
  $PadelScheduleModelCopyWith<$Res>? get PadelSchedule;
}

/// @nodoc
class __$$_PadelOrderModelCopyWithImpl<$Res>
    extends _$PadelOrderModelCopyWithImpl<$Res>
    implements _$$_PadelOrderModelCopyWith<$Res> {
  __$$_PadelOrderModelCopyWithImpl(
      _$_PadelOrderModel _value, $Res Function(_$_PadelOrderModel) _then)
      : super(_value, (v) => _then(v as _$_PadelOrderModel));

  @override
  _$_PadelOrderModel get _value => super._value as _$_PadelOrderModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? padelId = freezed,
    Object? padelScheduleId = freezed,
    Object? promoCodeId = freezed,
    Object? paymentId = freezed,
    Object? barCode = freezed,
    Object? status = freezed,
    Object? enabled = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? User = freezed,
    Object? Payment = freezed,
    Object? PromoCode = freezed,
    Object? Padel = freezed,
    Object? PadelSchedule = freezed,
  }) {
    return _then(_$_PadelOrderModel(
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
      padelScheduleId: padelScheduleId == freezed
          ? _value.padelScheduleId
          : padelScheduleId // ignore: cast_nullable_to_non_nullable
              as int,
      promoCodeId: promoCodeId == freezed
          ? _value.promoCodeId
          : promoCodeId // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentId: paymentId == freezed
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as int?,
      barCode: barCode == freezed
          ? _value.barCode
          : barCode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
      User: User == freezed
          ? _value.User
          : User // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      Payment: Payment == freezed
          ? _value.Payment
          : Payment // ignore: cast_nullable_to_non_nullable
              as PaymentModel?,
      PromoCode: PromoCode == freezed
          ? _value.PromoCode
          : PromoCode // ignore: cast_nullable_to_non_nullable
              as PromoCodeModel?,
      Padel: Padel == freezed
          ? _value.Padel
          : Padel // ignore: cast_nullable_to_non_nullable
              as PadelModel?,
      PadelSchedule: PadelSchedule == freezed
          ? _value.PadelSchedule
          : PadelSchedule // ignore: cast_nullable_to_non_nullable
              as PadelScheduleModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PadelOrderModel
    with DiagnosticableTreeMixin
    implements _PadelOrderModel {
  _$_PadelOrderModel(
      {this.id = -1,
      required this.userId,
      required this.padelId,
      required this.padelScheduleId,
      this.promoCodeId,
      this.paymentId,
      this.barCode,
      this.status = 'pending',
      this.enabled = true,
      this.createdAt,
      this.updatedAt,
      this.User,
      this.Payment,
      this.PromoCode,
      this.Padel,
      this.PadelSchedule});

  factory _$_PadelOrderModel.fromJson(Map<String, dynamic> json) =>
      _$$_PadelOrderModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int userId;
  @override
  final int padelId;
  @override
  final int padelScheduleId;
  @override
  final int? promoCodeId;
  @override
  final int? paymentId;
  @override
  final String? barCode;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final bool enabled;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final UserModel? User;
  @override
  final PaymentModel? Payment;
  @override
  final PromoCodeModel? PromoCode;
  @override
  final PadelModel? Padel;
  @override
  final PadelScheduleModel? PadelSchedule;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PadelOrderModel(id: $id, userId: $userId, padelId: $padelId, padelScheduleId: $padelScheduleId, promoCodeId: $promoCodeId, paymentId: $paymentId, barCode: $barCode, status: $status, enabled: $enabled, createdAt: $createdAt, updatedAt: $updatedAt, User: $User, Payment: $Payment, PromoCode: $PromoCode, Padel: $Padel, PadelSchedule: $PadelSchedule)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PadelOrderModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('padelId', padelId))
      ..add(DiagnosticsProperty('padelScheduleId', padelScheduleId))
      ..add(DiagnosticsProperty('promoCodeId', promoCodeId))
      ..add(DiagnosticsProperty('paymentId', paymentId))
      ..add(DiagnosticsProperty('barCode', barCode))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('User', User))
      ..add(DiagnosticsProperty('Payment', Payment))
      ..add(DiagnosticsProperty('PromoCode', PromoCode))
      ..add(DiagnosticsProperty('Padel', Padel))
      ..add(DiagnosticsProperty('PadelSchedule', PadelSchedule));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PadelOrderModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.padelId, padelId) &&
            const DeepCollectionEquality()
                .equals(other.padelScheduleId, padelScheduleId) &&
            const DeepCollectionEquality()
                .equals(other.promoCodeId, promoCodeId) &&
            const DeepCollectionEquality().equals(other.paymentId, paymentId) &&
            const DeepCollectionEquality().equals(other.barCode, barCode) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.User, User) &&
            const DeepCollectionEquality().equals(other.Payment, Payment) &&
            const DeepCollectionEquality().equals(other.PromoCode, PromoCode) &&
            const DeepCollectionEquality().equals(other.Padel, Padel) &&
            const DeepCollectionEquality()
                .equals(other.PadelSchedule, PadelSchedule));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(padelId),
      const DeepCollectionEquality().hash(padelScheduleId),
      const DeepCollectionEquality().hash(promoCodeId),
      const DeepCollectionEquality().hash(paymentId),
      const DeepCollectionEquality().hash(barCode),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(User),
      const DeepCollectionEquality().hash(Payment),
      const DeepCollectionEquality().hash(PromoCode),
      const DeepCollectionEquality().hash(Padel),
      const DeepCollectionEquality().hash(PadelSchedule));

  @JsonKey(ignore: true)
  @override
  _$$_PadelOrderModelCopyWith<_$_PadelOrderModel> get copyWith =>
      __$$_PadelOrderModelCopyWithImpl<_$_PadelOrderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PadelOrderModelToJson(
      this,
    );
  }
}

abstract class _PadelOrderModel implements PadelOrderModel {
  factory _PadelOrderModel(
      {final int id,
      required final int userId,
      required final int padelId,
      required final int padelScheduleId,
      final int? promoCodeId,
      final int? paymentId,
      final String? barCode,
      final String status,
      final bool enabled,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final UserModel? User,
      final PaymentModel? Payment,
      final PromoCodeModel? PromoCode,
      final PadelModel? Padel,
      final PadelScheduleModel? PadelSchedule}) = _$_PadelOrderModel;

  factory _PadelOrderModel.fromJson(Map<String, dynamic> json) =
      _$_PadelOrderModel.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  int get padelId;
  @override
  int get padelScheduleId;
  @override
  int? get promoCodeId;
  @override
  int? get paymentId;
  @override
  String? get barCode;
  @override
  String get status;
  @override
  bool get enabled;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  UserModel? get User;
  @override
  PaymentModel? get Payment;
  @override
  PromoCodeModel? get PromoCode;
  @override
  PadelModel? get Padel;
  @override
  PadelScheduleModel? get PadelSchedule;
  @override
  @JsonKey(ignore: true)
  _$$_PadelOrderModelCopyWith<_$_PadelOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}
