import 'package:freezed_annotation/freezed_annotation.dart';

part 'padel.price.freezed.dart';
part 'padel.price.g.dart';

@freezed
class PadelPriceModel with _$PadelPriceModel {
  factory PadelPriceModel({
    @Default(-1) id,
    required int padelId,
    @Default(0) double price,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PadelPriceModel;
  factory PadelPriceModel.fromJson(Map<String, dynamic> json) =>
      _$PadelPriceModelFromJson(json);
}
