import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/error/failure.dart';
import '../../../data/bookings/dto/padel.schedule.dto.dart';
import '../../../domain/booking/i.owner.booking.repository.dart';
import '../../../domain/padels/i.owner.padel.repository.dart';

class OwnerScheduleBottomSheetController extends GetxController {
  OwnerScheduleBottomSheetController(this.padelSchedule) {
    padelSchduleDto.value = PadelScheduleDto.empty(
        startTime: padelSchedule.value.startTime,
        endTime: padelSchedule.value.endTime,
        price: padelSchedule.value.price,
        booked: padelSchedule.value.booked,
        id: padelSchedule.value.id,
        padelId: padelSchedule.value.id);
  }

  RxBool loading = false.obs;
  final repository = getIt<IOwnerPadelRepository>();
  final bookingRepository = getIt<IOwnerBookingRepository>();
  late Rx<WrapperDto<PadelOrderModel>> padelOrderDto =
      Rx<WrapperDto<PadelOrderModel>>(EmptyState());
  late Rxn<PadelOrderModel> padelOrder = Rxn<PadelOrderModel>();
  late Rx<PadelScheduleModel> padelSchedule;
  Rx<PadelScheduleDto> padelSchduleDto =
      Rx<PadelScheduleDto>(PadelScheduleDto.empty());

  @override
  void onInit() {
    loadOrder();
    super.onInit();
  }

  loadOrder() async {
    padelOrderDto.value = WrapperDto.loadingState();
    final result = await bookingRepository.getpaymentFromSchedule(
        scheduleId: padelSchedule.value.id);
    if (result == null) {
      padelOrderDto.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        padelOrderDto.value = WrapperDto.errorState(failure: l);
      }, (r) {
        padelOrder.value = r;
        padelOrderDto.value = WrapperDto<PadelOrderModel>.loadedState(value: r);
      });
    }
  }

  saveSchedule() async {
    loading.value = true;
    final result =
        await repository.editPadelSchedule(schedule: padelSchduleDto.value);
    if (result == null) {
      Get.showSnackbar(GetSnackBar(
        titleText: const Text(
          "Error",
          style: TextStyle(color: Colors.red),
        ),
        message: UnExpectedFailure().message,
      ));
    } else {
      result.fold((l) {
        AppSnackBar.failure(failure: l);
      }, (r) {
        Get.back(result: r);
      });
    }
  }
}
