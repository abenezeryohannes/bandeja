import 'package:freezed_annotation/freezed_annotation.dart';

part 'padel.schedule.freezed.dart';
part 'padel.schedule.g.dart';

@freezed
class PadelScheduleModel with _$PadelScheduleModel {
  factory PadelScheduleModel({
    @Default(-1) id,
    required int padelId,
    @Default('') String reason,
    @Default('free') status,
    @Default(false) bool booked,
    required DateTime startTime,
    required DateTime endTime,
    double? price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PadelScheduleModel;
  factory PadelScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$PadelScheduleModelFromJson(json);
}
