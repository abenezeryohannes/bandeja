import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'classes/indicator.painter.dart';
import './tab.style.dart';
import 'classes/tab.label.bar.dart';
import 'dart:math' as math;

const double _kTabHeight = 46.0;

class ScrollSnapTabBar extends StatefulWidget implements PreferredSizeWidget {
  const ScrollSnapTabBar(
      {Key? key,
      this.onTap,
      this.indicatorColor,
      required this.controller,
      this.indicatorWeight = 2.0,
      this.physics,
      this.labelColor,
      this.indicatorPadding = EdgeInsets.zero,
      this.unselectedLabelColor,
      required this.tabs,
      this.padding: EdgeInsets.zero,
      this.labelStyle,
      this.unselectedLabelStyle,
      this.indicatorSize,
      this.indicator})
      : super(key: key);
  final Function(int)? onTap;
  final Color? indicatorColor;
  final TabController controller;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final EdgeInsetsGeometry indicatorPadding;
  final Color? labelColor;
  final double indicatorWeight;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? unselectedLabelColor;
  final List<Widget> tabs;
  final Decoration? indicator;
  final TabBarIndicatorSize? indicatorSize;

  @override
  State<ScrollSnapTabBar> createState() => _ScrollSnapTabBarState();

  @override
  Size get preferredSize {
    double maxHeight = _kTabHeight;
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        final double itemHeight = item.preferredSize.height;
        maxHeight = math.max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(maxHeight + indicatorWeight);
  }
}

class _ScrollSnapTabBarState extends State<ScrollSnapTabBar> {
  ScrollController? _scrollController;
  TabController? _controller;
  int? _currentIndex;
  late double _tabStripWidth;
  late List<GlobalKey> _tabKeys;
  IndicatorPainter? _indicatorPainter;
  bool get _controllerIsValid => _controller?.animation != null;

  @override
  void initState() {
    super.initState();
    // If indicatorSize is TabIndicatorSize.label, _tabKeys[i] is used to find
    // the width of tab widget i. See _IndicatorPainter.indicatorRect().
    _tabKeys = widget.tabs.map((Widget tab) => GlobalKey()).toList();
  }

  void _updateTabController() {
    final TabController newController = widget.controller;

    if (newController == _controller) return;

    if (_controllerIsValid) {
      _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
      _controller!.removeListener(_handleTabControllerTick);
    }
    _controller = newController;
    if (_controller != null) {
      _controller!.animation!.addListener(_handleTabControllerAnimationTick);
      _controller!.addListener(_handleTabControllerTick);
      _currentIndex = _controller!.index;
    }
  }

  void _handleTabControllerAnimationTick() {
    assert(mounted);
    if (!_controller!.indexIsChanging) {
      // Sync the TabBar's scroll position with the TabBarView's PageView.
      _currentIndex = _controller!.index;
      _scrollToControllerValue();
    }
  }

  int get maxTabIndex => _indicatorPainter!.maxTabIndex;

  void _handleTabControllerTick() {
    if (_controller!.index != _currentIndex) {
      _currentIndex = _controller!.index;
      _scrollToCurrentIndex();
    }
    setState(() {
      // Rebuild the tabs after a (potentially animated) index change
      // has completed.
    });
  }

  void _scrollToCurrentIndex() {
    final double offset = _tabCenteredScrollOffset(_currentIndex!);
    _scrollController!
        .animateTo(offset, duration: kTabScrollDuration, curve: Curves.ease);
  }

  void _scrollToControllerValue() {
    final double? leadingPosition = _currentIndex! > 0
        ? _tabCenteredScrollOffset(_currentIndex! - 1)
        : null;
    final double middlePosition = _tabCenteredScrollOffset(_currentIndex!);
    final double? trailingPosition = _currentIndex! < maxTabIndex
        ? _tabCenteredScrollOffset(_currentIndex! + 1)
        : null;

    final double index = _controller!.index.toDouble();
    final double value = _controller!.animation!.value;
    final double offset;
    if (value == index - 1.0)
      offset = leadingPosition ?? middlePosition;
    else if (value == index + 1.0)
      offset = trailingPosition ?? middlePosition;
    else if (value == index)
      offset = middlePosition;
    else if (value < index)
      offset = leadingPosition == null
          ? middlePosition
          : lerpDouble(middlePosition, leadingPosition, index - value)!;
    else
      offset = trailingPosition == null
          ? middlePosition
          : lerpDouble(middlePosition, trailingPosition, value - index)!;

    _scrollController!.jumpTo(offset);
  }

