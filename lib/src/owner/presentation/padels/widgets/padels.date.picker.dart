import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

import '../../../../core/network/api.dart';

class PadelsDatePicker extends StatefulWidget {
  const PadelsDatePicker(
      {Key? key,
      required this.owner,
      required this.onDatePicked,
      required this.date})
      : super(key: key);
  final UserModel owner;
  final DateTime date;
  final Function(DateTime date) onDatePicked;
  @override
  State<PadelsDatePicker> createState() => _PadelsDatePickerState();
}

class _PadelsDatePickerState extends State<PadelsDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 0),
            color: Theme.of(context).dividerColor,
            width: 60,
            height: 6,
          ),
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade300,
            backgroundImage:
                (widget.owner == null || widget.owner.avatar == null)
                    ? null
                    : NetworkImage(Api.getMedia(widget.owner.avatar!)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.owner.fullName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          DayPicker.single(
              selectedDate: widget.date,
              datePickerLayoutSettings: const DatePickerLayoutSettings(
                  dayPickerRowHeight: 34, contentPadding: EdgeInsets.zero),
              onChanged: (date) {
                widget.onDatePicked(date);
              },
              firstDate: DateTime.now().subtract(const Duration(hours: 24)),
              lastDate: DateTime.now().add(const Duration(days: 365))),
        ],
      ),
    );
  }
}
