import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/presentation/widgets/toggle.form.dart';
import 'package:bandeja/src/owner/data/bookings/dto/padel.schedule.dto.dart';
import 'package:bandeja/src/owner/presentation/booking/controllers/owner.shcedule.bottom.sheet.controller.dart';
import 'package:bandeja/src/owner/presentation/booking/widgets/owner.booking.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/big.text.button.dart';

class OwnerScheduleBottomSheet extends StatefulWidget {
  const OwnerScheduleBottomSheet(
      {Key? key, required this.padelSchedule, this.save = true})
      : super(key: key);
  final PadelScheduleModel padelSchedule;
  final bool save;
  @override
  State<OwnerScheduleBottomSheet> createState() =>
      _OwnerScheduleBottomSheetState();
}

class _OwnerScheduleBottomSheetState extends State<OwnerScheduleBottomSheet> {
  late OwnerScheduleBottomSheetController controller;
  @override
  void initState() {
    controller = Get.put(OwnerScheduleBottomSheetController(
        Rx<PadelScheduleModel>(widget.padelSchedule)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Theme.of(context).scaffoldBackgroundColor),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 0),
                      color: Theme.of(context).dividerColor,
                      width: 60,
                      height: 6,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 20),
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, bottom: 10, top: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        DateFormat.jm()
                            .format(controller.padelSchedule.value.startTime),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Obx(() => items(
                          img: 'assets/icons/dollar-green-background.png',
                          title: 'Change the price',
                          value: SizedBox(
                            width: 80,
                            height: 36,
                            child: TextFormField(
                              initialValue: controller.padelSchedule.value.price
                                      ?.toString() ??
                                  '0.0',
                              style: Theme.of(context).textTheme.bodyText2,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              enabled: controller.padelOrder.value == null,
                              onChanged: (val) {
                                controller.padelSchduleDto.value.price =
                                    double.tryParse(val);
                                controller.padelSchduleDto.refresh();
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 10, right: 5, top: 2, bottom: 2),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  suffixText: "KD",
                                  suffixStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.green)),
                            ),
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Obx(() => items(
                          img: 'assets/icons/shutdown.png',
                          title: 'This time is Booked',
                          value: SizedBox(
                            height: 30,
                            child: ToggleForm(
                              activeBackgroundColor: Colors.red,
                              enabled: controller.padelOrder.value == null,
                              inActiveBackgroundColor: Colors.grey.shade200,
                              onChange: (bool val) {
                                controller.padelSchduleDto.value.booked = val;
                                controller.padelSchduleDto.refresh();
                              },
                              value: controller.padelSchduleDto.value.booked ??
                                  false,
                            ),
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Obx(() => items(
                          img: 'assets/icons/setting-black-background.png',
                          title: 'Apply for all days',
                          value: SizedBox(
                            height: 30,
                            child: ToggleForm(
                              activeBackgroundColor: Colors.black,
                              inActiveBackgroundColor: Colors.grey.shade200,
                              enabled: controller.padelOrder.value == null,
                              onChange: (bool val) {
                                controller.padelSchduleDto.value
                                    .applyForAllDays = val;
                                controller.padelSchduleDto.refresh();
                              },
                              value: controller
                                      .padelSchduleDto.value.applyForAllDays ??
                                  false,
                            ),
                          ))),
                    ),
                  ]),
                  if (MediaQuery.of(context).viewInsets.bottom == 0)
                    Obx(() => BigTextButton(
                          onClick: () {
                            if (!widget.save) {
                              Get.back<PadelScheduleDto>(
                                  result: controller.padelSchduleDto.value);
                            }
                            controller.saveSchedule();
                          },
                          enabled: controller.padelOrder.value == null,
                          cornerRadius: 10,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          horizontalMargin: const EdgeInsets.only(
                              left: 30, right: 30, top: 20),
                          text: "Save",
                        ))
                ],
              ),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0)
            Align(
              alignment: const Alignment(-1, -1),
              child: SizedBox(
                height: 110,
                child: Obx(() => controller.padelOrderDto.value.when(
                      emptyState: () => const SizedBox(),
                      errorState: (Failure failure) => Card(
                          color: Colors.grey.shade200,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          elevation: 1,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Center(
                              child: Text(
                            failure.message ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey.shade600),
                          ))),
                      loadedState: (value) =>
                          OwnerBookingCard(onClick: (val) {}, order: value),
                      loadingState: (_) => OwnerBookingCard(onClick: (_) {}),
                    )),
              ),
            )
        ],
      ),
    );
  }

  Widget items(
      {required String img, required String title, required Widget value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              img,
              width: 32,
              height: 32,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        value
      ],
    );
  }
}
