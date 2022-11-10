import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../data/booking/dto/admin.monthly.stat.dto.dart';
import '../../../data/booking/dto/admin.weekly.stat.dto.dart';
import '../../../domain/booking/i.admin.booking.repository.dart';
import '../../../domain/padel/i.admin.padel.repository.dart';

class AdminStatsPageController extends GetxController {
  final padelRepository = getIt<IAdminPadelRepository>();
  final userRepository = getIt<IUserRepository>();
  Rx<UserModel> user = Rx<UserModel>(UserModel(fullName: 'Anonymous Account'));
  final bookingRepository = getIt<IAdminBookingRepository>();
  final padels = Rx<WrapperDto<List<PadelModel>>>(EmptyState());
  final allPadel = PadelModel(
      userId: -1,
      durationId: -1,
      name: "All",
      padelGroupId: -1,
      startTime: DateTime.now(),
      endTime: DateTime.now());
  final pickedPadel = Rxn<PadelModel>();
  final adminWeeklyStatDto =
      Rx<WrapperDto<List<AdminWeeklyStatDto>>>(EmptyState());
  final adminMonthlyStatDto = Rx<WrapperDto<AdminMonthlyStatDto>>(EmptyState());
  Rx<DateTimeRange> month = Rx<DateTimeRange>(
      DateTimeRange(start: DateTime.now(), end: DateTime.now()));

  static const pageSize = 500;

  @override
  void onInit() {
    pickedPadel.value = allPadel;
    int mon = DateTime.now().month;

    month.value = DateTimeRange(
        start: DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0),
        end: DateTime(DateTime.now().year + (mon == 12 ? 1 : 0),
                DateTime.now().month + (mon < 12 ? 1 : 0), 1, 0, 0, 0)
            .subtract(const Duration(days: 1)));

    debounce(pickedPadel, (_) {
      getAdminWeeklyStat();
      getAdminMonthlyStat();
    }, time: const Duration(microseconds: 500));

    debounce(month, (_) {
      getAdminMonthlyStat();
    }, time: const Duration(microseconds: 500));

    getPadels(page: 1);

    getAdminWeeklyStat();

    getAdminMonthlyStat();
    loadUser();

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

  getAdminWeeklyStat({int? page}) async {
    adminWeeklyStatDto.value = WrapperDto.loadingState();
    final result =
        await bookingRepository.getAdminWeeklyStat(padel: pickedPadel.value);
    if (result == null) {
      adminWeeklyStatDto.value =
          WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        adminWeeklyStatDto.value = WrapperDto.errorState(failure: l);
      }, (r) {
        adminWeeklyStatDto.value =
            WrapperDto<List<AdminWeeklyStatDto>>.loadedState(value: r);
      });
    }
  }

  getAdminMonthlyStat({int? page}) async {
    adminMonthlyStatDto.value = WrapperDto.loadingState();
    final result = await bookingRepository.getAdminMonthlyStat(
        padel: (pickedPadel.value != null && pickedPadel.value?.id == -1)
            ? null
            : pickedPadel.value,
        startTime: DateFormat('yyyy-MM-dd').format(month.value.start),
        endTime: DateFormat('yyyy-MM-dd').format(month.value.end));
    if (result == null) {
      adminMonthlyStatDto.value =
          WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        adminMonthlyStatDto.value = WrapperDto.errorState(failure: l);
      }, (r) {
        adminMonthlyStatDto.value =
            WrapperDto<AdminMonthlyStatDto>.loadedState(value: r);
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
