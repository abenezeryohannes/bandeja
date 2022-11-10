import 'package:bandeja/src/admin/presentation/booking/page/admin.booking.page.dart';
import 'package:bandeja/src/admin/presentation/booking/widgets/admin.booking.card.dart';
import 'package:bandeja/src/admin/presentation/notification/pages/notification.bottom.sheet.dart';
import 'package:bandeja/src/owner/presentation/booking/pages/owner.qr.modal.dart';
import 'package:bandeja/src/owner/presentation/padels/pages/qr.scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/drop.down.form.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../../core/utils/util.dart';
import '../controllers/admin.home.page.controller.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  AdminHomePageController controller = Get.put(AdminHomePageController());
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
            child: _tabs()),
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
                          AdminBookingCard(onClick: (_) {}),
                          AdminBookingCard(onClick: (_) {}),
                          AdminBookingCard(onClick: (_) {}),
                          AdminBookingCard(onClick: (_) {}),
                          AdminBookingCard(onClick: (_) {}),
                          AdminBookingCard(onClick: (_) {}),
                        ],
                      ),
                  itemBuilder: (context, item, index) => _item(index, item)),
            ),
          ),
        )
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
        AdminBookingCard(
            order: item,
            onClick: (order) {
              Get.to(AdminBookingPage(order: order));
            }),
      ],
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        "Home",
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
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
                  Get.bottomSheet(const NotificationBottomSheet(),
                      isScrollControlled: true);
                },
                icon: Image.asset(
                  'assets/icons/message.png',
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
        Text('Booking',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(() => controller.padels.value.when(
              emptyState: () => const SizedBox(),
              loadingState: (_) => const SizedBox(),
              loadedState: (value) => DropDownForm(
                    value: controller.padel.value?.name,
                    placeholder: 'All Courts',
                    onChange: (_, dynamic value) {
                      if ((value as PadelModel).id > 0) {
                        controller.padel.value = value;
                      } else {
                        controller.padel.value = null;
                      }
                    },
                    options: (value as List<PadelModel>)
                        .map((e) => {e.name: e})
                        .toList(),
                    label: 'Court',
                    elevation: 1,
                    radius: 14,
                    validator: (_) =>
                        Util.validateNoEmpty(controller.padel.value),
                  ),
              errorState: (failure) => ShowError(failure: failure))),
        ),
      ],
    );
  }
}
