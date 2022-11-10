import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:get/get.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../../main/domain/padels/repositories/i.padel.repository.dart';
import '../../../../owner/data/padels/dto/padel.dto.dart';
import '../../../../owner/domain/padels/i.owner.padel.repository.dart';

class AdminPadelPageController extends GetxController {
  AdminPadelPageController({required PadelModel padel}) {
    initPadel.value = padel;
    padelWrapper.value = WrapperDto<PadelModel>.loadedState(value: padel);
    approved.value = padel.approved;
  }
  RxBool approved = false.obs;
  RxBool loading = false.obs;

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
      approved.value = r.approved;
      loadIsBookmark(r.id);
      padelWrapper.value = WrapperDto.loadedState(value: r);
    });
  }

  void approve({required PadelModel padel}) async {
    loading.value = true;
    PadelDto dto = PadelDto.fromPadelModel(padel);
    dto.approved = !(dto.approved ?? false);
    dto.padelFeatureDto = [];
    dto.padelSchedules = [];
    final result =
        await getIt<IOwnerPadelRepository>().editPadel(padelDto: dto);
    if (result == null) {
      loading.value = false;
      return;
    }
    result.fold((l) {
      loading.value = false;

      AppSnackBar.failure(failure: l);
    }, (r) {
      loading.value = false;
      approved.value = !approved.value;

      AppSnackBar.success(
          message: 'Court ${r.approved ? 'Approved' : 'Not Approved'}');
    });
  }
}
