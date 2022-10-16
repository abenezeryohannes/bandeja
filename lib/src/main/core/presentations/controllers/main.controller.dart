import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../pages/boookmark.page.dart';
import '../pages/home.page.dart';
import '../pages/posts.page.dart';
import '../pages/profile.page.dart';

class MainController extends GetxController with GetTickerProviderStateMixin {
  RxInt bottomNavIndex = 0.obs;
  List<int> stack = [];

  List<String> iconList = <String>[
    "assets/icons/home",
    "assets/icons/bookmark",
    "assets/icons/marketing",
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

  Widget switchFragment(int index) {
    switch (index) {
      case 0:
        return const HomePageMain();
      case 1:
        return const BookmarkPage();
      case 2:
        return const PostsPage();
      case 3:
        return const ProfilePage();
      default:
        return const HomePageMain();
    }
  }
}
