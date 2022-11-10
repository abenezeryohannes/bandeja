import 'package:bandeja/src/core/domain/authentication/repositories/i.user.repository.dart';
import 'package:bandeja/src/core/domain/notifications/entities/notification.dart';
import 'package:bandeja/src/owner/core/presentation/pages/owner.home.page.dart';
import 'package:bandeja/src/owner/core/presentation/pages/owner.padels.schedules.page.dart';
import 'package:bandeja/src/owner/core/presentation/pages/owner.profile.page.dart';
import 'package:bandeja/src/owner/core/presentation/pages/owner.promo.code.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/notifications/repositories/i.notification.repository.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../pages/owner.stat.page.dart';

class OwnerMainPageController extends GetxController
    with GetTickerProviderStateMixin {
  RxInt bottomNavIndex = 0.obs;
  List<int> stack = [];

  Rx<Widget> currentPage = Rx<Widget>(const OwnerHomePage());

  List<String> iconList = <String>[
    "assets/icons/home",
    "assets/icons/calendar_nav",
    "assets/icons/promo_code_nav",
    "assets/icons/account"
  ].obs;

  late AnimationController fabAnimationController;
  late AnimationController borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController hideBottomBarAnimationController;
  RxBool showFab = true.obs;
  @override
  void onInit() {
    loadUser();
    stack = [0];
    fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => borderRadiusAnimationController.forward(),
    );

    super.onInit();
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          hideBottomBarAnimationController.reverse();
          fabAnimationController.forward(from: 0);
          showFab.value = true;

          break;
        case ScrollDirection.reverse:
          hideBottomBarAnimationController.forward();
          fabAnimationController.reverse(from: 1);
          showFab.value = false;

          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  void switchFragment(int index) {
    bottomNavIndex.value = index;
    switch (index) {
      case 0:
        currentPage.value = const OwnerHomePage();
        break;
      case 1:
        currentPage.value = const OwnerPadelsSchedulePage();
        break;
      case 4:
        currentPage.value = const OwnerStatPage();
        break;
      case 2:
        currentPage.value = const OwnerPromoCodePage();
        break;
      case 3:
        currentPage.value = const OwnerProfilePage();
        break;
      default:
        currentPage.value = const OwnerHomePage();
    }
  }

  Rxn<UserModel> user = Rxn<UserModel>();

  void loadUser() async {
    final result = await getIt<IUserRepository>().loadUser();
    if (result == null) {
      return;
    }
    result.fold((l) {
      return;
    }, (r) {
      user.value = r;
      loadNotifications();
    });
  }

  void loadNotifications() async {
    final result =
        await getIt<INotificationRepository>().getUnSeenNotifications();
    if (result == null) {
      return;
    }
    result.fold((l) {
      return;
    }, (r) {
      for (var notification in r) {
        showSnackBar(notification);
      }
    });
  }

  showSnackBar(NotificationModel notification) {
    AppSnackBar.warning(
        title: notification.title,
        message: notification.desc,
        icon: Image.asset(
          'assets/icons/speaker.png',
          color: Colors.grey.shade800,
          width: 24,
          height: 24,
        ),
        position: SnackPosition.TOP);

    getIt<INotificationRepository>()
        .makeNotificationSeen(notificationId: notification.id);
  }
}
