import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/core/presentation/widgets/drop.down.form.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:bandeja/src/core/presentation/widgets/text.input.form.dart';
import 'package:bandeja/src/core/utils/util.dart';
import 'package:bandeja/src/owner/presentation/promo_code/controllers/edit.promo.code.bottom.sheet.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class EditPromoCodeBottomSheet extends StatefulWidget {
  const EditPromoCodeBottomSheet({Key? key, required this.promoCode})
      : super(key: key);
  final PromoCodeModel promoCode;
  @override
  State<EditPromoCodeBottomSheet> createState() =>
      _EditPromoCodeBottomSheetState();
}

class _EditPromoCodeBottomSheetState extends State<EditPromoCodeBottomSheet> {
  late EditPromoCodeBottomSheetController controller;
  @override
  void initState() {
    controller =
        Get.put(EditPromoCodeBottomSheetController(promo: widget.promoCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 0),
                      color: Theme.of(context).dividerColor,
                      width: 60,
                      height: 6,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Edit promo code",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        '${((controller.promo.value.maxBooking - (controller.promo.value.leftForBooking ?? 0)) > 0) ? ' ${controller.promo.value.maxBooking - (controller.promo.value.leftForBooking ?? 0)} peoples' : 'No one'} have used this promo code so far',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextInputForm(
                          label: 'Promo',
                          placeholder: 'write the promo code',
                          elevation: 1,
                          radius: 12,
                          enabled: false,
                          validator: (value) => Util.validateNoEmpty(value),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          initialValue: controller.promo.value.code,
                          onChanged: (val) {
                            controller.promo.value.code = val;
                            setState(() {});
                          }),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Obx(() => controller.padels.value.when(
                          emptyState: () => const SizedBox(),
                          loadingState: (_) => const SizedBox(),
                          loadedState: (value) => DropDownForm(
                                value: controller.padel.value?.name,
                                placeholder: 'Selected Court',
                                enabled: false,
                                onChange: (_, dynamic value) {
                                  controller.padel.value =
                                      (value as PadelModel);
                                },
                                options: (value as List<PadelModel>)
                                    .map((e) => {e.name: e})
                                    .toList(),
                                label: 'Court',
                                elevation: 1,
                                radius: 14,
                                validator: (_) => Util.validateNoEmpty(
                                    controller.padel.value),
                              ),
                          errorState: (failure) =>
                              ShowError(failure: failure))),
                    ),
                    const SizedBox(height: 20),
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextInputForm(
                              label: 'Discount Percent',
                              placeholder: '00',
                              error: null,
                              elevation: 1,
                              radius: 12,
                              enabled: widget.promoCode.maxBooking ==
                                  widget.promoCode.leftForBooking,
                              suffixText: '%',
                              validator: (_) => Util.validateGreaterThan(
                                  controller.promo.value.discount, 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              initialValue:
                                  (controller.promo.value.discount ?? 0)
                                      .toString(),
                              onChanged: (change) {
                                controller.promo.value.discount =
                                    double.tryParse(change) ?? 0;
                              }),
                        )),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booking',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 48,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: const Alignment(0, -1),
                                  child: SizedBox(
                                    height: 30,
                                    child: SfSlider(
                                      min: 0,
                                      max:
                                          controller.promo.value.leftForBooking,
                                      value: controller.promo.value.maxBooking,
                                      interval: 1,
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      inactiveColor: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.1),
                                      showTicks: false,
                                      showLabels: false,
                                      thumbIcon: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        child: Container(
                                          width: 1,
                                          height: 1,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        ),
                                      ),
                                      enableTooltip: false,
                                      tooltipShape:
                                          const SfRectangularTooltipShape(),
                                      minorTicksPerInterval: 1,
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          controller.promo.value.maxBooking =
                                              (value as double).toInt();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment(
                                      (-1 +
                                          (2 *
                                              (controller
                                                      .promo.value.maxBooking /
                                                  (controller.promo.value
                                                          .leftForBooking ??
                                                      100)))),
                                      1),
                                  child: Text(
                                    '${controller.promo.value.maxBooking} Booking',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30, bottom: 10),
                        child: Obx(() => BigTextButton(
                              onClick: () {
                                controller.addPromo();
                              },
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              isLoading: controller.loading.value,
                              text: 'Save',
                            )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}