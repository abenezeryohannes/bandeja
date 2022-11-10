import 'package:json_annotation/json_annotation.dart';

part 'admin.weekly.stat.dto.g.dart';

@JsonSerializable()
class AdminWeeklyStatDto {
  double? totalHours;
  double? totalincome;
  DateTime? date;

  AdminWeeklyStatDto(this.date, this.totalHours, this.totalincome);

  factory AdminWeeklyStatDto.fromJson(Map<String, dynamic> json) =>
      _$AdminWeeklyStatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminWeeklyStatDtoToJson(this);
}
