import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/main/presentation/booking/controllers/my.booking.page.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../core/presentations/widgets/padel.card.dart';
import '../../padels/pages/booking.page.dart';
import '../widgets/checkout.items.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  State<MyBookingPage> createState() => My_BookingPageState();
}

class My_BookingPageState extends State<MyBookingPage> {
  final controller = Get.put(MyBookingPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.pagingController.refresh();
              },
              child: PagedListView<int, PadelOrderModel?>(
                shrinkWrap: true,
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<PadelOrderModel?>(
                    firstPageErrorIndicatorBuilder: (_) => ShowError(
                        failure: controller.pagingController.error as Failure),
                    firstPageProgressIndicatorBuilder: (_) => ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          children: [
                            _item(),
                            _item(),
                            _item(),
                            _item(),
                            _item()
                          ],
                        ),
                    itemBuilder: (context, item, index) => Card(
                        elevation: 1.5,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                            bottom: (index ==
                                    (controller.pagingController.itemList
                                                ?.length ??
                                            0) -
                                        1)
                                ? 50
                                : 10),
                        child: _item(order: item))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "My Booking",
        style: Theme.of(context).textTheme.titleMedium,
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

  Widget _item({PadelOrderModel? order}) {
    return InkWell(
      onTap: () {
        if (order == null) return;
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false, // set to false
            pageBuilder: (_, __, ___) => BookingPage(
              padel: order.getPadel(),
              order: order,
            ),
          ),
        );
      },
      child: Column(children: [
        PadelCard(item: order?.getPadel()),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 16),
          child: CheckoutItems(
              padel: order?.getPadel(), time: order?.getSchedule().startTime),
        ),
        const SizedBox(
          height: 10,
        )
      ]),
    );
  }
}
