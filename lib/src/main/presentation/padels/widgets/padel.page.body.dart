import 'package:feekpadel/src/main/core/presentations/widgets/feature.card.dart';
import 'package:feekpadel/src/main/core/presentations/widgets/schedules.card.dart';
import 'package:feekpadel/src/main/domain/padels/entities/padel.dart';
import 'package:feekpadel/src/main/presentation/padels/controllers/padel.page.controller.dart';
import 'package:feekpadel/src/main/presentation/padels/pages/checkout.page.dart';
import 'package:feekpadel/src/main/presentation/padels/widgets/padel.date.picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PadelPageBody extends StatefulWidget {
  const PadelPageBody({Key? key, required this.padel}) : super(key: key);
  final PadelModel padel;
  @override
  State<PadelPageBody> createState() => _PadelPageBodyState();
}

class _PadelPageBodyState extends State<PadelPageBody> {
  late PadelPageController controller;
  @override
  void initState() {
    controller = Get.put(PadelPageController(initPadel: widget.padel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
              itemCount: widget.padel.getFeatures().length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return FeatureCard(
                    feature: widget.padel.getFeatures()[index], big: true);
              })),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(() => Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10)),
                  onPressed: () {
                    Get.bottomSheet(PadelDatePicker(
                        padel: widget.padel,
                        onDatePicked: (d) {
                          setState(() {
                            controller.date.value = d;
                          });
                          Get.back();
                        },
                        date: controller.date.value));
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
                          controller.date.value.day == DateTime.now().day
                              ? "Today"
                              : DateFormat.yMMMd()
                                  .format(controller.date.value),
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
        Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SchedulesCard(
                padel: widget.padel,
                cols: 3,
                onClick: (x) {
                  controller.date.value = x;
                },
                date: controller.date.value,
                onDateSelected: () {},
              ),
            )),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
              // border: Border.fromBorderSide(BorderSide())
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.padel.price} KD',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10)),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => CheckoutPage(
                          padel: widget.padel,
                          time: controller.date.value,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Pay Now",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white)),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward),
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }
}
