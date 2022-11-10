import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/owner/domain/padels/i.owner.padel.repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/domain/padels/entities/promo.code.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../data/padels/dto/promo.code.dto.dart';

class EditPromoCodeBottomSheetController extends GetxController {
  EditPromoCodeBottomSheetController({required PromoCodeModel promo}) {
    this.promo.value = PromoCodeDto.fromModel(promo);
  }
  final repository = getIt<IOwnerPadelRepository>();
  final formKey = GlobalKey<FormState>();

  var padels = Rx<WrapperDto<List<PadelModel>>>(EmptyState());
  Rxn<PadelModel> padel = Rxn<PadelModel>();

  RxBool loading = false.obs;

  Rx<PromoCodeDto> promo =
      Rx<PromoCodeDto>(PromoCodeDto.EmptyPromoCodeDto(maxBooking: 20));

  @override
  void onInit() {
    loadPadels();
    super.onInit();
  }

  loadPadels({int? page}) async {
    padels.value = WrapperDto.loadingState();
    final result = await repository.getPadels(page: page, limit: 1000);
    if (result == null) {
      padels.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        padels.value = WrapperDto.errorState(failure: l);
      }, (r) {
        padels.value = WrapperDto<List<PadelModel>>.loadedState(value: r);
        try {
          if (promo.value.padelId != null) {
            padel.value =
                r.firstWhere((element) => element.id == promo.value.padelId);
          }
        } catch (e) {}
      });
    }
  }

  addPromo() async {
    if (!validate()) return;
    loading.value = true;
    promo.value.padelId = padel.value?.id;
    final result = await repository.editPromoCode(promo: promo.value);
    loading.value = false;
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        AppSnackBar.failure(failure: l);
      }, (r) {
        Get.back(result: r);
        AppSnackBar.success(message: 'Promo code has been updated!');
      });
    }
  }

  bool validate() {
    if ((formKey.currentState != null && formKey.currentState!.validate())) {
      return true;
    }
    return false;
  }
}
