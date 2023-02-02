import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/presentation/widgets/big.text.button.dart';
import '../../../../main/core/presentations/widgets/feature.card.dart';
import '../../../../main/core/presentations/widgets/schedules.card.dart';
import '../../../../main/presentation/padels/widgets/padel.date.picker.dart';
import '../controllers/admin.padel.page.controller.dart';

class AdminPadelPageBody extends StatefulWidget {
  const AdminPadelPageBody(
      {Key? key, required this.padel, required this.controller})
      : super(key: key);
  final PadelModel padel;
  final AdminPadelPageController controller;

  @override
  State<AdminPadelPageBody> createState() => _AdminPadelPageBodyState();
}

class _AdminPadelPageBodyState extends State<AdminPadelPageBody> {
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
                          onClick: (PadelScheduleModel scheduleModel) {
                            return;
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
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1, color: Colors.grey.shade400))),
          child: (widget.controller.approved.value)
              ? BigTextButton(
                  onClick: () async {
                    widget.controller.approve(padel: widget.padel);
                  },
                  isExpanded: true,
                  cornerRadius: 10,
                  borderWidth: 2,
                  borderColor: Colors.red,
                  isLoading: widget.controller.loading.value,
                  backgroudColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                  textWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const Icon(Icons.cancel, color: Colors.red),
                      // const SizedBox(width: 10),
                      Text("Dont Approve",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                    ],
                  ),
                )
              : BigTextButton(
                  onClick: () async {
                    widget.controller.approve(padel: widget.padel);
                  },
                  isExpanded: true,
                  cornerRadius: 10,
                  isLoading: widget.controller.loading.value,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                  textWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.check),
                      const SizedBox(width: 10),
                      Text("Approve",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                    ],
                  ),
                ),
        ));
  }
}
