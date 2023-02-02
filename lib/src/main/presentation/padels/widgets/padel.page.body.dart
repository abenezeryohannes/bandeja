import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/presentation/widgets/big.text.button.dart';
import '../../../core/presentations/widgets/feature.card.dart';
import '../../../core/presentations/widgets/schedules.card.dart';
import '../../booking/pages/checkout.page.dart';
import '../controllers/padel.page.controller.dart';
import 'padel.date.picker.dart';

class PadelPageBody extends StatefulWidget {
  const PadelPageBody({Key? key, required this.padel, required this.controller})
      : super(key: key);
  final PadelModel padel;
  final PadelPageController controller;

  @override
  State<PadelPageBody> createState() => _PadelPageBodyState();
}

class _PadelPageBodyState extends State<PadelPageBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: widget.padel.getFeatures().isNotEmpty ? 60 : 0,
                child: ListView.builder(
                    itemCount: widget.padel.getFeatures().length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FeatureCard(
                            feature: widget.padel.getFeatures()[index],
                            iconColor: Colors.grey.shade400,
                            big: true),
                      );
                    })),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10)),
                        onPressed: () {
                          Get.bottomSheet(PadelDatePicker(
                              padel: widget.padel,
                              onDatePicked: (d) {
                                setState(() {
                                  widget.controller.date.value = d;
                                });
                                Get.back();
                              },
                              date: widget.controller.date.value));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 16),
                            Text(
                                widget.controller.date.value.day ==
                                        DateTime.now().day
                                    ? "Today"
                                    : DateFormat.yMMMd()
                                        .format(widget.controller.date.value),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white)),
                          ],
                        )),
                  )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Obx(() => widget.controller.padelWrapper.value.when(
                    emptyState: () => const SizedBox(),
                    loadingState: (_) => SchedulesCard(
                          schedules: List.generate(24, (index) => null),
                          cols: 3,
                          onClick: (_) {},
                          date: widget.controller.schedule.value?.startTime ??
                              DateTime.now(),
                        ),
                    loadedState: (value) => SchedulesCard(
                          schedules: (value as PadelModel).PadelSchedules ?? [],
                          cols: 3,
                          onClick: (PadelScheduleModel scheduleModel) async {
                            if (scheduleModel.booked) {
                              widget.controller.checkIfMyReservation(
                                  context, scheduleModel.id);
                              return;
                            }
                            widget.controller.schedule.value = scheduleModel;
                          },
                          date: widget.controller.schedule.value?.startTime ??
                              DateTime.now(),
                        ),
                    errorState: (failure) => ShowError(
                          failure: failure,
                          errorShowType: ErrorShowType.vertical,
                        ))),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _bottom(),
        )
      ],
    );
  }

  _bottom() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border:
              Border(top: BorderSide(width: 1, color: Colors.grey.shade400))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Obx(() => Text(
                    '${widget.controller.schedule.value?.price ?? widget.controller.initPadel.value?.price ?? '-'} KD',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  )),
            ],
          ),
          BigTextButton(
            onClick: () async {
              if (widget.controller.schedule.value == null) return;
              await Get.to(CheckoutPage(
                padel: widget.padel,
                schedule: widget.controller.schedule.value!,
              ));
              widget.controller.loadPadel();
            },
            isExpanded: false,
            cornerRadius: 10,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
            textWidget: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Pay Now",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFFF00))),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
