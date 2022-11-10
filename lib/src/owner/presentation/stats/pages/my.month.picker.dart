import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/network/api.dart';

class MyMonthPicker extends StatefulWidget {
  const MyMonthPicker(
      {Key? key,
      required this.month,
      required this.onChange,
      required this.owner})
      : super(key: key);
  final DateTimeRange month;
  final UserModel owner;
  final Function(DateTimeRange) onChange;
  @override
  State<MyMonthPicker> createState() => _MyMonthPickerState();
}

class _MyMonthPickerState extends State<MyMonthPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
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
            backgroundImage: (widget.owner.avatar == null)
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
          MonthPicker.single(
              firstDate: DateTime.now().subtract(const Duration(days: 700)),
              lastDate: DateTime.now().add(const Duration(days: 60)),
              onChanged: (DateTime value) {
                DateTime start = DateTime(value.year, value.month, 1, 1, 0);
                DateTime end = DateTime(value.year,
                        value.month > 11 ? 1 : value.month + 1, 1, 1, 0)
                    .subtract(const Duration(days: 1));
                widget.onChange(DateTimeRange(start: start, end: end));
              },
              selectedDate: widget.month.start),
        ],
      ),
    );
  }
}
