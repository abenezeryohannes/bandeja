// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingModel _$SettingModelFromJson(Map<String, dynamic> json) => SettingModel(
      id: json['id'] as String,
      privacy_url: json['privacy_url'] as String,
      host_url: json['host_url'] as String,
      home_button_link: json['home_button_link'] as String,
      share_title: json['share_title'] as String,
      whatsApp: json['whatsApp'] as String,
    );

Map<String, dynamic> _$SettingModelToJson(SettingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'home_button_link': instance.home_button_link,
      'whatsApp': instance.whatsApp,
      'privacy_url': instance.privacy_url,
      'share_title': instance.share_title,
      'host_url': instance.host_url,
    };
