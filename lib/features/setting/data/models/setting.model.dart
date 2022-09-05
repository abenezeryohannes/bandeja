import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/setting.dart';
part 'setting.model.g.dart';

@JsonSerializable()
class SettingModel extends Setting {
  SettingModel(
      {required super.id,
      required super.privacy_url,
      required super.host_url,
      required super.home_button_link,
      required super.share_title,
      required super.whatsApp});

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);
}
