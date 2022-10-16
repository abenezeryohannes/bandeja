import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';

class CircularTabBar extends StatefulWidget {
  const CircularTabBar(
      {Key? key,
      required this.tabs,
      required this.onItemClick,
      required this.value})
      : super(key: key);

  final List<CircularTab> tabs;
  final Function(int index) onItemClick;
  final int value;
  @override
  State<CircularTabBar> createState() => _CircularTabBarState();
}

class CircularTab {
  final String? icon;
  final String? text;
  final double? radius;
  CircularTab({this.icon, this.text, this.radius});
}

class _CircularTabBarState extends State<CircularTabBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.tabs.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CustomShimmer(
            show: widget.tabs[index].text == null,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  10, 0, index == widget.tabs.length - 1 ? 20 : 0, 0),
              child: InkWell(
                onTap: () {
                  widget.onItemClick(index);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          widget.tabs[index].radius ?? 12),
                      border: Border.all(
                          color: Theme.of(context).dividerColor,
                          width: _isSelected(widget.tabs[index]) ? 0 : 1.2),
                      color: _isSelected(widget.tabs[index])
                          ? Theme.of(context).colorScheme.secondary
                          : widget.tabs[index].text == null
                              ? Colors.grey.shade300
                              : Colors.transparent),
                  child: Text(widget.tabs[index].text ?? '            ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: _isSelected(widget.tabs[index])
                              ? FontWeight.bold
                              : FontWeight.w400,
                          color: _isSelected(widget.tabs[index])
                              ? Colors.white
                              : Theme.of(context).colorScheme.shadow)),
                ),
              ),
            ),
          );
        });
  }

  bool _isSelected(CircularTab e) => widget.value == widget.tabs.indexOf(e);
}
