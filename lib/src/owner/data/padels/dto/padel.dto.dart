import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/owner/data/bookings/dto/padel.schedule.dto.dart';
import 'package:bandeja/src/owner/data/padels/dto/padel.feature.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/authentication/dto/location.dto.dart';

part 'padel.dto.g.dart';

@JsonSerializable()
class PadelDto {
  int id = -1;
  int userId = -1;
  int? durationId;
  int? padelGroupId;
  String? name;
  String? banner;
  String? bannerLocalImage;
  String? avatar;
  String? avatarLocalImage;
  int? locationId;
  int? addressId;
  bool? approved;
  DateTime? startTime;
  DateTime? endTime;
  double price = 0;
  bool indoor = false;
  bool onlyLadies = false;
  bool enabled = true;
  LocationDto? locationDto;
  List<PadelFeatureDto> padelFeatureDto = const [];
  List<PadelScheduleDto> padelSchedules = const [];
  PadelDto(
      this.id,
      this.userId,
      this.durationId,
      this.padelGroupId,
      this.name,
      this.banner,
      this.bannerLocalImage,
      this.avatar,
      this.avatarLocalImage,
      this.approved,
      this.locationId,
      this.addressId,
      this.startTime,
      this.endTime,
      this.price,
      this.indoor,
      this.onlyLadies,
      this.enabled,
      this.padelFeatureDto,
      this.locationDto,
      this.padelSchedules);

  PadelDto.empty({
    this.id = -1,
    this.userId = -1,
    this.durationId,
    this.padelGroupId,
    this.bannerLocalImage,
    this.name,
    this.avatarLocalImage,
    this.banner,
    this.approved,
    this.avatar,
    this.locationId,
    this.addressId,
    this.startTime,
    this.endTime,
    this.price = 0,
    this.indoor = false,
    this.onlyLadies = false,
    this.enabled = true,
    this.padelFeatureDto = const [],
    this.padelSchedules = const [],
    this.locationDto,
  });

  PadelDto.fromPadelModel(PadelModel padel) {
    id = padel.id;
    userId = padel.userId;
    durationId = padel.durationId;
    padelGroupId = padel.padelGroupId;
    name = padel.name;
    banner = padel.banner;
    avatar = padel.avatar;
    locationId = padel.locationId;
    addressId = padel.addressId;
    startTime = padel.startTime;
    endTime = padel.endTime;
    approved = padel.approved;
    price = padel.price;
    indoor = padel.indoor;
    onlyLadies = padel.onlyLadies;
    enabled = padel.enabled;
    locationDto = LocationDto.fromModel(padel.Location);
    padelFeatureDto = padel
        .getFeatures()
        .map((e) => PadelFeatureDto.empty(
            id: e.PadelFeature?.id ?? -1,
            featureId: e.PadelFeature?.featureId ?? -1,
            padelId: e.PadelFeature?.padelId ?? -1,
            free: e.PadelFeature?.free ?? false))
        .toList();
    padelSchedules = padel
        .getSchedules()
        .map((e) => PadelScheduleDto.empty(
              id: e.id,
              padelId: e.padelId,
              status: e.status,
              booked: e.booked,
              startTime: e.startTime,
              endTime: e.endTime,
              price: e.price,
            ))
        .toList();
  }

  Map<String, dynamic> toJson() => _$PadelDtoToJson(this);

  factory PadelDto.fromJson(Map<String, dynamic> json) =>
      _$PadelDtoFromJson(json);
}
