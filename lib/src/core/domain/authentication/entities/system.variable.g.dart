// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.variable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SystemVariableModel _$$_SystemVariableModelFromJson(
        Map<String, dynamic> json) =>
    _$_SystemVariableModel(
      id: json['id'] as int? ?? -1,
      key: json['key'] as String? ?? '',
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$_SystemVariableModelToJson(
        _$_SystemVariableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.value,
    };
