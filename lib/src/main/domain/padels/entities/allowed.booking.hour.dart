import 'package:freezed_annotation/freezed_annotation.dart';

part 'allowed.booking.hour.freezed.dart';
part 'allowed.booking.hour.g.dart';

@freezed
class AllowedBookingHourModel with _$AllowedBookingHourModel {
  factory AllowedBookingHourModel({
    @Default(-1) int id,
    required int padelId,
    @Default(1) int hour,
    @Default(true) bool am,
  }) = _AllowedBookingHourModel;
  factory AllowedBookingHourModel.fromJson(Map<String, dynamic> json) =>
      _$AllowedBookingHourModelFromJson(json);
}
