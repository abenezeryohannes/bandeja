import 'package:bandeja/src/core/data/authentication/dto/user.dto.dart';
import 'package:bandeja/src/core/domain/authentication/entities/system.variable.dart';
import 'package:bandeja/src/core/domain/notifications/entities/notification.dart';
import 'package:bandeja/src/core/utils/util.dart';
import 'package:bandeja/src/flavors.dart';
import 'package:bandeja/src/main/presentation/booking/widgets/recent.bookings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../admin/presentation/authentication/pages/admin.landing.page.dart';
import '../../../../core/data/authentication/repositories/auth.repository.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/domain/notifications/repositories/i.notification.repository.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../../owner/presentation/authentication/pages/owner.landing.page.dart';
import '../../../domain/booking/repositories/i.booking.repository.dart';
import '../../../presentation/authentication/page/user.landing.page.dart';

class ProfileController extends GetxController {
  RxnString avatar = RxnString();

  RxnString contactUsLink = RxnString();

  final userRepository = getIt<IUserRepository>();

  final bookingRepository = getIt<IBookingRepository>();

  final notificationRepository = getIt<INotificationRepository>();

  Rx<UserDto> userDto = Rx<UserDto>(UserDto(fullName: '', role: FF.env.name));

  Rx<WrapperDto<UserModel>> userWrapper =
      Rx<WrapperDto<UserModel>>(EmptyState());

  Rx<WrapperDto<SystemVariableModel>> sysWrapper =
      Rx<WrapperDto<SystemVariableModel>>(EmptyState());

  Rx<WrapperDto<List<NotificationModel>>> notificationWrapper =
      Rx<WrapperDto<List<NotificationModel>>>(EmptyState());

  Rx<WrapperDto<List<PadelOrderModel>>> recentBookingWrapper =
      Rx<WrapperDto<List<PadelOrderModel>>>(EmptyState());

  Rx<UserModel> user = Rx<UserModel>(UserModel(fullName: '-'));

  RxBool loading = false.obs;
  RxInt notificationCount = 0.obs;

  @override
  void onInit() {
    loadUser();
    loadBookings();
    loadSys(false);
    loadNotifications();
    loadNotificationCount();
    super.onInit();
  }

  void loadUser() async {
    loading.value = true;
    final result = await userRepository.loadUser();
    if (result == null) {
      loading.value = false;
      userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      userWrapper.value = WrapperDto.errorState(failure: l);
      loading.value = false;
    }, (r) {
      user.value = r;
      userDto.value = r.getDTO();
      userWrapper.value = WrapperDto.loadedState(value: r);
      loading.value = false;
    });
  }

  void loadBookings() async {
    recentBookingWrapper.value = WrapperDto.loadingState();
    final result = await bookingRepository.myBooking(limit: 3);
    if (result == null) {
      recentBookingWrapper.value =
          WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      recentBookingWrapper.value = WrapperDto.errorState(failure: l);
    }, (r) {
      recentBookingWrapper.value = WrapperDto.loadedState(value: r);
    });
  }

  void loadNotifications({int? page}) async {
    notificationWrapper.value = WrapperDto.loadingState();
    final result = await notificationRepository.getNotifications(page: page);
    if (result == null) {
      notificationWrapper.value =
          WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      notificationWrapper.value = WrapperDto.errorState(failure: l);
    }, (r) {
      notificationWrapper.value = WrapperDto.loadedState(value: r);
    });
  }

  void loadNotificationCount() async {
    (await notificationRepository.countUnseenNotifications())
        ?.fold((_) {}, (r) => notificationCount.value = r);
  }

  void loadSys(bool open) async {
    (await userRepository.getSystemVariable(key: 'contact_us'))?.fold((_) {},
        (r) {
      contactUsLink.value = r;
      if (open && r != null) Util.openwhatsapp((r));
    });
  }

  void saveUser() async {
    loading.value = true;
    userDto.value.localImage = avatar.value;
    final result = await userRepository.editUser(user: userDto.value);
    if (result == null) {
      loading.value = false;
      if (userWrapper.value.runtimeType ==
          LoadedState(value: null).runtimeType) {
        Get.snackbar('Error', UnExpectedFailure().message ?? '',
            colorText: Colors.white, backgroundColor: Colors.red);
      } else {
        userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
      }
      userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      if (userWrapper.value.runtimeType ==
          WrapperDto<UserModel>.loadedState(value: UserModel(fullName: ''))
              .runtimeType) {
        Get.snackbar('Error', l.message ?? '',
            colorText: Colors.white, backgroundColor: Colors.red);
      } else {
        userWrapper.value = WrapperDto.errorState(failure: l);
      }
      loading.value = false;
    }, (r) {
      userDto.value =
          UserDto(fullName: r.fullName, role: r.role, avatar: r.avatar);
      userWrapper.value = WrapperDto.loadedState(value: r);
      loading.value = false;
    });
  }

  void logout() async {
    if (user.value.id <= 0) return;
    loading.value = true;
    final pre = await AuthRepository().signOut();
    if (pre == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    pre.fold((l) => AppSnackBar.failure(failure: l), (r) async {
      final result = await userRepository.logoutUser();
      if (result == null) {
        loading.value = false;
        userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
      }
      result?.fold((l) {
        userWrapper.value = WrapperDto.errorState(failure: l);
        loading.value = false;
      }, (r) {
        loading.value = false;
        switch (FF.appFlavor) {
          case Flavor.admin:
            Get.offAll(const AdminLandingPage());
            break;
          case Flavor.owner:
            Get.offAll(const OwnerLandingPage());
            break;
          default:
            Get.offAll(const UserLandingPage());
            break;
        }
      });
    });
  }
}
