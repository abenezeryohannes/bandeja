import 'package:freezed_annotation/freezed_annotation.dart';

part 'padel.feature.dto.g.dart';

@JsonSerializable()
class PadelFeatureDto {
  int id = -1;
  int padelId = -1;
  int featureId = -1;
  bool free = true;
  PadelFeatureDto(
    this.id,
    this.featureId,
    this.padelId,
    this.free,
  );

  PadelFeatureDto.empty({
    this.id = -1,
    this.featureId = -1,
    this.padelId = -1,
    this.free = true,
  });

  Map<String, dynamic> toJson() => _$PadelFeatureDtoToJson(this);

  factory PadelFeatureDto.fromJson(Map<String, dynamic> json) =>
      _$PadelFeatureDtoFromJson(json);
}
