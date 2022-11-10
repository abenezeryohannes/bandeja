import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:get/get.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
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
    }, (r) {
      isBookmarked.value = r.isBookmarked();
      loadIsBookmark(r.id);
      padelWrapper.value = WrapperDto.loadedState(value: r);
    });
  }
}
