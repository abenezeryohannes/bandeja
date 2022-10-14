import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ToggleForm extends StatefulWidget {
  const ToggleForm(
      {Key? key,
      required this.value,
      required this.onChange,
      this.title,
      this.inactiveText,
      this.activeText})
      : super(key: key);
  final bool value;
  final String? title;
  final String? inactiveText;
  final String? activeText;
  final Function(bool) onChange;
  @override
  State<ToggleForm> createState() => _ToggleFormState();
}

class _ToggleFormState extends State<ToggleForm> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterSwitch(
          showOnOff: true,
          toggleSize: 16,
          valueFontSize: 14,
          width: 60,
          activeColor: Colors.black,
          activeText: widget.activeText,
          inactiveText: widget.inactiveText,
          activeTextColor: Colors.white,
          inactiveTextColor: Colors.grey.shade900,
          value: widget.value,
          onToggle: (val) {
            setState(() {
              widget.onChange(val);
            });
          },
        ),
        // if (widget.title != null)
        //   Text(
        //     widget.title!,
        //     style: const TextStyle(
        //       fontWeight: FontWeight.w500,
        //       fontSize: 16,
        //     ),
        //   ),
        // SizedBox(
        //   height: 10,
        //   width: 44,
        //   child: FittedBox(
        //     fit: BoxFit.cover,
        //     child: CupertinoSwitch(
        //       value: widget.value,
        //       activeColor: Theme.of(context).shadowColor,
        //       onChanged: (value) {
        //         setState(() {
        //           widget.onChange(value);
        //         });
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
