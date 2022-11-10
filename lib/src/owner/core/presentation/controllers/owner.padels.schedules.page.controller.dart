import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/util.dart';
import '../../../domain/padels/i.owner.padel.repository.dart';

class OwnerPadelsSchedulePageController extends GetxController {
  static const pageSize = 25;
  RxBool indoor = true.obs;
  late List<DateTime> times;
  final padelRepository = getIt<IOwnerPadelRepository>();
  final userRepository = getIt<IUserRepository>();
  Rx<UserModel> user = Rx<UserModel>(UserModel(fullName: 'Anonymous Account'));
  Rx<DateTime> pickeddate = Rx<DateTime>(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  var filterOwners = Rx<WrapperDto<List<PadelModel>>>(EmptyState());
  final PagingController<int, PadelModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    times = Util.dates(pickeddate.value);
    debounce(pickeddate, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));
    pagingController.addPageRequestListener((pageKey) {
      filter(page: pageKey);
    });
    loadUser();
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  filter({int? page}) async {
    filterOwners.value = WrapperDto<List<PadelModel>>.loadingState();
    final result = await padelRepository.getPadels(
        page: page,
        startTime: DateFormat('yyyy-MM-dd').format(pickeddate.value),
        endTime: DateFormat('yyyy-MM-dd').format(pickeddate.value),
        limit: pageSize);
    if (result == null) {
      filterOwners.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        filterOwners.value = WrapperDto.errorState(failure: l);
        pagingController.error = l;
      }, (r) {
        filterOwners.value = WrapperDto<List<PadelModel>>.loadedState(value: r);
        if (r.length < pageSize) {
          pagingController.appendLastPage(r);
        } else {
          pagingController.appendPage(r, (page ?? 1) + 1);
        }
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