  double _tabCenteredScrollOffset(int index) {
    final ScrollPosition position = _scrollController!.position;
    return _tabScrollOffset(index, position.viewportDimension,
        position.minScrollExtent, position.maxScrollExtent);
  }

  double _tabScrollOffset(
      int index, double viewportWidth, double minExtent, double maxExtent) {
    double tabCenter = _indicatorPainter!.centerOf(index);
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        tabCenter = _tabStripWidth - tabCenter;
        break;
      case TextDirection.ltr:
        break;
    }
    return (tabCenter - viewportWidth / 2.0).clamp(minExtent, maxExtent);
  }

  void _initIndicatorPainter() {
    _indicatorPainter = IndicatorPainter(
      controller: _controller!,
      indicator: _indicator,
      indicatorSize:
          widget.indicatorSize ?? TabBarTheme.of(context).indicatorSize,
      indicatorPadding: widget.indicatorPadding,
      tabKeys: _tabKeys,
      old: _indicatorPainter,
    );
  }

  Decoration get _indicator {
    if (widget.indicator != null) return widget.indicator!;
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    if (tabBarTheme.indicator != null) return tabBarTheme.indicator!;

    Color color = widget.indicatorColor ?? Theme.of(context).indicatorColor;
    if (color.value == Material.of(context)?.color?.value) {
      color = Colors.white;
    }

    return UnderlineTabIndicator(
      borderSide: BorderSide(
        width: widget.indicatorWeight,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _updateTabController();
    _initIndicatorPainter();
    final List<Widget> wrappedTabs =
        List<Widget>.generate(widget.tabs.length, (int index) {
      EdgeInsetsGeometry? adjustedPadding;
      return Center(
        heightFactor: 1.0,
        child: Padding(
          padding: adjustedPadding ?? kTabLabelPadding,
          child: KeyedSubtree(
            key: _tabKeys[index],
            child: widget.tabs[index],
          ),
        ),
      );
    });

    final int tabCount = widget.tabs.length;

    for (int index = 0; index < tabCount; index += 1) {
      final Set<MaterialState> states = <MaterialState>{
        if (index == _currentIndex) MaterialState.selected,
      };

      wrappedTabs[index] = InkWell(
        onTap: () {
          _handleTap(index);
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: widget.indicatorWeight),
          child: Stack(
            children: <Widget>[
              wrappedTabs[index],
              Semantics(selected: index == _currentIndex, label: 'index'),
            ],
          ),
        ),
      );
      wrappedTabs[index] = Expanded(child: wrappedTabs[index]);
    }

    Widget tabBar = CustomPaint(
      painter: _indicatorPainter,
      child: TabStyle(
        animation: kAlwaysDismissedAnimation,
        selected: false,
        labelColor: widget.labelColor,
        unselectedLabelColor: widget.unselectedLabelColor,
        labelStyle: widget.labelStyle,
        unselectedLabelStyle: widget.unselectedLabelStyle,
        child: TabLabelBar(
          onPerformLayout: _saveTabOffsets,
          children: wrappedTabs,
        ),
      ),
    );

    tabBar = SingleChildScrollView(
      dragStartBehavior: DragStartBehavior.start,
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      padding: widget.padding,
      physics: widget.physics,
      child: tabBar,
    );

    return tabBar;
  }

  void _handleTap(int index) {}

  // Called each time layout completes.
  void _saveTabOffsets(
      List<double> tabOffsets, TextDirection textDirection, double width) {
    _tabStripWidth = width;
    _indicatorPainter?.saveTabOffsets(tabOffsets, textDirection);
  }
}
