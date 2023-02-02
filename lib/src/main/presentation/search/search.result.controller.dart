import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:bandeja/src/main/domain/core/entities/address.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../main/injection/injector.dart';
import '../../../core/domain/authentication/entities/user.dart';
import '../../../core/domain/padels/entities/padel.group.dart';
import '../../../core/dto/wrapper.dto.dart';
import '../../../core/error/failure.dart';
import '../../domain/padels/repositories/i.padel.repository.dart';

class SearchResultController extends GetxController {
  SearchResultController(
      {required this.address,
      required this.duration,
      required this.padelGroup,
      required this.date});

  static const pageSize = 25;
  RxBool indoor = true.obs;
  RxInt pickedTimeIndex = 0.obs;
  final padelRepository = getIt<IPadelRepository>();
  final DateTime date;
  Rx<DateTime> pickeddate = Rx<DateTime>(DateTime.now());
  Rxn<DateTime> pickedTime = Rxn<DateTime>();
  final AddressModel? address;
  final DurationModel? duration;
  final PadelGroupModel? padelGroup;
  var filterOwners = Rx<WrapperDto<List<UserModel>>>(EmptyState());

  final PagingController<int, UserModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pickeddate.value = date;
    pickedTime.value = null;
    debounce(indoor, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));
    debounce(pickeddate, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));
    debounce(pickedTime, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));
    pagingController.addPageRequestListener((pageKey) {
      filter(page: pageKey);
    });
    super.onInit();
  }

  filter({int? page}) async {
    filterOwners.value = WrapperDto<List<UserModel>>.loadingState();
    String date = pickedTime.value != null
        ? pickedTime.value!.subtract(Duration(hours: 3)).toIso8601String()
        : DateFormat('yyyy-MM-dd').format(pickeddate.value);
    final result = await padelRepository.getFilterPadels(
        page: page,
        address: address,
        duration: (duration?.minute ?? 0) > 0 && ((duration?.id ?? 0) > 0)
            ? duration
            : null,
        padelGroup: padelGroup,
        date: date,
        limit: pageSize,
        indoor: indoor.value);
    if (result == null) {
      filterOwners.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        filterOwners.value = WrapperDto.errorState(failure: l);
        pagingController.error = l;
      }, (r) {
        filterOwners.value = WrapperDto<List<UserModel>>.loadedState(value: r);
        if (r.length < pageSize) {
          pagingController.appendLastPage(r);
        } else {
          pagingController.appendPage(r, (page ?? 1) + 1);
        }
      });
    }
  }
}
