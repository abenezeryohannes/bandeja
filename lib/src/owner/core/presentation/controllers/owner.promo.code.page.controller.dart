import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/promo.code.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/padels/i.owner.padel.repository.dart';

class OwnerPromoCodePageController extends GetxController {
  final repository = getIt<IOwnerPadelRepository>();

  Rx<WrapperDto<List<PromoCodeModel>>> orders =
      Rx<WrapperDto<List<PromoCodeModel>>>(WrapperDto.emptyState());

  static const pageSize = 25;

  final PagingController<int, PromoCodeModel?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      loadMyBooking(page: pageKey);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void loadMyBooking({int? page}) async {
    orders.value = LoadingState();
    final result = await repository.getPromoCodes(page: page, limit: pageSize);
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
