import 'package:bandeja/src/admin/data/notification/dto/notification.dto.dart';
import 'package:bandeja/src/admin/presentation/notification/pages/admin.notification.sent.page.dart';
import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../domain/notification/i.admin.notification.repository.dart';
import '../../../domain/users/i.admin.users.repository.dart';

class NotificationBottomSheetController extends GetxController {
  final repository = getIt<IAdminUsersRepository>();
  final notificationRepository = getIt<IAdminNotificationRepository>();
  Rx<NotificationDto> notificationDto =
      Rx<NotificationDto>(NotificationDto.empty());
  final formKey = GlobalKey<FormState>();
  RxBool loading = false.obs;

  Rx<WrapperDto<List<UserModel>>> usersDto =
      Rx<WrapperDto<List<UserModel>>>(WrapperDto.emptyState());

  Rx<List<UserModel>> users = Rx<List<UserModel>>([]);

  Rxn<UserModel> user = Rxn<UserModel>();

  static const pageSize = 25;
  RxnString search = RxnString();

  final PagingController<int, PadelModel?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    debounce(search, (_) => pagingController.refresh(),
        time: const Duration(microseconds: 500));
    super.onInit();
  }

  getUsers() async {
    usersDto.value = WrapperDto<List<UserModel>>.loadingState();

    final result = await repository.getUsers(search: search.value);

    if (result == null) {
      usersDto.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => usersDto.value = WrapperDto.errorState(failure: l),
          (r) {
        users.value = r;
        usersDto.value = WrapperDto<List<UserModel>>.loadedState(value: r);
      });
    }
  }

  Future<List<UserModel>?> searchUsers(String x) async {
    final result = await repository.getUsers(search: x);
    return (result?.isRight() ?? false) ? result?.getOrElse(() => []) : [];
  }

  sendNotification({int? page}) async {
    if (!validate()) return;
    loading.value = true;
    notificationDto.value.userId = (user.value?.id);
    final result = await notificationRepository.send(
        notificationDto: notificationDto.value);
    loading.value = false;
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        AppSnackBar.failure(failure: l);
      }, (r) {
        AppSnackBar.success(message: 'Message Sent!!');
        Get.to(() => const AdminNotificationSentPage());
      });
    }
  }

  bool validate() {
    if ((formKey.currentState != null && formKey.currentState!.validate())) {
      return true;
    }
    return false;
  }
}
