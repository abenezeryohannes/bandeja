import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';

class WhenSearchCard extends StatefulWidget {
  const WhenSearchCard(
      {Key? key,
      this.value,
      required this.startDate,
      required this.endDate,
      required this.onChange,
      required this.active,
      required this.activate})
      : super(key: key);
  final bool active;
  final DateTime? value;
  final Function(DateTime d) onChange;
  final Function() activate;
  final DateTime startDate;
  final DateTime endDate;

  @override
  State<WhenSearchCard> createState() => _WhenSearchCardState();
}

class _WhenSearchCardState extends State<WhenSearchCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 300),
      child: Container(
          margin: const EdgeInsets.only(left: 20, top: 16, right: 20),
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 15.0,
                spreadRadius: 5.0,
                offset: const Offset(5.0, 5.0),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  widget.activate();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(microseconds: 800),
                        child: (widget.active)
                            ? const Text("When",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold))
                            : Text("When",
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                      ),
                      Text(
                          widget.value == null
                              ? 'Anytime'
                              : DateFormat.yMMMd().format(widget.value!),
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: widget.active ? 289 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: widget.active ? 1 : 0,
                    child: DayPicker.single(
                        selectedDate: widget.value == null
                            ? DateTime.now()
                            : widget.value!,
                        onChanged: (d) {
                          widget.onChange(d);
                        },
                        firstDate: widget.startDate,
                        lastDate: widget.endDate),
                  )),
            ],
          )),
    );
  }
}
