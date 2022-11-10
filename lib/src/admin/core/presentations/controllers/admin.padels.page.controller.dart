import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/padel/i.admin.padel.repository.dart';

class AdminPadelsPageController extends GetxController {
  final repository = getIt<IAdminPadelRepository>();
  RxnInt padelsCount = RxnInt();
  RxnBool enabled = RxnBool(true);

  Rx<WrapperDto<List<PadelModel>>> padels =
      Rx<WrapperDto<List<PadelModel>>>(WrapperDto.emptyState());

  static const pageSize = 25;
  RxnString search = RxnString();

  final PagingController<int, PadelModel?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    debounce(search, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));

    debounce(enabled, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));

    pagingController.addPageRequestListener((pageKey) {
      getPadels(page: pageKey);
    });
    getPadelsCount();
    super.onInit();
  }

  void getPadelsCount() async {
    final result = await repository.countAllPadels();
    if (result == null) {
      return;
    }
    result.fold((_) {}, (r) {
      padelsCount.value = r;
    });
  }

  getPadels({int? page}) async {
    padels.value = WrapperDto<List<PadelModel>>.loadingState();

    final result = await repository.getPadels(
        page: page, enabled: enabled.value, search: search.value);

    if (result == null) {
      padels.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        padels.value = WrapperDto.errorState(failure: l);
        pagingController.error = l;
      }, (r) {
        padels.value = WrapperDto<List<PadelModel>>.loadedState(value: r);
        if (r.length < pageSize) {
          pagingController.appendLastPage(r);
        } else {
          pagingController.appendPage(r, (page ?? 1) + 1);
        }
      });
    }
  }
}
