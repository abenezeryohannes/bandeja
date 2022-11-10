import 'package:json_annotation/json_annotation.dart';
part 'notification.response.dto.g.dart';

@JsonSerializable()
class NotificationResponseDto {
  int? success;
  int? failure;

  NotificationResponseDto.empty({this.success = 0, this.failure = 0});

  NotificationResponseDto(this.success, this.failure);

  Map<String, dynamic> toJson() => _$NotificationResponseDtoToJson(this);

  factory NotificationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseDtoFromJson(json);
}
