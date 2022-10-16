// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'allowed.booking.hour.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AllowedBookingHourModel _$AllowedBookingHourModelFromJson(
    Map<String, dynamic> json) {
  return _AllowedBookingHourModel.fromJson(json);
}

/// @nodoc
mixin _$AllowedBookingHourModel {
  int get id => throw _privateConstructorUsedError;
  int get padelId => throw _privateConstructorUsedError;
  int get hour => throw _privateConstructorUsedError;
  bool get am => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllowedBookingHourModelCopyWith<AllowedBookingHourModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllowedBookingHourModelCopyWith<$Res> {
  factory $AllowedBookingHourModelCopyWith(AllowedBookingHourModel value,
          $Res Function(AllowedBookingHourModel) then) =
      _$AllowedBookingHourModelCopyWithImpl<$Res>;
  $Res call({int id, int padelId, int hour, bool am});
}

/// @nodoc
class _$AllowedBookingHourModelCopyWithImpl<$Res>
    implements $AllowedBookingHourModelCopyWith<$Res> {
  _$AllowedBookingHourModelCopyWithImpl(this._value, this._then);

  final AllowedBookingHourModel _value;
  // ignore: unused_field
  final $Res Function(AllowedBookingHourModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? padelId = freezed,
    Object? hour = freezed,
    Object? am = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
      hour: hour == freezed
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      am: am == freezed
          ? _value.am
          : am // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_AllowedBookingHourModelCopyWith<$Res>
    implements $AllowedBookingHourModelCopyWith<$Res> {
  factory _$$_AllowedBookingHourModelCopyWith(_$_AllowedBookingHourModel value,
          $Res Function(_$_AllowedBookingHourModel) then) =
      __$$_AllowedBookingHourModelCopyWithImpl<$Res>;
  @override
  $Res call({int id, int padelId, int hour, bool am});
}

/// @nodoc
class __$$_AllowedBookingHourModelCopyWithImpl<$Res>
    extends _$AllowedBookingHourModelCopyWithImpl<$Res>
    implements _$$_AllowedBookingHourModelCopyWith<$Res> {
  __$$_AllowedBookingHourModelCopyWithImpl(_$_AllowedBookingHourModel _value,
      $Res Function(_$_AllowedBookingHourModel) _then)
      : super(_value, (v) => _then(v as _$_AllowedBookingHourModel));

  @override
  _$_AllowedBookingHourModel get _value =>
      super._value as _$_AllowedBookingHourModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? padelId = freezed,
    Object? hour = freezed,
    Object? am = freezed,
  }) {
    return _then(_$_AllowedBookingHourModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      padelId: padelId == freezed
          ? _value.padelId
          : padelId // ignore: cast_nullable_to_non_nullable
              as int,
      hour: hour == freezed
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      am: am == freezed
          ? _value.am
          : am // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AllowedBookingHourModel implements _AllowedBookingHourModel {
  _$_AllowedBookingHourModel(
      {this.id = -1, required this.padelId, this.hour = 1, this.am = true});

  factory _$_AllowedBookingHourModel.fromJson(Map<String, dynamic> json) =>
      _$$_AllowedBookingHourModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int padelId;
  @override
  @JsonKey()
  final int hour;
  @override
  @JsonKey()
  final bool am;

  @override
  String toString() {
    return 'AllowedBookingHourModel(id: $id, padelId: $padelId, hour: $hour, am: $am)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AllowedBookingHourModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.padelId, padelId) &&
            const DeepCollectionEquality().equals(other.hour, hour) &&
            const DeepCollectionEquality().equals(other.am, am));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(padelId),
      const DeepCollectionEquality().hash(hour),
      const DeepCollectionEquality().hash(am));

  @JsonKey(ignore: true)
  @override
  _$$_AllowedBookingHourModelCopyWith<_$_AllowedBookingHourModel>
      get copyWith =>
          __$$_AllowedBookingHourModelCopyWithImpl<_$_AllowedBookingHourModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AllowedBookingHourModelToJson(
      this,
    );
  }
}

abstract class _AllowedBookingHourModel implements AllowedBookingHourModel {
  factory _AllowedBookingHourModel(
      {final int id,
      required final int padelId,
      final int hour,
      final bool am}) = _$_AllowedBookingHourModel;

  factory _AllowedBookingHourModel.fromJson(Map<String, dynamic> json) =
      _$_AllowedBookingHourModel.fromJson;

  @override
  int get id;
  @override
  int get padelId;
  @override
  int get hour;
  @override
  bool get am;
  @override
  @JsonKey(ignore: true)
  _$$_AllowedBookingHourModelCopyWith<_$_AllowedBookingHourModel>
      get copyWith => throw _privateConstructorUsedError;
}
