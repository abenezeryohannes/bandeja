import 'package:bandeja/src/owner/data/dto/owner.monthly.stat.dto.dart';
import 'package:bandeja/src/owner/data/dto/owner.weekly.stat.dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/booking/i.owner.booking.repository.dart';
import '../../../domain/padels/i.owner.padel.repository.dart';

class OwnerStatPageController extends GetxController {
  final padelRepository = getIt<IOwnerPadelRepository>();
  final userRepository = getIt<IUserRepository>();
  Rx<UserModel> user = Rx<UserModel>(UserModel(fullName: 'Anonymous Account'));
  final bookingRepository = getIt<IOwnerBookingRepository>();
  final padels = Rx<WrapperDto<List<PadelModel>>>(EmptyState());
  final allPadel = PadelModel(
      userId: -1,
      durationId: -1,
      name: "All",
      padelGroupId: -1,
      startTime: DateTime.now(),
      endTime: DateTime.now());
  final pickedPadel = Rxn<PadelModel>();
  final ownerWeeklyStatDto =
      Rx<WrapperDto<List<OwnerWeeklyStatDto>>>(EmptyState());
  final ownerMonthlyStatDto = Rx<WrapperDto<OwnerMonthlyStatDto>>(EmptyState());
  Rx<DateTimeRange> month = Rx<DateTimeRange>(
      DateTimeRange(start: DateTime.now(), end: DateTime.now()));

  static const pageSize = 500;

  @override
  void onInit() {
    loadUser();

    pickedPadel.value = allPadel;
    int mon = DateTime.now().month;

    month.value = DateTimeRange(
        start: DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0),
        end: DateTime(DateTime.now().year + (mon == 12 ? 1 : 0),
                DateTime.now().month + (mon < 12 ? 1 : 0), 1, 0, 0, 0)
            .subtract(const Duration(days: 1)));

    debounce(pickedPadel, (_) {
      getOwnerWeeklyStat();
      getOwnerMonthlyStat();
    }, time: const Duration(microseconds: 500));

    debounce(month, (_) {
      getOwnerMonthlyStat();
    }, time: const Duration(microseconds: 500));

    getPadels(page: 1);

    getOwnerWeeklyStat();

    getOwnerMonthlyStat();

    super.onInit();
  }

  getPadels({int? page}) async {
    padels.value = WrapperDto.loadingState();
    final result = await padelRepository.getPadels(page: page, limit: pageSize);
    if (result == null) {
      padels.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        padels.value = WrapperDto.errorState(failure: l);
      }, (r) {
        List<PadelModel> temp = r;
        temp.insert(0, allPadel);
        padels.value = WrapperDto<List<PadelModel>>.loadedState(value: temp);
      });
    }
  }

  getOwnerWeeklyStat({int? page}) async {
    ownerWeeklyStatDto.value = WrapperDto.loadingState();
    final result =
        await bookingRepository.getOwnerWeeklyStat(padel: pickedPadel.value);
    if (result == null) {
      ownerWeeklyStatDto.value =
          WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        ownerWeeklyStatDto.value = WrapperDto.errorState(failure: l);
      }, (r) {
        ownerWeeklyStatDto.value =
            WrapperDto<List<OwnerWeeklyStatDto>>.loadedState(value: r);
      });
    }
  }

  getOwnerMonthlyStat({int? page}) async {
    ownerMonthlyStatDto.value = WrapperDto.loadingState();
    final result = await bookingRepository.getOwnerMonthlyStat(
        padel: (pickedPadel.value != null && pickedPadel.value?.id == -1)
            ? null
            : pickedPadel.value,
        startTime: DateFormat('yyyy-MM-dd').format(month.value.start),
        endTime: DateFormat('yyyy-MM-dd').format(month.value.end));
    if (result == null) {
      ownerMonthlyStatDto.value =
          WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        ownerMonthlyStatDto.value = WrapperDto.errorState(failure: l);
      }, (r) {
        ownerMonthlyStatDto.value =
            WrapperDto<OwnerMonthlyStatDto>.loadedState(value: r);
      });
    }
  }

  void loadUser() async {
    final result = await userRepository.loadUser();
    result?.fold((l) {
      user.value = UserModel(fullName: 'Anonymous Account');
    }, (r) {
      user.value = r;
    });
  }
}
