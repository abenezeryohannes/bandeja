import 'package:bandeja/src/owner/domain/padels/i.owner.padel.repository.dart';
import 'package:get/state_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';

class OwnerPadelsPageController extends GetxController {
  final repository = getIt<IOwnerPadelRepository>();

  var padels = Rx<WrapperDto<List<PadelModel>>>(EmptyState());

  static const pageSize = 25;

  final PagingController<int, PadelModel?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      getOwnerPadels(page: pageKey);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  getOwnerPadels({int? page}) async {
    padels.value = WrapperDto.loadingState();
    final result = await repository.getPadels(page: page, limit: pageSize);
    if (result == null) {
      padels.value = WrapperDto.errorState(failure: UnExpectedFailure());
      pagingController.error = UnExpectedFailure();
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
