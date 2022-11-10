import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/owner/data/bookings/dto/padel.schedule.dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/presentation/widgets/drop.down.form.dart';
import '../../../../../core/presentation/widgets/text.input.form.dart';
import '../../../../../core/utils/util.dart';
import '../../../../../main/core/presentations/widgets/schedules.card.dart';
import '../../../booking/pages/owner.schedule.bottom.sheet.dart';
import '../../controllers/add.padel.page.controller.dart';

class AddPadelTimingSlide extends StatefulWidget {
  const AddPadelTimingSlide({Key? key, required this.controller})
      : super(key: key);
  final AddPadelPageController controller;

  @override
  State<AddPadelTimingSlide> createState() => _AddPadelTimingSlideState();
}

class _AddPadelTimingSlideState extends State<AddPadelTimingSlide> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.controller.formKeyTiming,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Timing',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: DropDownForm(
                        value:
                            widget.controller.padelDto.value.startTime != null
                                ? DateFormat.jm().format(
                                    widget.controller.padelDto.value.startTime!)
                                : null,
                        placeholder: 'Select start time',
                        onChange: (_, dynamic value) {
                          widget.controller.padelDto.value.startTime =
                              (value as DateTime);
                          widget.controller.generateSchedule();
                          setState(() {});
                        },
                        options: Util.getTimesOfADay(
                            widget.controller.pickedDuration.value!),
                        label: 'Start',
                        validator: (_) {
                          String? val = Util.validateNoEmpty(widget
                              .controller.padelDto.value.startTime
                              ?.toString());
                          if (val != null) return val;
                          return Util.validateStartTimeIsBeforeEndTime(
                              widget.controller.padelDto.value.startTime,
                              widget.controller.padelDto.value.endTime);
                        },
                        elevation: 1,
                        radius: 14,
                      )),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 30,
                child: DropDownForm(
                  value: widget.controller.padelDto.value.endTime != null
                      ? DateFormat.jm()
                          .format(widget.controller.padelDto.value.endTime!)
                      : null,
                  placeholder: 'Select end time',
                  onChange: (_, dynamic value) {
                    widget.controller.padelDto.value.endTime =
                        (value as DateTime);
                    widget.controller.generateSchedule();
                    setState(() {});
                  },
                  validator: (_) {
                    String? val = Util.validateNoEmpty(
                        widget.controller.padelDto.value.endTime?.toString());
                    if (val != null) return val;
                    return Util.validateStartTimeIsBeforeEndTime(
                        widget.controller.padelDto.value.startTime,
                        widget.controller.padelDto.value.endTime);
                  },
                  options: Util.getTimesOfADay(
                      widget.controller.pickedDuration.value!),
                  label: 'End',
                  elevation: 1,
                  radius: 14,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: TextInputForm(
                label: 'Booking Price',
                placeholder: '0',
                error: null,
                elevation: 1,
                radius: 12,
                suffixText: 'KD',
                validator: (_) => Util.validateGreaterThan(
                    (widget.controller.padelDto.value.price), 0),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                initialValue: widget.controller.padelDto.value.price.toString(),
                onChanged: (change) {
                  widget.controller.padelDto.value.price =
                      double.tryParse(change) ?? 0;
                  widget.controller.updateSchedulePrice();
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Booking Hours',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: SchedulesCard(
                  selectable: false,
                  schedules: widget.controller.padelScheduleDtos.value
                      .map((e) => PadelScheduleModel(
                          padelId: -1,
                          startTime: e.startTime!,
                          booked: e.booked ?? false,
                          price: e.price ?? 0,
                          endTime: e.endTime!))
                      .toList(),
                  date: DateTime.now(),
                  onClick: (PadelScheduleModel schedule) async {
                    dynamic value = await Get.bottomSheet(
                        OwnerScheduleBottomSheet(
                            padelSchedule: schedule, save: false));
                    if (value == null) return;
                    widget.controller.updateSchdule(value as PadelScheduleDto);
                    setState(() {});
                  },
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, bottom: 10, top: 10, right: 20),
            child: Center(
              child: Text(
                'Note!',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Center(
              child: Text(
                'You can change your timing and your price later in anytime you want for all hours or separately.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
