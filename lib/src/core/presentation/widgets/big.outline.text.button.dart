import 'package:flutter/material.dart';

class BigOutlineTextButton extends StatefulWidget {
  const BigOutlineTextButton({
    Key? key,
    this.cornerRadius = 10.0,
    this.text,
    this.textWidget,
    this.textColor = Colors.white,
    this.backgroudColor = Colors.blueAccent,
    required this.onClick,
    this.borderColor = Colors.blueAccent,
    this.elevation = 1,
    this.fontSize = 14,
    this.enabled = true,
    this.isExpanded = true,
    this.horizontalMargin = EdgeInsets.zero,
    this.fontWight = FontWeight.w400,
    this.padding = EdgeInsets.zero,
    this.isLoading = false,
  }) : super(key: key);

  final double cornerRadius;
  final double elevation;
  final String? text;
  final Widget? textWidget;
  final Color textColor;
  final Color borderColor;
  final bool isExpanded;
  final bool isLoading;
  final Color backgroudColor;
  final Function onClick;
  final bool enabled;
  final EdgeInsets padding;
  final double fontSize;
  final FontWeight fontWight;
  final EdgeInsets horizontalMargin;

  @override
  State<BigOutlineTextButton> createState() => _BigOutlineTextButtonState();
}

class _BigOutlineTextButtonState extends State<BigOutlineTextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.horizontalMargin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: (widget.isExpanded) ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (widget.isExpanded) _expanded(),
          if (!widget.isExpanded) _normal(),
        ],
      ),
    );
  }

  Widget _expanded() {
    return Expanded(
      child: _button(),
    );
  }

  Widget _normal() {
    return _button();
  }

  Widget _button() {
    return OutlinedButton(
        onPressed: () => !widget.enabled ? null : {widget.onClick()},
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(widget.elevation),
            side: MaterialStateProperty.all(BorderSide(
                color: widget.borderColor,
                width: 1.0,
                style: BorderStyle.solid)),
            backgroundColor: MaterialStateProperty.all(widget.enabled
                ? widget.backgroudColor
                : widget.backgroudColor.withOpacity(0.6)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.cornerRadius),
            ))),
        child: Padding(
            padding: widget.padding,
            child: (widget.isLoading)
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : (widget.text != null)
                    ? Text(
                        widget.text!,
                        style: TextStyle(
                            color: widget.textColor,
                            fontSize: widget.fontSize,
                            fontWeight: widget.fontWight),
                      )
                    : (widget.textWidget == null)
                        ? const SizedBox()
                        : widget.textWidget!));
  }
}
