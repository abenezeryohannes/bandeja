import 'package:bandeja/src/core/domain/notifications/entities/notification.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification.dto.g.dart';

@JsonSerializable()
class NotificationDto {
  int? userId;

  String title;
  String? desc;
  String? token;
  bool seen = false;
  String? role;

  NotificationDto(
      this.seen, this.title, this.desc, this.token, this.role, this.userId);

  NotificationDto.empty(
      {this.seen = false,
      this.title = '',
      this.desc,
      this.token,
      this.role,
      this.userId});

  NotificationDto.fromModel(NotificationModel model, {this.title = ''}) {
    title = model.title;
    desc = model.desc;
    seen = model.seen;
    userId = model.userId;
  }

  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}
