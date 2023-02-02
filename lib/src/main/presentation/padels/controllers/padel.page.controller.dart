import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/main/main.common.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:bandeja/src/main/data/booking/booking.repository.dart';
import 'package:bandeja/src/main/presentation/padels/pages/booking.page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/booking/repositories/i.booking.repository.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';

class PadelPageController extends GetxController {
  PadelPageController({required PadelModel padel}) {
    initPadel.value = padel;
    padelWrapper.value = WrapperDto<PadelModel>.loadedState(value: padel);
  }
  RxBool isBookmarked = false.obs;
  final repository = getIt<IPadelRepository>();
  Rxn<PadelScheduleModel> schedule = Rxn<PadelScheduleModel>();

  Rx<DateTime> date = Rx<DateTime>(DateTime.now());

  Rxn<PadelModel> initPadel = Rxn<PadelModel>();

  Rx<WrapperDto<PadelModel>> padelWrapper =
      Rx<WrapperDto<PadelModel>>(EmptyState());

  @override
  void onInit() {
    debounce(date, (_) => loadPadel(), time: const Duration(microseconds: 300));

    super.onInit();
  }

  void loadIsBookmark(int padelId) async {
    (await repository.isBookmark(padelId: padelId))
        ?.fold((_) {}, (r) => isBookmarked.value = r);
  }

  void loadPadel() async {
    padelWrapper.value = WrapperDto.loadingState();
    final result = await repository.findPadel(
        padelId: initPadel.value?.id ?? -1, date: date.value);
    if (result == null) {
      padelWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      padelWrapper.value = WrapperDto.errorState(failure: l);
    }, (r) async {
      isBookmarked.value = r.isBookmarked();
      loadIsBookmark(r.id);
      padelWrapper.value = WrapperDto.loadedState(value: r);
      await (getIt<IUserRepository>()).onAppVisit(padelId: r.id);
    });
  }

  void checkIfMyReservation(BuildContext context, int padelScheduleId) async {
    final result = await (getIt<IBookingRepository>())
        .checkIfMyReservation(padelScheduleId: padelScheduleId);

    if (result == null) {
      return;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) async {
      Get.to(BookingPage(padel: initPadel.value!, order: r));
    });
  }
}
