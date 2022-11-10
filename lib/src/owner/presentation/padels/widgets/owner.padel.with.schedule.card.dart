import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/owner/presentation/booking/pages/owner.schedule.bottom.sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main/core/presentations/widgets/padel.card.dart';
import '../../../../main/core/presentations/widgets/schedules.card.dart';

class OwnerPadelWithScheduleCard extends StatefulWidget {
  const OwnerPadelWithScheduleCard(
      {Key? key, this.padel, required this.onChange})
      : super(key: key);
  final PadelModel? padel;
  final Function onChange;
  @override
  State<OwnerPadelWithScheduleCard> createState() =>
      _OwnerPadelWithScheduleCardState();
}

class _OwnerPadelWithScheduleCardState
    extends State<OwnerPadelWithScheduleCard> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PadelCard(item: widget.padel),
            if (widget.padel == null ||
                (widget.padel != null &&
                    widget.padel!.getSchedules().isNotEmpty))
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: SchedulesCard(
                  schedules: widget.padel?.getSchedules() ?? [null],
                  date: DateTime.now(),
                  onClick: (PadelScheduleModel schedule) {
                    selectedDate = schedule.startTime;
                    Get.bottomSheet(
                      OwnerScheduleBottomSheet(padelSchedule: schedule),
                    ).then((value) {
                      if (value != null) widget.onChange();
                    });
                  },
                ),
              ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
