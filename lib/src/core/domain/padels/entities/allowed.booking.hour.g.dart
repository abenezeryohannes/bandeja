// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowed.booking.hour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AllowedBookingHourModel _$$_AllowedBookingHourModelFromJson(
        Map<String, dynamic> json) =>
    _$_AllowedBookingHourModel(
      id: json['id'] as int? ?? -1,
      padelId: json['padelId'] as int,
      hour: json['hour'] as int? ?? 1,
      am: json['am'] as bool? ?? true,
    );

Map<String, dynamic> _$$_AllowedBookingHourModelToJson(
        _$_AllowedBookingHourModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'padelId': instance.padelId,
      'hour': instance.hour,
      'am': instance.am,
    };
