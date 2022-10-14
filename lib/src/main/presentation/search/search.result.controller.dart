import 'package:feekpadel/src/main/domain/core/entities/address.dart';
import 'package:feekpadel/src/main/domain/padels/entities/padel.group.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../main/injection/injector.dart';
import '../../../core/dto/wrapper.dto.dart';
import '../../../core/error/failure.dart';
import '../../domain/authentication/entities/user.dart';
import '../../domain/padels/repositories/i.padel.repository.dart';

class SearchResultController extends GetxController {
  SearchResultController(
      {required this.address, required this.padelGroup, required this.date});

  static const pageSize = 25;
  RxBool indoor = true.obs;
  final padelRepository = getIt<IPadelRepository>();
  final DateTime date;
  Rx<DateTime> pickeddate = Rx<DateTime>(DateTime.now());
  Rxn<DateTime> pickedTime = Rxn<DateTime>();
  final AddressModel? address;
  final PadelGroupModel? padelGroup;
  var filterOwners = Rx<WrapperDto<List<UserModel>>>(EmptyState());

  final PagingController<int, UserModel> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    pickeddate.value = date;
    pickedTime.value = null;
    debounce(indoor, (_) => pagingController.refresh(),
        time: const Duration(seconds: 1));
    debounce(pickeddate, (_) => pagingController.refresh(),
        time: const Duration(seconds: 1));
    filter();
    pagingController.addPageRequestListener((pageKey) {
      filter(page: pageKey);
    });
    super.onInit();
  }

  filter({int? page}) async {
    filterOwners.value = WrapperDto<List<UserModel>>.loadingState();
    final result = await padelRepository.getFilterPadels(
        page: page,
        address: address,
        padelGroup: padelGroup,
        date: pickedTime.value != null
            ? pickedTime.value!.toIso8601String()
            : DateFormat('yyyy-MM-dd').format(pickeddate.value),
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
          pagingController.appendPage(r, (page ?? 0) + 1);
        }
      });
    }
  }
}
