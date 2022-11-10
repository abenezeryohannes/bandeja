import 'package:bandeja/src/main/domain/core/entities/location.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location.dto.g.dart';

@JsonSerializable()
class LocationDto {
  int? id;
  double? latitude;
  double? longitude;
  String? address;

  LocationDto.empty({this.id, this.latitude, this.longitude, this.address});
  LocationDto(this.id, this.latitude, this.longitude, this.address);

  LocationDto.fromModel(LocationModel? model) {
    if (model == null) return;
    latitude = model.latitude;
    longitude = model.longitude;
    address = model.address;
    id = model.id;
  }

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
}
