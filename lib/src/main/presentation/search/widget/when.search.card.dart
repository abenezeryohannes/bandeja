import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:bandeja/src/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/show.error.dart';
import '../../../../core/presentation/widgets/tab.bar.dart';

class WhenSearchCard extends StatefulWidget {
  const WhenSearchCard(
      {Key? key,
      this.value,
      required this.startDate,
      required this.endDate,
      required this.onChange,
      required this.durations,
      required this.durationValue,
      required this.active,
      required this.activate,
      required this.onDurationChange})
      : super(key: key);
  final bool active;
  final DateTime? value;
  final WrapperDto<List<DurationModel>> durations;
  final DurationModel? durationValue;
  final Function(DateTime d) onChange;
  final Function activate;
  final Function onDurationChange;
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
              const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
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
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10, left: 20, right: 20),
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
                  height: widget.active ? 340 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: widget.active ? 1 : 0,
                    child: SizedBox(
                      height: widget.active ? 360 : 0,
                      child: Column(
                        children: [
                          Flexible(
                            child: DayPicker.single(
                                selectedDate: widget.value == null
                                    ? DateTime.now()
                                    : widget.value!,
                                onChanged: (d) {
                                  widget.onChange(d);
                                },
                                firstDate: widget.startDate,
                                lastDate: widget.endDate),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            height: 50,
                            child: widget.durations.when(
                                emptyState: () => const SizedBox(
                                      height: 40,
                                    ),
                                loadingState: (_) => SizedBox(
                                      height: 40,
                                      child: CircularTabBar(
                                        onItemClick: (int index) {},
                                        tabs: [null, null, null]
                                            .map((e) => CircularTab(
                                                text: null, radius: 100))
                                            .toList(),
                                        value: -1,
                                      ),
                                    ),
                                loadedState: (value) => SizedBox(
                                      height: 50,
                                      child: CircularTabBar(
                                        onItemClick: (int index) {
                                          widget.onDurationChange((value
                                              as List<DurationModel>)[index]);
                                        },
                                        tabs: (value as List<DurationModel>)
                                            .map((e) => CircularTab(
                                                text: (e.minute <= 0)
                                                    ? 'Anytime'
                                                    : Util.getDurationIn(
                                                        e.minute,
                                                        showIn: 'M'),
                                                radius: 100))
                                            .toList(),
                                        value: widget.durationValue != null
                                            ? (value)
                                                .indexOf(widget.durationValue!)
                                            : 0,
                                      ),
                                    ),
                                errorState: (failure) => SizedBox(
                                      height: 40,
                                      child: ShowError(failure: failure),
                                    )
                                // ShowError(failure: failure)
                                ),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
