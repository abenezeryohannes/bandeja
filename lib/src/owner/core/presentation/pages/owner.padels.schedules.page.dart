import 'package:bandeja/src/owner/core/presentation/controllers/owner.padels.schedules.page.controller.dart';
import 'package:bandeja/src/owner/presentation/padels/widgets/owner.padel.with.schedule.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../../core/presentation/widgets/tab.bar.dart';
import '../../../../core/utils/util.dart';
import '../../../presentation/padels/widgets/padels.date.picker.dart';

class OwnerPadelsSchedulePage extends StatefulWidget {
  const OwnerPadelsSchedulePage({Key? key}) : super(key: key);

  @override
  State<OwnerPadelsSchedulePage> createState() =>
      _OwnerPadelsSchedulePageState();
}

class _OwnerPadelsSchedulePageState extends State<OwnerPadelsSchedulePage> {
  final controller = Get.put(OwnerPadelsSchedulePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.grey.shade100,
                  floating: true,
                  iconTheme: const IconThemeData(size: 0),
                  leadingWidth: 0,
                  leading: null,
                  collapsedHeight: 60,
                  expandedHeight: 100,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    title: _tabBar(),
                    titlePadding: EdgeInsets.zero,
                    expandedTitleScale: 1,
                    background: _appBar(),
                  ),
                ),
              ];
            },
            body: _body()));
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
            },
            child: PagedListView<int, PadelModel>(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<PadelModel>(
                  firstPageErrorIndicatorBuilder: (_) => ShowError(
                      failure: controller.pagingController.error as Failure),
                  firstPageProgressIndicatorBuilder: (_) => ListView(
                        shrinkWrap: true,
                        children: [
                          OwnerPadelWithScheduleCard(
                            onChange: () {},
                          ),
                          OwnerPadelWithScheduleCard(
                            onChange: () {},
                          ),
                          OwnerPadelWithScheduleCard(
                            onChange: () {},
                          ),
                          OwnerPadelWithScheduleCard(
                            onChange: () {},
                          ),
                          OwnerPadelWithScheduleCard(
                            onChange: () {},
                          ),
                          OwnerPadelWithScheduleCard(
                            onChange: () {},
                          ),
                          OwnerPadelWithScheduleCard(
                            onChange: () {},
                          ),
                        ],
                      ),
                  itemBuilder: (context, item, index) => Padding(
                        padding: EdgeInsets.only(
                            bottom: (index + 1 ==
                                    (controller.pagingController.itemList
                                            ?.length ??
                                        0))
                                ? 50
                                : 0),
                        child: OwnerPadelWithScheduleCard(
                          padel: item,
                          onChange: () {
                            controller.pagingController.refresh();
                          },
                        ),
                      )),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tabBar() {
    var tt = controller.times
        .map((e) => CircularTab(text: DateFormat('dd MMM').format(e)))
        .toList();
    tt.insert(0, CircularTab(text: 'Today'));
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CircularTabBar(
          onItemClick: (int index) {
            if (index == 0) {
              setState(() {
                controller.pickeddate.value = DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day);
              });
            } else {
              setState(() {
                controller.pickeddate.value = (controller.times[index - 1]);
              });
            }
          },
          tabs: tt,
          value: controller.times.indexOf(controller.pickeddate.value) + 1,
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "My Courts",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(),
      actions: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton(
                onPressed: () {
                  controller.loadUser();
                  Get.bottomSheet(PadelsDatePicker(
                      owner: controller.user.value,
                      onDatePicked: (d) {
                        setState(() {
                          controller.pickeddate.value = d;
                          controller.times = Util.dates(d);
                        });
                        Get.back();
                      },
                      date: controller.pickeddate.value));
                },
                icon: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/icons/calendar_nav.png',
                    width: 20,
                    height: 20,
                    color: Colors.grey.shade700,
                  ),
                )))
      ],
    );
  }
}
