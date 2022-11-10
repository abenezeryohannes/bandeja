// This class and its renderer class only exist to report the widths of the tabs
// upon layout. The tab widths are only used at paint time (see _IndicatorPainter)
// or in response to input.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../classes/tab.label.bar.renderer.dart';
import '../classes/layout.callback.dart' as my;

class TabLabelBar extends Flex {
  TabLabelBar({
    Key? key,
    List<Widget> children = const <Widget>[],
    required this.onPerformLayout,
  }) : super(
          key: key,
          children: children,
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
        );

  final my.LayoutCallback onPerformLayout;

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return TabLabelBarRenderer(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context)!,
      verticalDirection: verticalDirection,
      onPerformLayout: onPerformLayout,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, TabLabelBarRenderer renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject.onPerformLayout = onPerformLayout;
  }
}
