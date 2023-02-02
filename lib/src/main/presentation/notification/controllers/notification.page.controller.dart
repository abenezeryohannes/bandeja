import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/notifications/entities/notification.dart';
import '../../../../core/domain/notifications/repositories/i.notification.repository.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';

class NotificationPageController extends GetxController {
  final notificationRepository = getIt<INotificationRepository>();

  Rx<WrapperDto<List<NotificationModel>>> notificationWrapper =
      Rx<WrapperDto<List<NotificationModel>>>(EmptyState());

  static const pageSize = 25;

  final PagingController<int, NotificationModel?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      loadNotifications(page: pageKey);
    });
    loadNotifications();
    super.onInit();
  }

  void loadNotifications({int? page}) async {
    notificationWrapper.value = WrapperDto.loadingState();
    final result = await notificationRepository.getNotifications(page: page);
    if (result == null) {
      notificationWrapper.value =
          WrapperDto.errorState(failure: UnExpectedFailure());
      pagingController.error = UnExpectedFailure();
    }
    result?.fold((l) {
      notificationWrapper.value = WrapperDto.errorState(failure: l);
      pagingController.error = UnExpectedFailure();
    }, (r) async {
      if (r.isNotEmpty) {
        notificationWrapper.value = WrapperDto.loadedState(value: r);
      } else {
        notificationWrapper.value = WrapperDto.emptyState();
      }

      if (r.length < pageSize) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, (page ?? 1) + 1);
      }
    });
  }

  void clearNotifications() async {
    notificationWrapper.value = WrapperDto.loadingState();
    final result = await notificationRepository.clearNotifications();
    if (result == null) {
      notificationWrapper.value =
          WrapperDto.errorState(failure: UnExpectedFailure());
      pagingController.error = UnExpectedFailure();
    }
    result?.fold((l) {
      notificationWrapper.value = WrapperDto.errorState(failure: l);
      pagingController.error = UnExpectedFailure();
    }, (r) {
      if (r.isNotEmpty) {
        notificationWrapper.value = WrapperDto.loadedState(value: r);
      } else {
        notificationWrapper.value = WrapperDto.emptyState();
      }
      pagingController.refresh();
    });
  }
}
