import 'package:json_annotation/json_annotation.dart';

part 'owner.weekly.stat.dto.g.dart';

@JsonSerializable()
class OwnerWeeklyStatDto {
  double? totalHours;
  double? totalincome;
  DateTime? date;

  OwnerWeeklyStatDto(this.date, this.totalHours, this.totalincome);

  factory OwnerWeeklyStatDto.fromJson(Map<String, dynamic> json) =>
      _$OwnerWeeklyStatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerWeeklyStatDtoToJson(this);
}
