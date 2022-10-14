import 'package:flutter/material.dart';

class TextInputForm extends StatefulWidget {
  const TextInputForm({
    Key? key,
    required this.label,
    required this.placeholder,
    this.error,
    this.focusNode,
    this.enabled = true,
    this.initialValue,
    required this.onChanged,
    this.suffixText = '',
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key);

  final String label;
  final int maxLines;
  final int minLines;
  final bool enabled;
  final FocusNode? focusNode;
  final FloatingLabelBehavior floatingLabelBehavior;
  final String? initialValue;
  final String suffixText;
  final String placeholder;
  final Function(String val) onChanged;
  final String? error;

  @override
  State<TextInputForm> createState() => _TextInputFormState();
}

class _TextInputFormState extends State<TextInputForm> {
  String? initialValue;
  @override
  void initState() {
    initialValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.multiline,
      minLines: widget.minLines,
      focusNode: widget.focusNode,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      initialValue: initialValue,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        focusColor: Colors.grey.shade800,
        hintText: widget.placeholder,
        suffixText: widget.suffixText,

        // constraints: BoxConstraints(maxHeight: 42),
        filled: true, fillColor: Colors.white,
        labelText: widget.label,
        labelStyle: TextStyle(color: Colors.grey.shade700),
        floatingLabelBehavior: widget.floatingLabelBehavior,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 10, vertical: (widget.maxLines > 1) ? 14 : 0),
        // errorText:     !validCode ? widget.tr('field_required') : null,
      ),
      onChanged: (val) {
        widget.onChanged(val);
      },
    );
  }
}
