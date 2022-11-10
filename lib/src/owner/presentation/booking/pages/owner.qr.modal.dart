import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:bandeja/src/main/presentation/booking/widgets/checkout.items.dart';
import 'package:bandeja/src/main/presentation/home/widget/padel.avatar.dart';
import 'package:bandeja/src/owner/presentation/booking/controllers/owner.qr.modal.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';

class OwnerQrModal extends StatefulWidget {
  const OwnerQrModal({Key? key, required this.qrCode}) : super(key: key);
  final String qrCode;
  @override
  State<OwnerQrModal> createState() => _OwnerQrModalState();
}

class _OwnerQrModalState extends State<OwnerQrModal> {
  late OwnerQrModalController controller;
  @override
  void initState() {
    controller = OwnerQrModalController(qrCode: widget.qrCode);
    controller.getOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin:
              const EdgeInsets.only(top: 45, left: 30, right: 30, bottom: 60),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Obx(() => controller.order.value.when(
                    emptyState: () => const SizedBox(),
                    loadingState: (_) => const SizedBox(),
                    loadedState: (_) => const SizedBox(),
                    errorState: (failure) => Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  failure.message ??
                                      'Sorry, something went wrong try again later.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(),
                                ),
                              ),
                            ],
                          ),
                        ))),
                Obx(() => controller.order.value.when(
                    emptyState: () => const SizedBox(),
                    loadingState: (_) => CustomShimmer(
                        show: true,
                        child: Text('.........',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(backgroundColor: Colors.grey))),
                    loadedState: (value) => Text(
                        _getTitle(value as PadelOrderModel),
                        style: Theme.of(context).textTheme.titleLarge),
                    errorState: (_) => const SizedBox())),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => controller.order.value.when(
                    emptyState: () => const SizedBox(),
                    loadingState: (_) => CustomShimmer(
                        show: true,
                        child: Text('.........',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(backgroundColor: Colors.grey))),
                    loadedState: (value) => Text(
                        (value as PadelOrderModel).getPadel().name,
                        style: Theme.of(context).textTheme.caption),
                    errorState: (_) => const SizedBox())),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Obx(() => controller.order.value.when(
                      emptyState: () => const SizedBox(),
                      loadingState: (_) => const CheckoutItems(),
                      loadedState: (value) => CheckoutItems(
                          padel: (value as PadelOrderModel).getPadel(),
                          time: (value).getSchedule().startTime),
                      errorState: (_) => const SizedBox())),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Obx(() => controller.order.value.when(
                      emptyState: () => const SizedBox(),
                      loadingState: (_) => CustomShimmer(
                            show: true,
                            child: QrImage(
                              data: widget.qrCode,
                              version: QrVersions.auto,
                              size:
                                  MediaQuery.of(context).size.height * (2 / 10),
                              gapless: false,
                            ),
                          ),
                      loadedState: (value) => QrImage(
                            data: (value as PadelOrderModel).barCode ??
                                widget.qrCode,
                            version: QrVersions.auto,
                            size: MediaQuery.of(context).size.height * (2 / 10),
                            gapless: false,
                          ),
                      errorState: (_) => const SizedBox())),
                )
              ]),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Obx(() => controller.order.value.when(
                emptyState: () => const SizedBox(),
                loadingState: (_) => PadelAvatar(
                      borderColor: Colors.white,
                      radius: 40,
                      margins: EdgeInsets.zero,
                      onClick: () {},
                    ),
                loadedState: (value) => PadelAvatar(
                      borderColor: Colors.white,
                      radius: 40,
                      margins: EdgeInsets.zero,
                      onClick: () {},
                      item: (value as PadelOrderModel).getPadel(),
                    ),
                errorState: (_) => const SizedBox()))),
        Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() => controller.order.value.when(
                emptyState: () => const SizedBox(),
                loadingState: (_) => BigTextButton(
                      onClick: () {},
                      cornerRadius: 12,
                      horizontalMargin:
                          const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      isLoading: true,
                    ),
                loadedState: (value) {
                  if (!(value as PadelOrderModel).enabled) {
                    return const SizedBox();
                  }
                  if (value.paymentId == null && value.status != 'confirmed') {
                    return BigTextButton(
                      onClick: () {
                        controller.editOrder(value);
                      },
                      cornerRadius: 12,
                      horizontalMargin:
                          const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      text: 'Click to Confirm',
                    );
                  } else {
                    return BigTextButton(
                      onClick: () {},
                      cornerRadius: 12,
                      horizontalMargin:
                          const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 16, bottom: 16),
                      textWidget:
                          Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(value.status,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white))
                      ]),
                    );
                  }
                },
                errorState: (_) => const SizedBox())))
      ],
    );
  }

  String _getTitle(PadelOrderModel order) {
    if (order.getPadel().User != null) {
      return order.getPadel().User!.fullName;
    }
    return 'Unknown';
  }
}
