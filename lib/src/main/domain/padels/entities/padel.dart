import 'package:feekpadel/src/main/domain/padels/entities/feature.dart';
import 'package:feekpadel/src/main/domain/padels/entities/padel.group.dart';
import 'package:feekpadel/src/main/domain/padels/entities/padel.schedule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../authentication/entities/user.dart';
import '../../core/entities/address.dart';
import '../../core/entities/location.dart';
import 'duration.dart';

part 'padel.freezed.dart';
part 'padel.g.dart';

@freezed
class PadelModel with _$PadelModel {
  factory PadelModel({
    @Default(-1) int id,
    required int userId,
    required int durationId,
    required int padelGroupId,
    @Default('') String name,
    @Default('placeholder.jpg') String banner,
    @Default('placeholder.jpg') String avatar,
    int? locationId,
    int? addressId,
    required DateTime startTime,
    required DateTime endTime,
    @Default('0.0') String price,
    @Default(false) bool indoor,
    @Default(false) bool onlyLadies,
    @Default(true) bool enabled,
    PadelGroupModel? PadelGroup,
    List<FeatureModel>? Features,
    LocationModel? Location,
    DurationModel? Duration,
    AddressModel? Address,
    UserModel? User,
    List<PadelScheduleModel>? PadelSchedules,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Padel;
  factory PadelModel.fromJson(Map<String, dynamic> json) =>
      _$PadelModelFromJson(json);
}

extension PadelModelX on PadelModel {
  AddressModel getAddress() {
    return Address ?? AddressModel(name: "Unknown");
  }

  UserModel getUser() {
    return User ?? UserModel(fullName: "Unknown");
  }

  DurationModel getDuration() {
    return this.Duration ?? DurationModel(minute: 60);
  }

  List<PadelScheduleModel> getSchedules() {
    return PadelSchedules ?? [];
  }

  List<DateTime> getAllScheduleStartTimes() {
    List<DateTime> schedules = [];
    for (DateTime index = startTime;
        index.isBefore(endTime);
        index = index.add(Duration(minutes: getDuration().minute))) {
      schedules.add(index);
    }
    return schedules;
  }

  DateTime? getFirstFreeSpot() {
    List<DateTime> times = getAllScheduleStartTimes();
    for (int i = 0; i < times.length; i++) {
      bool same = true;
      for (int j = 0; j < getSchedules().length; j++) {
        if (times[i] == getSchedules()[j].startTime) {
          same = false;
          break;
        }
      }
      if (same) {
        return times[i];
      }
    }
    return null;
  }

  List<FeatureModel> getFeatures() {
    return Features ?? [];
  }
}
