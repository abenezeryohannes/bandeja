import 'package:feekpadel/src/core/dto/wrapper.dto.dart';
import 'package:get/state_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/padels/entities/padel.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';

class BookmarkController extends GetxController {
  final repository = getIt<IPadelRepository>();

  var bookmarks = Rx<WrapperDto<List<PadelModel>>>(EmptyState());

  static const pageSize = 25;

  final PagingController<int, PadelModel> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      getBookmarks(page: pageKey);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  getBookmarks({int? page}) async {
    bookmarks.value = WrapperDto.loadingState();
    final result = await repository.getBookmarks(page: page, limit: pageSize);
    if (result == null) {
      bookmarks.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        bookmarks.value = WrapperDto.errorState(failure: l);
        pagingController.error = l;
      }, (r) {
        bookmarks.value = WrapperDto<List<PadelModel>>.loadedState(value: r);
        if (r.length < pageSize) {
          pagingController.appendLastPage(r);
        } else {
          pagingController.appendPage(r, (page ?? 0) + 1);
        }
      });
    }
  }
}
