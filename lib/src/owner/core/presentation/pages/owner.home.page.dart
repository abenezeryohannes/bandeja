import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/owner/core/presentation/controllers/owner.home.page.controller.dart';
import 'package:bandeja/src/owner/presentation/booking/pages/owner.qr.modal.dart';
import 'package:bandeja/src/owner/presentation/padels/pages/owner.booking.page.dart';
import 'package:bandeja/src/owner/presentation/padels/pages/qr.scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../presentation/booking/widgets/owner.booking.card.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({Key? key}) : super(key: key);

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  OwnerHomePageController controller = Get.put(OwnerHomePageController());
  @override
  Widget build(BuildContext context) {
    // GetStorage().write('token',
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImZ1bGxOYW1lIjoiTW9oYW1tYWQiLCJhdmF0YXIiOm51bGwsIlVJRCI6IjZXbnlNMTUzb3FPYTUzM2xZMlZndUVFMlZEQTMiLCJlbWFpbEFkZHJlc3MiOiJhYmVuZXplcnlvaGFubmVzQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiQWI5MTEjOTExKiIsInJvbGUiOiJvd25lci');
    // GetStorage().write('token', 'owner4');
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
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: _search(),
                    ),
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
        Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
            child: Obx(() => _tabs())),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
            },
            child: PagedListView<int, PadelOrderModel?>(
              shrinkWrap: true,
              pagingController: controller.pagingController,
              padding: EdgeInsets.zero,
              builderDelegate: PagedChildBuilderDelegate<PadelOrderModel?>(
                  firstPageErrorIndicatorBuilder: (_) => ShowError(
                      failure: controller.pagingController.error as Failure),
                  firstPageProgressIndicatorBuilder: (_) => ListView(
                        shrinkWrap: true,
                        children: [
                          OwnerBookingCard(onClick: (_) {}),
                          OwnerBookingCard(onClick: (_) {}),
                          OwnerBookingCard(onClick: (_) {}),
                          OwnerBookingCard(onClick: (_) {}),
                          OwnerBookingCard(onClick: (_) {}),
                          OwnerBookingCard(onClick: (_) {}),
                        ],
                      ),
                  itemBuilder: (context, item, index) => _item(index, item)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _item(int index, PadelOrderModel? item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index == 0 ||
            (index > 0 &&
                (controller.pagingController.itemList?[index - 1]!.paymentDate
                        ?.day !=
                    item!.paymentDate?.day)))
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              DateFormat('dd MMM').format(item?.paymentDate ?? DateTime.now()),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w900),
            ),
          ),
        Padding(
          padding: index !=
                  (controller.pagingController.value.itemList?.length ?? 1) - 1
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.only(bottom: 100),
          child: OwnerBookingCard(
              order: item,
              onClick: (order) {
                Get.to(OwnerBookingPage(order: order));
              }),
        ),
      ],
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        "Home",
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
                onPressed: () async {
                  final result = await Get.to<String?>(() => const QRScanner());
                  if (result != null) {
                    Get.dialog(Container(
                        margin: EdgeInsets.only(
                            top: Get.height * 1 / 10,
                            bottom: Get.height * 1 / 5),
                        child: Center(
                            child: OwnerQrModal(
                          qrCode: result,
                        ))));
                  } else {
                    AppSnackBar.error(message: 'No Qr code read!');
                  }
                },
                icon: Image.asset(
                  'assets/icons/barcode.png',
                  width: 24,
                  height: 24,
                )))
      ],
    );
  }

  Widget _search() {
    return Material(
      elevation: 0.5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.phone,
        maxLines: 1,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 24,
            color: Theme.of(context).hintColor.withOpacity(0.4),
          ),
          hintText: 'Search by Mobile Number',
          filled: true,
          fillColor: Colors.grey.shade100,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        ),
        onChanged: (val) {
          if (val.isEmpty) {
            controller.search.value = null;
          } else {
            controller.search.value = val;
          }
        },
      ),
    );
  }

  Widget _tabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextButton(
            onPressed: () {
              DateTime date = DateTime.now();
              controller.startTime.value =
                  DateTime(date.year, date.month, date.day, 0, 0, 0);
              controller.endTime.value =
                  DateTime(date.year, date.month, date.day, 24, 24, 24);
            },
            child: Text('Today Booking',
                style: controller.endTime.value != null
                    ? Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold)
                    : Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey.shade400,
                        ))),
        TextButton(
            onPressed: () {
              DateTime date = DateTime.now();
              controller.startTime.value =
                  DateTime(date.year, date.month, date.day, 24, 24, 24);
              controller.endTime.value = null;
            },
            child: Text('Next Days',
                style: controller.endTime.value == null
                    ? Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold)
                    : Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey.shade400,
                        )))
      ],
    );
  }
}
