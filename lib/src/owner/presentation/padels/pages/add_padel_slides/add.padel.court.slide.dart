import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/data/authentication/dto/location.dto.dart';
import '../../../../../core/network/api.dart';
import '../../../../../core/presentation/pages/location.picker.dart';
import '../../../../../core/presentation/widgets/big.text.button.dart';
import '../../../../../core/presentation/widgets/drop.down.form.dart';
import '../../../../../core/presentation/widgets/show.error.dart';
import '../../../../../core/presentation/widgets/text.input.form.dart';
import '../../../../../core/utils/util.dart';
import '../../../../../main/domain/core/entities/address.dart';
import '../../controllers/add.padel.page.controller.dart';
import '../../widgets/add.padel.images.dart';

class AddPadelCourtSlide extends StatefulWidget {
  const AddPadelCourtSlide({Key? key, required this.controller})
      : super(key: key);
  final AddPadelPageController controller;
  @override
  State<AddPadelCourtSlide> createState() => _AddPadelCourtSlideState();
}

class _AddPadelCourtSlideState extends State<AddPadelCourtSlide> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.controller.formKeyCourt,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Obx(() => AddPadelImages(
                  localAvatarImage:
                      widget.controller.padelDto.value.avatarLocalImage,
                  localBannerImage:
                      widget.controller.padelDto.value.bannerLocalImage,
                  avatarImageLink: widget.controller.padelDto.value.avatar,
                  bannerImageLink: widget.controller.padelDto.value.banner,
                  uploadAvatar: (String path) {
                    widget.controller.padelDto.value.avatarLocalImage = path;
                    widget.controller.padelDto.refresh();
                  },
                  uploadBanner: (String path) {
                    setState(() {
                      widget.controller.padelDto.value.bannerLocalImage = path;
                    });
                  },
                  avatarLoading: (bool loading) {
                    widget.controller.loading.value = loading;
                  },
                  bannerLoading: (bool loading) {
                    widget.controller.loading.value = loading;
                  },
                )),
          ),
          //----------court title and location-------------//

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextInputForm(
                label: 'Court title',
                placeholder: 'write the court title',
                elevation: 1,
                radius: 12,
                validator: (value) => Util.validateNoEmpty(value),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                initialValue: widget.controller.padelDto.value.name,
                onChanged: (val) {
                  widget.controller.padelDto.value.name = val;
                  setState(() {});
                }),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 16),
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Obx(() => widget.controller.addresses.value.when(
                      emptyState: () => const SizedBox(),
                      loadingState: (_) => const SizedBox(),
                      loadedState: (value) => SizedBox(
                            child: DropDownForm(
                              value:
                                  widget.controller.addressPicked.value?.name,
                              placeholder: 'choose court location',
                              onChange: (_, dynamic value) {
                                widget.controller.addressPicked.value =
                                    (value as AddressModel);
                              },
                              validator: (_) => Util.validateNoEmpty(
                                  widget.controller.addressPicked.value?.name),
                              options: (value as List<AddressModel>)
                                  .map((e) => {e.name: e})
                                  .toList(),
                              label: 'Court Location',
                              elevation: 1,
                              radius: 14,
                            ),
                          ),
                      errorState: (failure) => ShowError(failure: failure))),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 2,
                  child: Obx(() => widget.controller.durations.value.when(
                      emptyState: () => const SizedBox(),
                      loadingState: (_) => const SizedBox(),
                      loadedState: (value) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigTextButton(
                                onClick: () async {
                                  final result = await Get.to<LocationDto?>(
                                      () => const LocationPicker());
                                  if (result != null) {
                                    widget.controller.padelDto.value
                                        .locationDto = result;
                                    setState(() {});
                                  }
                                },
                                backgroudColor: Colors.grey.shade50,
                                cornerRadius: 10,
                                borderColor: Colors.grey.shade400,
                                borderWidth: 0,
                                isExpanded: false,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                horizontalMargin: EdgeInsets.zero,
                                elevation: 1,
                                textWidget: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'location',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                              ),
                              if (widget.controller.validated.value >= 1 &&
                                  widget.controller.padelDto.value
                                          .locationDto ==
                                      null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  child: Text(
                                    'Required Field!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.red),
                                  ),
                                )
                            ],
                          ),
                      errorState: (failure) => ShowError(failure: failure))),
                ),
              ],
            ),
          ),
          //----------court categories-------------//
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Text(
              'Court Category',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0, bottom: 20),
            child: Text(
              'Your court will appear in search section.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0)
            Row(
              children: [
                const SizedBox(
                  width: 22,
                ),
                _item(
                    asset: 'assets/icons/indoor.png',
                    text: 'Indoor',
                    onClick: () {
                      setState(() {
                        widget.controller.padelDto.value.indoor = true;
                      });
                    },
                    isSelected: widget.controller.padelDto.value.indoor),
                const SizedBox(
                  width: 20,
                ),
                _item(
                    asset: 'assets/icons/outdoor.png',
                    text: 'Outdoor',
                    onClick: () {
                      setState(() {
                        widget.controller.padelDto.value.indoor = false;
                      });
                    },
                    isSelected: !widget.controller.padelDto.value.indoor),
                const SizedBox(
                  width: 20,
                ),
                _item(
                    asset: 'assets/icons/ladies.png',
                    text: 'Ladies',
                    onClick: () {
                      setState(() {
                        widget.controller.padelDto.value.onlyLadies =
                            !(widget.controller.padelDto.value.onlyLadies);
                      });
                    },
                    isSelected: widget.controller.padelDto.value.onlyLadies)
              ],
            )
        ]),
      ),
    );
  }

  Widget _item(
      {required bool isSelected,
      required Function onClick,
      required String text,
      String? asset,
      String? img}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey.shade400, width: isSelected ? 0 : 2),
                color: isSelected
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: (asset != null)
                ? Image.asset(
                    asset,
                    color: isSelected ? Colors.white : Colors.grey.shade400,
                    width: 48,
                    height: 48,
                  )
                : (img != null)
                    ? Image.network(
                        Api.getMedia(img),
                        color: isSelected ? Colors.white : Colors.grey.shade400,
                        width: 48,
                        height: 48,
                      )
                    : const SizedBox(),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
              color: (isSelected) ? Colors.black : Colors.grey.shade400),
        )
      ],
    );
  }
}
