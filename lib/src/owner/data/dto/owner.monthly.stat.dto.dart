import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner.monthly.stat.dto.g.dart';

@JsonSerializable()
class OwnerMonthlyStatDto {
  int? totalVisit;
  double? totalHours;
  double? totalincome;

  OwnerMonthlyStatDto(this.totalVisit, this.totalHours, this.totalincome);

  factory OwnerMonthlyStatDto.fromJson(Map<String, dynamic> json) =>
      _$OwnerMonthlyStatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerMonthlyStatDtoToJson(this);
}
