import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:bargraph/bar.graph.dart';
import 'package:bargraph/dto/bar.dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../owner/presentation/padels/widgets/select.padel.drop.down.dart';
import '../../../../owner/presentation/stats/pages/my.month.picker.dart';
import '../../../data/booking/dto/admin.weekly.stat.dto.dart';
import '../../../presentation/stats/widgets/admin.monthly.stat.dart';
import '../controllers/admin.stats.page.controller.dart';

class AdminStatsPage extends StatefulWidget {
  const AdminStatsPage({Key? key}) : super(key: key);

  @override
  State<AdminStatsPage> createState() => _AdminStatsPageState();
}

class _AdminStatsPageState extends State<AdminStatsPage> {
  final controller = Get.put(AdminStatsPageController());

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
                Obx(() => controller.adminWeeklyStatDto.value.when(
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
                    errorState: (_) => const SizedBox())),
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
                    errorState: (_) => const SizedBox())),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.zero,
              child: Obx(() => controller.adminWeeklyStatDto.value.when(
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
                        bars: (value as List<AdminWeeklyStatDto>)
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
                  errorState: (_) => const SizedBox()))),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Obx(() => controller.adminMonthlyStatDto.value.when(
                  emptyState: () => const SizedBox(),
                  loadingState: (_) => AdminMonthlyStat(
                        onDateClicked: () {},
                        date: null,
                        adminMonthlyStatDto: null,
                      ),
                  loadedState: (value) => AdminMonthlyStat(
                        adminMonthlyStatDto: value,
                        date: controller.month.value.start,
                        onDateClicked: () {
                          controller.loadUser();
                          Get.bottomSheet(MyMonthPicker(
                            month: controller.month.value,
                            onChange: (range) {
                              controller.month.value = range;
                              controller.getAdminMonthlyStat();
                              Get.back();
                            },
                            owner: controller.user.value,
                          ));
                        },
                      ),
                  errorState: (failure) => ShowError(
                        failure: failure,
                        errorShowType: ErrorShowType.vertical,
                      )))),
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
