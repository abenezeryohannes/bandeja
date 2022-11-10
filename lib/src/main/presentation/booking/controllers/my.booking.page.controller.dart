import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../domain/booking/repositories/i.booking.repository.dart';

class MyBookingPageController extends GetxController {
  final repository = getIt<IBookingRepository>();

  Rx<WrapperDto<List<PadelOrderModel>>> orders =
      Rx<WrapperDto<List<PadelOrderModel>>>(WrapperDto.emptyState());

  static const pageSize = 25;

  final PagingController<int, PadelOrderModel?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      loadMyBooking(page: pageKey);
    });
    super.onInit();
  }

  void loadMyBooking({int? page}) async {
    orders.value = LoadingState();
    final result = await repository.myBooking(page: page, limit: pageSize);
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
