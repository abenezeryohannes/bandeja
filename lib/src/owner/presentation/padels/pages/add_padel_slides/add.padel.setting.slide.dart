import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:bandeja/src/core/domain/padels/entities/feature.dart';
import 'package:bandeja/src/core/presentation/pages/location.picker.dart';
import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:bandeja/src/owner/data/padels/dto/padel.feature.dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../../../../core/data/authentication/dto/location.dto.dart';
import '../../../../../core/network/api.dart';
import '../../controllers/add.padel.page.controller.dart';

class AddPadelSettingSlide extends StatefulWidget {
  const AddPadelSettingSlide({Key? key, required this.controller})
      : super(key: key);
  final AddPadelPageController controller;

  @override
  State<AddPadelSettingSlide> createState() => _AddPadelSettingSlideState();
}

class _AddPadelSettingSlideState extends State<AddPadelSettingSlide> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.controller.formKeySetting,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Text(
                'Court Features',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 5, right: 20),
              child: Text(
                'Choose up to 6 features.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20, right: 20),
              child: Text(
                'Double tap if its a paid feature and single tap if its provided free.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.blue.shade900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Obx(() => widget.controller.features.value.when(
                  emptyState: () => const SizedBox(),
                  loadingState: (_) => const SizedBox(),
                  loadedState: (value) => Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: _featureItems(value as List<FeatureModel?>)),
                  errorState: (failure) => ShowError(failure: failure))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20, top: 40),
              child: Text(
                'Booking Duration',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Obx(() => widget.controller.durations.value.when(
                  emptyState: () => const SizedBox(),
                  loadingState: (_) => const SizedBox(),
                  loadedState: (value) => Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: _durationItems(value as List<DurationModel?>)),
                  errorState: (failure) => ShowError(failure: failure))),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _featureItems(List<FeatureModel?> features) {
    return List<Widget>.generate(features.length, (index) {
      bool isNull = features[index] == null;
      bool selected =
          (!isNull && widget.controller.containsFeature(features[index]!));
      bool isFree =
          (selected) ? widget.controller.isFeatureFree(features[index]!) : true;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onDoubleTap: () {
              if (isNull) return;
              widget.controller.removeFeature(features[index]!);
              widget.controller.pickedFeatures.value.add(PadelFeatureDto.empty(
                  featureId: features[index]!.id, free: false));
              setState(() {});
            },
            onTap: () {
              if (isNull) return;
              if (widget.controller.containsFeature(features[index]!)) {
                widget.controller.removeFeature(features[index]!);
              } else {
                widget.controller.pickedFeatures.value.add(
                    PadelFeatureDto.empty(
                        featureId: features[index]!.id, free: true));
              }
              setState(() {});
            },
            child: Container(
              width: 70,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: selected
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.1)
                      : Colors.grey.shade100),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Image.network(
                      !isNull
                          ? Api.getMedia(features[index]!.icon)
                          : 'img/placeholder.jpg',
                      width: 30,
                      height: 30,
                      color: selected
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.grey,
                    ),
                  ),
                  if (!isFree)
                    const Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.green,
                          size: 24,
                        ))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            !isNull ? features[index]!.name : '.....',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.black : Colors.grey.shade400,
                backgroundColor: isNull ? Colors.grey : Colors.transparent),
          )
        ],
      );
    });
  }

  List<Widget> _durationItems(List<DurationModel?> durations) {
    return List<Widget>.generate(durations.length, (index) {
      bool isNull = durations[index] == null;
      bool selected = (!isNull &&
          widget.controller.pickedDuration.value == durations[index]!);
      return InkWell(
        onTap: () {
          if (isNull) return;
          widget.controller.pickedDuration.value = durations[index];
          widget.controller.pickedDuration.refresh();
        },
        child: Container(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    width: 1,
                    color: (selected)
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey),
                color:
                    selected ? Theme.of(context).colorScheme.secondary : null),
            child: Text(
              !isNull ? "${durations[index]!.minute} min" : '.....',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.grey.shade400,
                  backgroundColor: isNull ? Colors.grey : Colors.transparent),
            )),
      );
    });
  }
}
