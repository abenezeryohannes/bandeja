import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ToggleForm extends StatefulWidget {
  const ToggleForm(
      {Key? key,
      required this.value,
      required this.onChange,
      this.title,
      this.enabled = true,
      this.inactiveText,
      this.activeText,
      this.activeBackgroundColor = Colors.black,
      this.inActiveBackgroundColor})
      : super(key: key);
  final bool value;
  final String? title;
  final String? inactiveText;
  final String? activeText;
  final bool enabled;
  final Color activeBackgroundColor;
  final Color? inActiveBackgroundColor;
  final Function(bool) onChange;
  @override
  State<ToggleForm> createState() => _ToggleFormState();
}

class _ToggleFormState extends State<ToggleForm> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      showOnOff: true,
      toggleSize: 16,
      valueFontSize: 14,
      disabled: !widget.enabled,
      width: 60,
      activeColor: widget.activeBackgroundColor,
      activeText: widget.activeText,
      inactiveText: widget.inactiveText,
      activeTextColor: Colors.white,
      inactiveTextColor: Colors.grey.shade900,
      inactiveColor: widget.inActiveBackgroundColor ?? Colors.grey.shade200,
      value: widget.value,
      onToggle: (val) {
        if (widget.enabled) {
          setState(() {
            widget.onChange(val);
          });
        }
      },
    );
  }
}
