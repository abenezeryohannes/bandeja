import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:bandeja/src/main/domain/padels/repositories/i.padel.repository.dart';
import 'package:get/get.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../domain/booking/repositories/i.booking.repository.dart';
import '../../padels/pages/booking.page.dart';

class CheckoutPageController extends GetxController {
  CheckoutPageController(this.padel, this.schedule);

  RxBool loading = false.obs;
  RxBool promoCodeLoading = false.obs;
  RxnString promo = RxnString();
  final PadelModel padel;
  final PadelScheduleModel schedule;
  Rxn<PromoCodeModel> promoCode = Rxn<PromoCodeModel>();
  Rxn<PadelOrderModel> padelOrder = Rxn<PadelOrderModel>();
  Rx<WrapperDto<PromoCodeModel>> promoCodeWrapper =
      Rx<WrapperDto<PromoCodeModel>>(EmptyState());
  Rx<WrapperDto<PadelOrderModel>> padelOrderWrapper =
      Rx<WrapperDto<PadelOrderModel>>(EmptyState());
  Rx<PadelOrderDto> padelOrderDto =
      Rx<PadelOrderDto>(PadelOrderDto.empty(padelId: -1, padelScheduleId: -1));
  final padelRepository = getIt<IPadelRepository>();
  final bookingRepository = getIt<IBookingRepository>();

  @override
  void onInit() {
    loading.value = false;
    promoCodeLoading.value = false;

    super.onInit();
  }

  void checkForPromoValidity(String? promo) async {
    if (promo == null) return;
    promoCodeLoading.value = true;
    promoCodeWrapper.value = LoadingState();
    final result =
        await padelRepository.checkPromo(promo: promo, padelId: padel.id);
    if (result == null) {
      promoCodeLoading.value = false;
      promoCodeWrapper.value = ErrorState(failure: UnExpectedFailure());
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      promoCodeLoading.value = false;
      promoCodeWrapper.value = ErrorState(failure: l);
      AppSnackBar.failure(failure: l);
    }, (r) {
      promoCode.value = r;
      promoCodeWrapper.value = LoadedState(value: r);
      padelOrderDto.value.promoCode = r.code;
      padelOrderDto.value.promoCodeId = r.id;
    });
  }

  void book() async {
    loading.value = true;
    promoCodeWrapper.value = LoadingState();
    if (promoCode.value != null) {
      padelOrderDto.value.promoCode = promoCode.value?.code;
      padelOrderDto.value.promoCodeId = promoCode.value?.id;
    }
    padelOrderDto.value.padelId = padel.id;
    padelOrderDto.value.padelScheduleId = schedule.id;
    final result = await bookingRepository.book(order: padelOrderDto.value);
    if (result == null) {
      loading.value = false;
      padelOrderWrapper.value = ErrorState(failure: UnExpectedFailure());
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      loading.value = false;
      promoCodeWrapper.value = ErrorState(failure: l);
      AppSnackBar.failure(failure: l);
    }, (r) {
      padelOrder.value = r;
      padelOrderWrapper.value = LoadedState(value: r);
      Get.off(BookingPage(
        padel: padel,
        order: r,
      ));
    });
  }
}
