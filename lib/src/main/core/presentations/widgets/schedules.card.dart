import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/domain/padels/entities/padel.schedule.dart';
import '../../../../core/utils/util.dart';

class SchedulesCard extends StatefulWidget {
  const SchedulesCard(
      {Key? key,
      required this.schedules,
      required this.onClick,
      required this.date,
      this.cols = 3,
      this.selectable = true})
      : super(key: key);
  final List<PadelScheduleModel?> schedules;
  final int cols;
  final bool selectable;
  final Function(PadelScheduleModel) onClick;
  final DateTime date;
  @override
  State<SchedulesCard> createState() => _SchedulesCardState();
}

class _SchedulesCardState extends State<SchedulesCard> {
  PadelScheduleModel? selectedSchedule;
  @override
  void initState() {
    if (!widget.schedules.contains(null) && widget.selectable) {
      selectedSchedule = Util.getAllSchedulesFirstFreeSopt(
          widget.schedules.map((e) => e!).toList());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
      child: GridView.count(
        crossAxisCount: widget.cols,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 10.0,
        padding: const EdgeInsets.symmetric(vertical: 10),
        childAspectRatio: widget.cols.toDouble(),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: getList().map((e) {
          bool occupaid =
              (e == null) ? false : e.booked; //checkIfOccupaid(e.startTime);
          return CustomShimmer(
            show: e == null,
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 3)),
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(
                                width: e == null ? 0 : 2,
                                color: Theme.of(context).dividerColor))),
                    backgroundColor: MaterialStateProperty.all<Color>((e == null
                        ? Colors.grey.shade200
                        : (selectedSchedule == e && widget.selectable)
                            ? Theme.of(context).colorScheme.secondary
                            : (occupaid)
                                ? Colors.grey.shade200
                                : Theme.of(context).scaffoldBackgroundColor))),
                onPressed: () {
                  if (e == null) return;
                  if (!occupaid) {
                    setState(() {
                      selectedSchedule = e;
                    });
                  }
                  widget.onClick(e);
                },
                child: Text(
                  e == null ? "" : (DateFormat.jm().format(e.startTime)),
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: (e != null &&
                                selectedSchedule == e &&
                                widget.selectable)
                            ? Colors.white
                            : (occupaid)
                                ? Colors.grey.shade500
                                : Colors.grey.shade700,
                        fontSize: 12,
                      ),
                )),
          );
        }).toList(),
      ),
    );
  }

  // bool checkIfOccupaid(DateTime time) {
  //   for (int i = 0; i < widget.padel.getSchedules().length; i++) {
  //     if (widget.padel.getSchedules()[i].startTime.isAtSameMomentAs(time)) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  List<PadelScheduleModel?> getList() {
    // if (!widget.padel.startTime.isBefore(widget.padel.endTime)) return [];
    // int gap = widget.padel.getDuration().minute;
    // List<PadelScheduleModel> schedules = [];
    // for (DateTime index = widget.padel.startTime;
    //     index.isBefore(widget.padel.endTime);
    //     index = index.add(Duration(minutes: gap))) {
    //   DateTime start = index;
    //   schedules.add(PadelScheduleModel(
    //       padelId: widget.padel.id,
    //       startTime: start,
    //       endTime: start.add(Duration(minutes: gap))));
    // }
    if (widget.schedules.contains(null)) {
      List<PadelScheduleModel?> emptyLists = [];
      for (int i = 0; i < 12; i++) {
        emptyLists.add(null);
      }
      return emptyLists;
    }
    final result = widget.schedules;
    return result;
    // return widget.padel.getSchedules();
    // return schedules;
  }
}
