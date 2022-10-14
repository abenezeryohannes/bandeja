import 'package:freezed_annotation/freezed_annotation.dart';

part 'duration.freezed.dart';
part 'duration.g.dart';

@freezed
class DurationModel with _$DurationModel {
  factory DurationModel({
    @Default(-1) int id,
    @Default(0) int minute,
  }) = _DurationModel;
  factory DurationModel.fromJson(Map<String, dynamic> json) =>
      _$DurationModelFromJson(json);
}
