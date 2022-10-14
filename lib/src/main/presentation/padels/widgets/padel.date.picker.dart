import 'package:feekpadel/src/main/domain/padels/entities/padel.dart';
import 'package:feekpadel/src/main/presentation/home/widget/padel.avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

import '../../search/widget/when.search.card.dart';

class PadelDatePicker extends StatefulWidget {
  const PadelDatePicker(
      {Key? key,
      required this.padel,
      required this.onDatePicked,
      required this.date})
      : super(key: key);
  final PadelModel padel;
  final DateTime date;
  final Function(DateTime date) onDatePicked;
  @override
  State<PadelDatePicker> createState() => _PadelDatePickerState();
}

class _PadelDatePickerState extends State<PadelDatePicker> {
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
          PadelAvatar(
              item: widget.padel,
              borderColor: Colors.transparent,
              radius: 30,
              margins: const EdgeInsets.all(8),
              hero: '',
              onClick: () {}),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.padel.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.padel.name,
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 20,
          ),
          DayPicker.single(
              selectedDate: widget.date,
              // datePickerStyles: DatePickerStyles(),
              datePickerLayoutSettings: const DatePickerLayoutSettings(
                  dayPickerRowHeight: 30, contentPadding: EdgeInsets.zero),
              onChanged: (date) {
                widget.onDatePicked(date);
              },
              firstDate: DateTime.now().subtract(const Duration(hours: 24)),
              lastDate: DateTime.now().add(const Duration(days: 365))),
          // WhenSearchCard(
          //   activate: () {},
          //   active: true,
          //   onChange: (date) {
          //     widget.onDatePicked(date);
          //   },
          //   value: widget.date,
          //   startDate: DateTime.now().subtract(const Duration(hours: 24)),
          //   endDate: DateTime.now().add(const Duration(days: 365)),
          // ),
        ],
      ),
    );
  }
}
