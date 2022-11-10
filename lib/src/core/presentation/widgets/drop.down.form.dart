import 'package:flutter/material.dart';

class DropDownForm extends StatefulWidget {
  const DropDownForm(
      {Key? key,
      this.value,
      required this.onChange,
      required this.options,
      required this.label,
      this.placeholder,
      required this.radius,
      required this.elevation,
      this.validator,
      this.enabled = true})
      : super(key: key);
  final List<Map<String, dynamic>> options;
  final String label;
  final String? value;
  final String? placeholder;
  final String? Function(dynamic)? validator;
  final double radius;
  final bool enabled;
  final double elevation;
  final Function(String key, dynamic value) onChange;

  @override
  State<DropDownForm> createState() => _DropDownFormState();
}

class _DropDownFormState extends State<DropDownForm> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
      child: DropdownButtonFormField<dynamic>(
          isExpanded: true,
          isDense: true,
          validator: widget.validator,
          decoration: InputDecoration(
            errorMaxLines: 3,
            focusColor: Colors.grey.shade800,
            filled: true,
            enabled: widget.enabled,
            fillColor: Colors.grey.shade50,
            labelText: widget.label,
            labelStyle: TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.w500),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.3, color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.3, color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 0.3, color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
          ),
          items: widget.options
              .where((element) =>
                  widget.enabled || (element.keys.contains(widget.value)))
              .map((option) => DropdownMenuItem<dynamic>(
                    value: option[option.keys.toList()[0]],
                    child: Text(option.keys.toList()[0]),
                  ))
              .toList(),
          onChanged: (dynamic? value) {
            if (value != null) {
              final result = widget.options
                  .where((element) => element.values.first == value);
              if (result.isNotEmpty) {
                widget.onChange(result.first.keys.first, value);
              }
            }
          },
          hint: Text(
            widget.placeholder ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.grey.shade500),
          ),
          value: widget.value == null
              ? null
              : widget.options
                  .where((element) => element.keys.first == widget.value)
                  .first[widget.value]),
    );
  }
}
