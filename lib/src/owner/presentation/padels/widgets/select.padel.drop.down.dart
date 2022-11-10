import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:flutter/material.dart';

class SelectPadelDropDown extends StatefulWidget {
  const SelectPadelDropDown(
      {Key? key, required this.padels, this.value, required this.onChanged})
      : super(key: key);
  final List<PadelModel?> padels;
  final PadelModel? value;
  final Function(PadelModel?) onChanged;
  @override
  State<SelectPadelDropDown> createState() => _SelectPadelDropDownState();
}

class _SelectPadelDropDownState extends State<SelectPadelDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 8),
      height: 34,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.secondary),
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PadelModel>(
          items: widget.padels.map((PadelModel? value) {
            return DropdownMenuItem<PadelModel>(
              value: value,
              child: Text(value == null ? '' : value.name),
            );
          }).toList(),
          value: widget.value,
          iconEnabledColor: Theme.of(context).colorScheme.secondary,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).colorScheme.secondary, fontSize: 12),
          onChanged: (val) {
            widget.onChanged(val);
          },
        ),
      ),
    );
  }
}
