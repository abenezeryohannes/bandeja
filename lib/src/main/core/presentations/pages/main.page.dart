import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main.controller.dart';
import 'search.page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
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
                return c.switchFragment(c.bottomNavIndex.value);
              }),
            ),
          ),
          floatingActionButton: Obx(() => c.showFab.value
              ? FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  child: Icon(CupertinoIcons.search,
                      size: 28, color: Theme.of(context).cardColor),
                  onPressed: () {
                    c.fabAnimationController.reset();
                    c.borderRadiusAnimationController.reset();
                    c.borderRadiusAnimationController.forward();
                    c.fabAnimationController.forward();
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => const SearchPage(),
                      ),
                    );
                  },
                )
              : const SizedBox()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar.builder(
                itemCount: 4,
                tabBuilder: (int index, bool isActive) {
                  final color = isActive ? Colors.blueAccent : Colors.grey;
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
                  c.bottomNavIndex.value = index;
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
