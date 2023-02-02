import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/main/presentation/booking/controllers/checkout.page.controller.dart';
import 'package:bandeja/src/owner/presentation/promo_code/widgets/owner.promo.code.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_upayments/flutter_upayments.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/presentation/widgets/text.input.form.dart';
import '../../../core/presentations/widgets/padel.card.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {Key? key, required this.padel, required this.schedule, this.givenOrder})
      : super(key: key);
  final PadelModel padel;
  final PadelScheduleModel schedule;
  final PadelOrderModel? givenOrder;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CheckoutPageController controller;

  @override
  void initState() {
    controller = Get.put(CheckoutPageController(widget.padel, widget.schedule,
        givenOrder: widget.givenOrder));
    controller.loading.value = false;
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CheckoutPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _appBar(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    color: Colors.white,
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: PadelCard(item: widget.padel),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _item(
                                "Date",
                                DateFormat("d/MM/yyyy")
                                    .format(widget.schedule.startTime)),
                            _item(
                                "Time",
                                DateFormat.jm()
                                    .format(widget.schedule.startTime)),
                            _item("Location", widget.padel.getAddress().name),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Obx(() => (controller.promoCode.value != null)
                      ? OwnerPromoCodeCard(
                          onClick: (_) {},
                          promo: controller.promoCode.value,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: TextInputForm(
                              label: 'Promo Code',
                              placeholder: '',
                              error: null,
                              elevation: 1,
                              radius: 12,
                              suffixIcon: controller.promoCodeLoading.value
                                  ? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        controller.checkForPromoValidity(
                                            controller.promo.value);
                                      },
                                      child: Text(
                                        'Apply',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                      ),
                                    ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              initialValue: controller.promo.value,
                              onChanged: (change) {
                                controller.promo.value = change;
                              }),
                        )),
                ],
              ),
            ),
            if (MediaQuery.of(context).viewInsets.bottom == 0)
              Align(
                alignment: Alignment.bottomCenter,
                child: _bottom(),
              )
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        )
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "Checkout",
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.w400),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
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

  Widget _bottom() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 80,
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
              Padding(
                padding: EdgeInsets.only(
                    top: (controller.promoCode.value != null) ? 10 : 0),
                child: Text(
                  'Total',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.promoCode.value != null)
                        Text(
                          '${widget.schedule.price ?? widget.padel.price} KD',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Text(
                        controller.promoCode.value == null
                            ? '${widget.schedule.price ?? widget.padel.price} KD'
                            : '${(widget.schedule.price ?? widget.padel.price) - ((widget.schedule.price ?? widget.padel.price) * ((controller.promoCode.value?.discount ?? 0) / 100))} KD',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ],
                  )),
            ],
          ),
          Obx(() => BigTextButton(
                onClick: () {
                  controller.book(context);
                },
                isLoading: controller.loading.value,
                isExpanded: false,
                cornerRadius: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                textWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Pay Now",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFFFF00))),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
