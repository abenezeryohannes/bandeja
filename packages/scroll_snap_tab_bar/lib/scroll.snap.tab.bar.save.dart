// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// const double _kTabHeight = 46.0;

// class ScrollSnapTabBar extends StatefulWidget implements PreferredSizeWidget {
//   const ScrollSnapTabBar(
//       {Key? key,
//       this.onTap,
//       this.indicatorColor,
//       required this.controller,
//       this.indicatorWeight = 2.0,
//       this.physics,
//       this.labelColor,
//       this.indicatorPadding = EdgeInsets.zero,
//       this.unselectedLabelColor,
//       required this.tabs,
//       this.padding: EdgeInsets.zero,
//       this.labelStyle,
//       this.unselectedLabelStyle})
//       : super(key: key);
//   final Function(int)? onTap;
//   final Color? indicatorColor;
//   final TabController controller;
//   final ScrollPhysics? physics;
//   final EdgeInsets padding;
//   final EdgeInsets indicatorPadding;
//   final Color? labelColor;
//   final double indicatorWeight;
//   final TextStyle? labelStyle;
//   final TextStyle? unselectedLabelStyle;
//   final Color? unselectedLabelColor;
//   final List<Widget> tabs;

//   @override
//   State<ScrollSnapTabBar> createState() => _ScrollSnapTabBarState();

//   @override
//   Size get preferredSize {
//     double maxHeight = _kTabHeight;
//     for (final Widget item in tabs) {
//       if (item is PreferredSizeWidget) {
//         final double itemHeight = item.preferredSize.height;
//         maxHeight = math.max(itemHeight, maxHeight);
//       }
//     }
//     return Size.fromHeight(maxHeight + indicatorWeight);
//   }
// }

// class _ScrollSnapTabBarState extends State<ScrollSnapTabBar> {
//   ScrollController? _scrollController;
//   TabController? _controller;
//   int? _currentIndex;
//   late double _tabStripWidth;
//   late List<GlobalKey> _tabKeys;

//   @override
//   void initState() {
//     super.initState();
//     // If indicatorSize is TabIndicatorSize.label, _tabKeys[i] is used to find
//     // the width of tab widget i. See _IndicatorPainter.indicatorRect().
//     _tabKeys = widget.tabs.map((Widget tab) => GlobalKey()).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> wrappedTabs =
//         List<Widget>.generate(widget.tabs.length, (int index) {
//       EdgeInsetsGeometry? adjustedPadding;
//       return Center(
//         heightFactor: 1.0,
//         child: Padding(
//           padding: adjustedPadding ?? kTabLabelPadding,
//           child: KeyedSubtree(
//             key: _tabKeys[index],
//             child: widget.tabs[index],
//           ),
//         ),
//       );
//     });

//     final int tabCount = widget.tabs.length;
 
//     for (int index = 0; index < tabCount; index += 1) {
//       final Set<MaterialState> states = <MaterialState>{
//         if (index == _currentIndex) MaterialState.selected,
//       };
 

//       wrappedTabs[index] = InkWell( 
//         onTap: () {
//           _handleTap(index);
//         }, 
//         child: Padding(
//           padding: EdgeInsets.only(bottom: widget.indicatorWeight),
//           child: Stack(
//             children: <Widget>[
//               wrappedTabs[index],
//               Semantics(
//                 selected: index == _currentIndex,
//                 label: 'index'
//               ),
//             ],
//           ),
//         ),
//       ); 
//         wrappedTabs[index] = Expanded(child: wrappedTabs[index]);
//     }

//     Widget tabBar = CustomPaint(
//       painter: _indicatorPainter,
//       child: TabStyle(
//         animation: kAlwaysDismissedAnimation,
//         selected: false,
//         labelColor: widget.labelColor,
//         unselectedLabelColor: widget.unselectedLabelColor,
//         labelStyle: widget.labelStyle,
//         unselectedLabelStyle: widget.unselectedLabelStyle,
//         child: _TabLabelBar(
//           onPerformLayout: _saveTabOffsets,
//           children: wrappedTabs,
//         ),
//       ),
//     );

//     tabBar = SingleChildScrollView(
//       dragStartBehavior: DragStartBehavior.start,
//       scrollDirection: Axis.horizontal,
//       controller: _scrollController,
//       padding: widget.padding,
//       physics: widget.physics,
//       child: tabBar,
//     );

//     return tabBar;
//   }
// }
