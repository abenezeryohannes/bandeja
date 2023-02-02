import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bandeja/src/owner/core/presentation/controllers/owner.main.page.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/app.snack.bar.dart';

class OwnerMainPage extends StatefulWidget {
  const OwnerMainPage({Key? key}) : super(key: key);

  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  final OwnerMainPageController c = Get.put(OwnerMainPageController());

  void test() async {
    DateTime dateTime = DateTime.now();
    print('time zone ' + dateTime.timeZoneName);
  }

  @override
  Widget build(BuildContext context) {
    test();
    return WillPopScope(
      onWillPop: () async {
        if (c.stack.isEmpty) {
          return true;
        } else {
          c.bottomNavIndex.value = c.stack[c.stack.length - 1];
          c.stack.removeLast();
          return false;
        }
      },
      child: Scaffold(
          body: SafeArea(
            child: NotificationListener<ScrollNotification>(
              onNotification: c.onScrollNotification,
              child: Obx(() {
                return c.currentPage.value;
              }),
            ),
          ),
          floatingActionButton: Obx(() =>
              c.showFab.value && MediaQuery.of(context).viewInsets.bottom == 0
                  ? FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      child: Image.asset('assets/icons/stats_nav.png',
                          width: 28,
                          height: 28,
                          color: Theme.of(context).cardColor),
                      onPressed: () {
                        c.switchFragment(4);
                      },
                    )
                  : const SizedBox()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar.builder(
                itemCount: 4,
                tabBuilder: (int index, bool isActive) {
                  final color = isActive
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          c.iconList[index] +
                              ((index == c.bottomNavIndex.value)
                                  ? "_active.png"
                                  : ".png"),
                          width: 24,
                          height: 24,
                          color: color,
                        ),
                      ),
                    ],
                  );
                },
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                activeIndex: c.bottomNavIndex.value,
                splashColor: Theme.of(context).colorScheme.secondary,
                notchAndCornersAnimation: c.borderRadiusAnimation,
                splashSpeedInMilliseconds: 300,
                notchSmoothness: NotchSmoothness.defaultEdge,
                gapLocation: GapLocation.center,
                onTap: (index) {
                  c.switchFragment(index);
                  if (!c.stack.contains(index)) {
                    c.stack.add(index);
                  }
                },
                hideAnimationController: c.hideBottomBarAnimationController,
                shadow: BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 12,
                  spreadRadius: 0.5,
                  color: Theme.of(context).dividerColor,
                ),
              ))),
    );
  }
}
