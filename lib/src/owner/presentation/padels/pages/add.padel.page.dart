import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/owner/presentation/padels/controllers/add.padel.page.controller.dart';
import 'package:bandeja/src/owner/presentation/padels/pages/add_padel_slides/add.padel.court.slide.dart';
import 'package:bandeja/src/owner/presentation/padels/pages/add_padel_slides/add.padel.setting.slide.dart';
import 'package:bandeja/src/owner/presentation/padels/pages/add_padel_slides/add.padel.timing.slide.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_stepper/status_stepper.dart';

import '../../../../core/domain/padels/entities/padel.dart';

class AddPadelPage extends StatefulWidget {
  const AddPadelPage({Key? key, this.padel}) : super(key: key);
  final PadelModel? padel;
  @override
  State<AddPadelPage> createState() => _AddPadelPageState();
}

class _AddPadelPageState extends State<AddPadelPage> {
  late AddPadelPageController controller;
  @override
  void initState() {
    controller = Get.put(AddPadelPageController(padel: widget.padel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(controller.moveBack());
      },
      child: Scaffold(
        appBar: _appBar(),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Column(
                        children: [
                          Obx(() => StatusStepper(
                                connectorCurve: Curves.easeIn,
                                itemCurve: Curves.easeOut,
                                activeColor:
                                    Theme.of(context).colorScheme.secondary,
                                disabledColor: Colors.grey.shade400,
                                animationDuration:
                                    const Duration(milliseconds: 500),
                                lastActiveIndex: controller.lastIndex.value,
                                currentIndex: controller.curIndex.value,
                                connectorThickness: 6,
                                children: controller.statuses,
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Court',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade500),
                              ),
                              Text(
                                'Settings',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade500),
                              ),
                              Text(
                                'Timing',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade500),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    //--------------stepper end------------------//
                    ExpandablePageView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageViewController,
                      children: [
                        AddPadelCourtSlide(controller: controller),
                        AddPadelSettingSlide(controller: controller),
                        AddPadelTimingSlide(controller: controller),
                      ],
                    )
                  ],
                ),
              ),
              if (MediaQuery.of(context).viewInsets.bottom == 0)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Obx(() => BigTextButton(
                          onClick: () {
                            controller.moveNext(context);
                          },
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          isLoading: controller.loading.value,
                          text: "Next",
                        )),
                  ),
                )
            ],
          ),
        ),
        // body: DotStepper(activeStep: 0)
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "Court Settings",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(
          margin: const EdgeInsets.only(top: 14, bottom: 14, left: 25),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1, color: Colors.grey.shade600)),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.chevron_left,
              size: 24,
              color: Colors.black,
            ),
          )),
    );
  }
}
