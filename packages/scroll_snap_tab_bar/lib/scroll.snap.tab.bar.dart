import 'package:flutter/material.dart';

class ScrollSnapTabBar extends StatefulWidget {
  const ScrollSnapTabBar({super.key, required this.items});
  final List<Widget> items;

  @override
  State<ScrollSnapTabBar> createState() => _ScrollSnapTabBarState();
}

class _ScrollSnapTabBarState extends State<ScrollSnapTabBar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ListView(
      scrollDirection: Axis.horizontal,
      children: widget.items,
    ));
  }
}
