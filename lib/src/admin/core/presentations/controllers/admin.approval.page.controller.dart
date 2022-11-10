import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../owner/data/padels/dto/padel.dto.dart';
import '../../../../owner/domain/padels/i.owner.padel.repository.dart';
import '../../../domain/padel/i.admin.padel.repository.dart';

class AdminApprovalPageController extends GetxController {
  final repository = getIt<IAdminPadelRepository>();
  RxnInt padelsCount = RxnInt();
  RxnBool approved = RxnBool(false);

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

    debounce(approved, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));

    pagingController.addPageRequestListener((pageKey) {
      getPadels(page: pageKey);
    });
    super.onInit();
  }

  void approve({required PadelModel padel}) async {
    PadelDto dto = PadelDto.fromPadelModel(padel);
    dto.approved = !(dto.approved ?? false);
    dto.padelFeatureDto = [];
    dto.padelSchedules = [];
    final result =
        await getIt<IOwnerPadelRepository>().editPadel(padelDto: dto);
    if (result == null) {
      return;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) {
      AppSnackBar.success(
          message: 'Court ${r.approved ? 'Approved' : 'Not Approved'}');
    });
  }

  getPadels({int? page}) async {
    padels.value = WrapperDto<List<PadelModel>>.loadingState();

    final result = await repository.getPadelsForApproval(
        page: page, approved: approved.value);

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
