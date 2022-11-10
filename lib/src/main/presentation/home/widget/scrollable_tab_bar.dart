import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:snappy_list_view/snappy_list_view.dart';

import '../../../../core/network/api.dart';

class ScrollableTab {
  final String? icon;
  final String? label;

  ScrollableTab(this.icon, this.label);
}

class ScrollableTabBar extends StatefulWidget {
  const ScrollableTabBar(
    this.tabs, {
    required this.activeColor,
    required this.inactiveColor,
    this.controller,
    this.height = 100,
    this.iconSize = 30,
    this.tabSpacing = 10,
    this.labelStyle,
    super.key,
    required this.onSelected,
  });

  final List<ScrollableTab> tabs;
  final Color activeColor;
  final Color inactiveColor;
  final PageController? controller;
  final double height;
  final double iconSize;
  final double tabSpacing;
  final TextStyle? labelStyle;
  final Function(int) onSelected;

  @override
  State<ScrollableTabBar> createState() => _ScrollableTabBarState();
}

class _ScrollableTabBarState extends State<ScrollableTabBar> {
  var index = 0;

  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.25,
      child: SizedBox(
        height: widget.height,
        child: MediaQuery.removePadding(
          context: context,
          removeLeft: true,
          child: SnappyListView(
            controller: controller,
            itemCount: widget.tabs.length,
            snapAlignment: SnapAlignment.moveAcross(),
            visualisation: ListVisualisation.normal(),
            snapOnItemAlignment: SnapAlignment.moveAcross(),
            scrollDirection: Axis.horizontal,
            onPageChanged: (final index, final pageSize) {
              setState(() => this.index = index);
              if (widget.tabs[index].label == null) return;
              widget.onSelected(index);
            },
            physics: const RangeMaintainingScrollPhysics(),
            overscrollPhysics:
                const PageOverscrollPhysics(velocityPerOverscroll: 750),
            itemSnapping: true,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }

  Widget itemBuilder(final BuildContext context, final int index) {
    final tab = widget.tabs.elementAt(index);
    final isActive = this.index == index;
    return InkWell(
      onTap: () => onTabTap(index),
      child: Container(
        margin: EdgeInsets.only(
            left: (index == 0) ? 0 : 0,
            right: (index == widget.tabs.length - 1) ? 0 : 0),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? widget.activeColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: CustomShimmer(
          show: tab.label == null,
          child: Tab(
            icon: Image.network(
              Api.getMedia(tab.icon ?? 'img/placeholder.jpg'),
              width: widget.iconSize,
              height: widget.iconSize,
              color: isActive ? widget.activeColor : widget.inactiveColor,
            ),
            child: Text(
              tab.label ?? '..............',
              softWrap: false,
              overflow: TextOverflow.fade,
              style: (widget.labelStyle ?? DefaultTextStyle.of(context).style)
                  .copyWith(
                      backgroundColor: (tab.label == null) ? Colors.grey : null,
                      color:
                          isActive ? widget.activeColor : widget.inactiveColor),
            ),
          ),
        ),
      ),
    );
  }

  void onTabTap(final int index) => controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
}
