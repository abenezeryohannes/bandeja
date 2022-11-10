import 'package:json_annotation/json_annotation.dart';

part 'padel.schedule.dto.g.dart';

@JsonSerializable()
class PadelScheduleDto {
  int id = -1;
  int padelId = -1;
  String? reason;
  String? status = 'free';
  bool? booked;
  DateTime? startTime;
  DateTime? endTime;
  bool? applyForAllDays;
  double? price;

  PadelScheduleDto.empty({
    this.id = -1,
    this.padelId = -1,
    this.reason,
    this.status = 'free',
    this.booked,
    this.applyForAllDays = false,
    this.startTime,
    this.endTime,
    this.price,
  });

  PadelScheduleDto(
    this.id,
    this.padelId,
    this.reason,
    this.status,
    this.applyForAllDays,
    this.booked,
    this.startTime,
    this.endTime,
    this.price,
  );

  Map<String, dynamic> toJson() => _$PadelScheduleDtoToJson(this);

  factory PadelScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$PadelScheduleDtoFromJson(json);
}
