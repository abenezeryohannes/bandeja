import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'system.variable.freezed.dart';
part 'system.variable.g.dart';

@freezed
class SystemVariableModel with _$SystemVariableModel {
  factory SystemVariableModel({
    @Default(-1) int id,
    @Default('') String key,
    String? value,
  }) = _SystemVariableModel;

  factory SystemVariableModel.empty() => SystemVariableModel(
        id: -1,
        key: '',
        value: '',
      );

  factory SystemVariableModel.fromJson(Map<String, Object?> json) =>
      _$SystemVariableModelFromJson(json);
}
