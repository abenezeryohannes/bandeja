import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/booking/i.admin.booking.repository.dart';
import '../../../domain/padel/i.admin.padel.repository.dart';

class AdminHomePageController extends GetxController {
  final repository = getIt<IAdminBookingRepository>();
  final padelRepository = getIt<IAdminPadelRepository>();
  Rxn<PadelModel> padel = Rxn<PadelModel>();

  Rx<WrapperDto<List<PadelOrderModel>>> orders =
      Rx<WrapperDto<List<PadelOrderModel>>>(WrapperDto.emptyState());

  Rx<WrapperDto<List<PadelModel>>> padels =
      Rx<WrapperDto<List<PadelModel>>>(WrapperDto.emptyState());

  static const pageSize = 25;
  RxnString search = RxnString();

  final PagingController<int, PadelOrderModel?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    debounce(search, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));

    debounce(padel, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));

    pagingController.addPageRequestListener((pageKey) {
      loadMyBooking(page: pageKey);
    });
    super.onInit();
  }

  void loadMyBooking({int? page}) async {
    orders.value = LoadingState();
    final result = await repository.getBookings(
        page: page, limit: pageSize, search: search.value, padel: padel.value);
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

  getPadelItems({int? page}) async {
    padels.value = WrapperDto<List<PadelModel>>.loadingState();

    final result =
        await padelRepository.getPadels(page: 1, limit: 100, enabled: true);

    if (result == null) {
      padels.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => padels.value = WrapperDto.errorState(failure: l), (r) {
        r.insert(
            0,
            PadelModel(
                userId: -1,
                durationId: -1,
                startTime: DateTime.now(),
                endTime: DateTime.now(),
                name: 'All Courts'));
        padels.value = WrapperDto<List<PadelModel>>.loadedState(value: r);
      });
    }
  }
}
