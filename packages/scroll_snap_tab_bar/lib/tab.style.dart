import 'package:flutter/material.dart';

class TabStyle extends AnimatedWidget {
  const TabStyle({
    Key? key,
    required Animation<double> animation,
    required this.selected,
    required this.labelColor,
    required this.unselectedLabelColor,
    required this.labelStyle,
    required this.unselectedLabelStyle,
    required this.child,
  }) : super(key: key, listenable: animation);

  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final bool selected;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    final Animation<double> animation = listenable as Animation<double>;

    // To enable TextStyle.lerp(style1, style2, value), both styles must have
    // the same value of inherit. Force that to be inherit=true here.
    final TextStyle defaultStyle = (labelStyle ??
            tabBarTheme.labelStyle ??
            themeData.primaryTextTheme.bodyText1!)
        .copyWith(inherit: true);
    final TextStyle defaultUnselectedStyle = (unselectedLabelStyle ??
            tabBarTheme.unselectedLabelStyle ??
            labelStyle ??
            themeData.primaryTextTheme.bodyText1!)
        .copyWith(inherit: true);
    final TextStyle textStyle = selected
        ? TextStyle.lerp(defaultStyle, defaultUnselectedStyle, animation.value)!
        : TextStyle.lerp(
            defaultUnselectedStyle, defaultStyle, animation.value)!;

    final Color selectedColor = labelColor ??
        tabBarTheme.labelColor ??
        themeData.primaryTextTheme.bodyText1!.color!;
    final Color unselectedColor = unselectedLabelColor ??
        tabBarTheme.unselectedLabelColor ??
        selectedColor.withAlpha(0xB2); // 70% alpha
    final Color color = selected
        ? Color.lerp(selectedColor, unselectedColor, animation.value)!
        : Color.lerp(unselectedColor, selectedColor, animation.value)!;

    return DefaultTextStyle(
      style: textStyle.copyWith(color: color),
      child: IconTheme.merge(
        data: IconThemeData(
          size: 24.0,
          color: color,
        ),
        child: child,
      ),
    );
  }
}
