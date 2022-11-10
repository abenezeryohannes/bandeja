import 'dart:math';

import 'package:bargraph/dto/bar.dto.dart';
import 'package:bargraph/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatefulWidget {
  const BarGraph(
      {Key? key,
      required this.bars,
      this.barHeight = 200,
      this.width,
      this.gap = 20,
      this.isScrollable = false,
      this.physics = const BouncingScrollPhysics(),
      this.padding = EdgeInsets.zero,
      this.barPadding =
          const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
      this.onBarClicked})
      : super(key: key);
  final List<BarDto?> bars;
  final double barHeight;
  final double? width;
  final double gap;
  final ScrollPhysics physics;
  final bool isScrollable;
  final EdgeInsets padding;
  final EdgeInsets barPadding;
  final Function(int)? onBarClicked;
  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  double max = 0;
  int countAllNull = 0;
  late List<GlobalKey> _barKeys;
  double X_Position = 0.00;
  double Y_Position = 0.00;
  double X_Size = 0.00;
  late ScrollController _scrollController;
  late List<Widget> barItems;
  int? selectedIndex;

  void _getPosition(int index) {
    RenderBox? box =
        _barKeys[index].currentContext!.findRenderObject() as RenderBox?;

    Offset position = box!.localToGlobal(Offset.zero);

    setState(() {
      X_Position = position.dx;
      Y_Position = 0;
      X_Size = box.size.width;
    });
  }

  @override
  void initState() {
    _barKeys = widget.bars.map((_) => GlobalKey()).toList();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedIndex = (widget.bars.length > 1) ? 0 : widget.bars.length ~/ 2;
      _getPosition(selectedIndex!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    computeMax(widget.bars);
    barItems = createBarItems();
    return Stack(
      children: [
        (widget.isScrollable)
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                padding: widget.padding,
                physics: widget.physics,
                child: Row(children: barItems),
              )
            : Padding(
                padding: widget.padding,
                child: Row(children: barItems),
              ),
        if (selectedIndex != null &&
            ((widget.bars[selectedIndex!]?.showToolTip) ?? true))
          AnimatedPositioned(
              left:
                  (((widget.bars.length - (selectedIndex ?? 0)) * X_Size) > 100)
                      ? X_Position
                      : (X_Position - (50)),
              top: Y_Position,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: (widget.bars[selectedIndex!]?.toolTip) ?? const SizedBox())
      ],
    );
  }

  List<Widget> createBarItems() {
    if (_barKeys.length < widget.bars.length) {
      _barKeys = widget.bars.map((_) => GlobalKey()).toList();
    }
    return List<Widget>.generate(widget.bars.length, (int index) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomShimmer(
            show: countAllNull == widget.bars.length,
            child: Container(
              key: _barKeys[index],
              height: widget.barHeight,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: widget.barPadding,
                child: InkWell(
                  onTap: () {
                    // setState(() {
                    selectedIndex = index;
                    _getPosition(selectedIndex!);
                    // });
                    if (widget.onBarClicked != null) {
                      widget.onBarClicked!(index);
                    }
                  },
                  child: Container(
                    decoration: getDecoration(index),
                    height: getBarExactHeight(index),
                    width: getBarExactWidth(index),
                  ),
                ),
              ),
            ),
          ),
          Center(
              child: CustomShimmer(
                  show: countAllNull == widget.bars.length,
                  child: Container(
                      color: countAllNull == widget.bars.length
                          ? Colors.grey
                          : null,
                      child: getTitle(index))))
        ],
      );
    });
  }

  Widget getTitle(index) {
    if (index == selectedIndex) {
      if (widget.bars[index]?.titleWidget != null) {
        return widget.bars[index]!.titleWidget!;
      } else {
        if (widget.bars[index]?.title != null) {
          return Text(widget.bars[index]!.title!,
              style: (widget.bars[index]?.titleTextStyle != null)
                  ? widget.bars[index]?.titleTextStyle
                  : Theme.of(context).textTheme.bodyText1);
        } else {
          return const SizedBox();
        }
      }
    } else {
      if (widget.bars[index]?.titleWidget != null) {
        return widget.bars[index]!.titleWidget!;
      } else {
        if (widget.bars[index]?.title != null) {
          return Text(widget.bars[index]!.title!,
              style: (widget.bars[index]?.unselectedTitleTextStyle != null)
                  ? widget.bars[index]?.unselectedTitleTextStyle
                  : Theme.of(context).textTheme.bodyText2);
        } else {
          return const SizedBox();
        }
      }
    }
  }

  double getBarExactHeight(int index) {
    double value = (countAllNull == widget.bars.length)
        ? ((Random().nextDouble() * max) + 1)
        : widget.bars[index]!.value!;
    return ((widget.barHeight * value) / max);
  }

  double getBarExactWidth(index) {
    double subtraction = widget.padding.left + widget.padding.right;
    subtraction += ((widget.barPadding.left + widget.barPadding.right) *
        widget.bars.length);
    double total = widget.width ?? MediaQuery.of(context).size.width;
    return ((total - subtraction) / widget.bars.length);
  }

  BoxDecoration getDecoration(int index) {
    if (index == selectedIndex) {
      if (widget.bars[index] != null &&
          widget.bars[index]?.selectedBarDecoration != null) {
        return widget.bars[index]!.selectedBarDecoration!;
      } else {
        return BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(8)));
      }
    } else {
      if (widget.bars[index] != null &&
          widget.bars[index]?.unselectedBarDecoration != null) {
        return widget.bars[index]!.unselectedBarDecoration!;
      } else {
        return BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)));
      }
    }
  }

  computeMax(List<BarDto?> bars) {
    max = 0;
    countAllNull = 0;
    for (var e in bars) {
      if (e == null || e.value == null) {
        countAllNull++;
      } else if (e.value! > max) {
        max = e.value!;
      }
    }
    if (max == null && countAllNull == bars.length) {
      max = (Random().nextDouble() * 100) + 1;
    }
  }

  computeBarHeight(double? value) {
    if (value == null && countAllNull == null) {}
  }
}
