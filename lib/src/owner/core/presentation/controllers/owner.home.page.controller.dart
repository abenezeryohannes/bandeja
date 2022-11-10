import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/padels/i.owner.padel.repository.dart';
import '../../../presentation/authentication/pages/owner.landing.page.dart';

class OwnerHomePageController extends GetxController {
  final repository = getIt<IOwnerPadelRepository>();

  Rx<WrapperDto<List<PadelOrderModel>>> orders =
      Rx<WrapperDto<List<PadelOrderModel>>>(WrapperDto.emptyState());

  static const pageSize = 25;
  RxnString search = RxnString();
  Rxn<DateTime> startTime = Rxn<DateTime>();
  Rxn<DateTime> endTime = Rxn<DateTime>();

  final PagingController<int, PadelOrderModel?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    debounce(search, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));

    debounce(endTime, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));

    pagingController.addPageRequestListener((pageKey) {
      loadMyBooking(page: pageKey);
    });
    super.onInit();
  }

  void loadMyBooking({int? page}) async {
    orders.value = LoadingState();
    final result = await repository.getBookings(
        page: page,
        limit: pageSize,
        search: search.value,
        startTime: (startTime.value == null)
            ? null
            : DateFormat('yyyy-MM-dd').format(startTime.value!),
        endTime: (endTime.value == null)
            ? null
            : DateFormat('yyyy-MM-dd').format(endTime.value!));
    if (result == null) {
      orders.value = ErrorState(failure: UnExpectedFailure());
      pagingController.error = UnExpectedFailure();
      return;
    }
    result.fold((l) {
      orders.value = ErrorState(failure: l);
      pagingController.error = l;
    }, (r) {
      orders.value = LoadedState(value: r);
      if (r.length < pageSize) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, (page ?? 1) + 1);
      }
    });
  }
}
