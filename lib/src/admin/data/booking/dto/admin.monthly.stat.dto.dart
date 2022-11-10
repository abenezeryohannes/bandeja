import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin.monthly.stat.dto.g.dart';

@JsonSerializable()
class AdminMonthlyStatDto {
  int? totalVisit;
  double? allHours;
  double? totalHours;
  double? bookedHours;
  double? totalincome;
  double? appVisitsCount;
  double? newUserCount;
  double? padelsCount;

  AdminMonthlyStatDto(this.totalVisit, this.totalHours, this.totalincome);

  factory AdminMonthlyStatDto.fromJson(Map<String, dynamic> json) =>
      _$AdminMonthlyStatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminMonthlyStatDtoToJson(this);
}
