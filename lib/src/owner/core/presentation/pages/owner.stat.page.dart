import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:bandeja/src/owner/core/presentation/controllers/owner.stat.page.controller.dart';
import 'package:bandeja/src/owner/data/dto/owner.weekly.stat.dto.dart';
import 'package:bandeja/src/owner/presentation/padels/widgets/select.padel.drop.down.dart';
import 'package:bandeja/src/owner/presentation/stats/pages/my.month.picker.dart';
import 'package:bandeja/src/owner/presentation/stats/widgets/owner.monthly.stat.dart';
import 'package:bargraph/bar.graph.dart';
import 'package:bargraph/dto/bar.dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OwnerStatPage extends StatefulWidget {
  const OwnerStatPage({Key? key}) : super(key: key);

  @override
  State<OwnerStatPage> createState() => _OwnerStatPageState();
}

class _OwnerStatPageState extends State<OwnerStatPage> {
  final controller = Get.put(OwnerStatPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => controller.ownerWeeklyStatDto.value.when(
                    emptyState: () => const SizedBox(),
                    loadingState: (_) => CustomShimmer(
                          show: true,
                          child: Text(
                            'Daily Statics',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                    loadedState: (value) => Text(
                          'Daily Statics',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                    errorState: (failure) => ShowError(failure: failure))),
                Obx(() => controller.padels.value.when(
                    emptyState: () => const SizedBox(),
                    loadingState: (_) => CustomShimmer(
                        show: true,
                        child: SelectPadelDropDown(
                            padels: const [null],
                            value: null,
                            onChanged: (_) {})),
                    loadedState: (value) => SelectPadelDropDown(
                        padels: value,
                        value: controller.pickedPadel.value,
                        onChanged: (val) => controller.pickedPadel.value = val),
                    errorState: (failure) => ShowError(failure: failure))),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.zero,
              child: Obx(() => controller.ownerWeeklyStatDto.value.when(
                  emptyState: () => const SizedBox(),
                  loadingState: (_) => BarGraph(
                      padding:
                          const EdgeInsets.only(top: 60, left: 10, right: 10),
                      bars: List.generate(
                          5,
                          (index) => BarDto(
                              value: null,
                              unselectedBarDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.grey.shade200),
                              title: DateFormat('EE').format(DateTime.now())))),
                  loadedState: (value) => BarGraph(
                        padding:
                            const EdgeInsets.only(top: 60, left: 10, right: 10),
                        bars: (value as List<OwnerWeeklyStatDto>)
                            .map((e) => BarDto(
                                toolTip: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                                'assets/icons/clock.png',
                                                color: Colors.white,
                                                width: 16,
                                                height: 16),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "${(e.totalHours ?? '0')} Hrs",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: Colors.white),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/icons/dollar-green-background.png',
                                              color: Colors.white,
                                              width: 16,
                                              height: 16,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "${(e.totalincome ?? '0')} KD",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: Colors.white),
                                            )
                                          ],
                                        )
                                      ]),
                                ),
                                unselectedBarDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.grey.shade200),
                                value: e.totalincome == null
                                    ? null
                                    : (e.totalincome!),
                                title: DateFormat('EE').format(
                                    e.date == null ? DateTime.now() : e.date!)))
                            .toList(),
                      ),
                  errorState: (failure) => ShowError(failure: failure)))),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Obx(() => controller.ownerMonthlyStatDto.value.when(
                  emptyState: () => const SizedBox(),
                  loadingState: (_) => OwnerMonthlyStat(
                        onDateClicked: () {},
                        date: null,
                        ownerMonthlyStatDto: null,
                      ),
                  loadedState: (value) => OwnerMonthlyStat(
                        ownerMonthlyStatDto: value,
                        date: controller.month.value.start,
                        onDateClicked: () {
                          controller.loadUser();
                          Get.bottomSheet(MyMonthPicker(
                              owner: controller.user.value,
                              month: controller.month.value,
                              onChange: (range) {
                                controller.month.value = range;
                                controller.getOwnerMonthlyStat();
                                Get.back();
                              }));
                        },
                      ),
                  errorState: (failure) => ShowError(failure: failure)))),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: Text(
          "Statistic",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leadingWidth: 56,
        elevation: 0,
        leading: null);
  }
}
