import 'package:get/get.dart';

import '../../../../core/domain/padels/entities/padel.dart';

class PadelPageController extends GetxController {
  PadelPageController({required this.initPadel});
  Rx<DateTime> date = Rx<DateTime>(DateTime.now());
  final PadelModel initPadel;
  late Rx<PadelModel> padel;
  @override
  void onInit() {
    padel = Rx<PadelModel>(initPadel);

    debounce(date, (_) {
      loadSchedule();
    }, time: const Duration(seconds: 1));

    super.onInit();
  }

  loadSchedule() async {
    //loading the padel from web
  }
}
