import 'dart:math';

import 'package:bandeja/src/core/domain/padels/entities/bookmark.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../main/domain/core/entities/address.dart';
import '../../../../main/domain/core/entities/location.dart';
import 'duration.dart';
import 'feature.dart';
import 'padel.group.dart';
import 'padel.schedule.dart';

part 'padel.freezed.dart';
part 'padel.g.dart';

@freezed
class PadelModel with _$PadelModel {
  factory PadelModel({
    @Default(-1) int id,
    required int userId,
    required int durationId,
    int? padelGroupId,
    @Default('') String name,
    @Default('placeholder.jpg') String banner,
    @Default('placeholder.jpg') String avatar,
    int? locationId,
    int? addressId,
    @Default(false) bool approved,
    required DateTime startTime,
    required DateTime endTime,
    @Default(0) double price,
    @Default(false) bool indoor,
    @Default(false) bool onlyLadies,
    @Default(true) bool enabled,
    List<PadelGroupModel>? PadelGroups,
    List<FeatureModel>? Features,
    LocationModel? Location,
    DurationModel? Duration,
    AddressModel? Address,
    List<BookmarkModel>? Bookmarks,
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

  String getDistance() {
    if (Location == null ||
        GetStorage().read('latitude') == null ||
        GetStorage().read('longitude') == null) {
      return 'Unknown';
    }
    double lat1 = Location?.latitude ?? 0;
    double lon1 = Location?.longitude ?? 0;
    double lat2 = GetStorage().read('latitude');
    double lon2 = GetStorage().read('longitude');
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return '${12742 * asin(sqrt(a))} Km';
  }

  bool isBookmarked() {
    return Bookmarks == null ? false : Bookmarks!.isNotEmpty;
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
