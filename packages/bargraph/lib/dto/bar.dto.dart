import 'package:flutter/widgets.dart';

class BarDto {
  String? title;
  Widget? toolTip;
  bool showToolTip;
  Widget? titleWidget;
  TextStyle? titleTextStyle;
  TextStyle? unselectedTitleTextStyle;
  BoxDecoration? unselectedBarDecoration;
  BoxDecoration? selectedBarDecoration;
  double? value;

  BarDto(
      {this.title,
      this.titleWidget,
      this.toolTip,
      this.showToolTip = true,
      required this.value,
      this.titleTextStyle,
      this.unselectedBarDecoration,
      this.unselectedTitleTextStyle,
      this.selectedBarDecoration});
}
