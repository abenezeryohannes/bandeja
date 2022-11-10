import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:get/get.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../../owner/data/padels/dto/padel.dto.dart';
import '../../../../owner/domain/padels/i.owner.padel.repository.dart';

class ApprovePadelBottomSheetController extends GetxController {
  final padelRepository = getIt<IOwnerPadelRepository>();
  RxBool loading = false.obs;

  void save(PadelModel padel, bool approved) async {
    loading.value = true;
    final padelDto = PadelDto.fromPadelModel(padel);
    padelDto.approved = approved;
    final result = await padelRepository.editPadel(padelDto: padelDto);
    loading.value = false;
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) {
      Get.back<String?>(result: 'saved');
      if (padelDto.approved ?? false) {
        AppSnackBar.success(message: 'Court Dis-Approved!');
      } else {
        AppSnackBar.success(message: 'Court Approved!');
      }
    });
  }
}
