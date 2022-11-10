import 'package:bandeja/src/admin/core/presentations/pages/admin.padels.page.dart';
import 'package:bandeja/src/admin/core/presentations/pages/admin.profile.page.dart';
import 'package:bandeja/src/admin/core/presentations/pages/admin.stats.page.dart';
import 'package:bandeja/src/admin/core/presentations/pages/admin.approval.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../pages/admin.home.page.dart';

class AdminMainPageController extends GetxController
    with GetTickerProviderStateMixin {
  RxInt bottomNavIndex = 0.obs;
  List<int> stack = [];

  Rx<Widget> currentPage = Rx<Widget>(const AdminHomePage());

  List<String> iconList = <String>[
    "assets/icons/home",
    "assets/icons/briefcase",
    "assets/icons/tennis-ball",
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
        currentPage.value = const AdminHomePage();
        break;
      case 1:
        currentPage.value = const AdminApprovalPage();
        break;
      case 4:
        currentPage.value = const AdminStatsPage();
        break;
      case 2:
        currentPage.value = const AdminPadelsPage();
        break;
      case 3:
        currentPage.value = const AdminProfilePage();
        break;
      default:
        currentPage.value = const AdminHomePage();
    }
  }
}
