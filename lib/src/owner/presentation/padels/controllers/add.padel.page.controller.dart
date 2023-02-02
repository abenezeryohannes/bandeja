import 'package:bandeja/src/core/domain/padels/entities/feature.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/owner/data/bookings/dto/padel.schedule.dto.dart';
import 'package:bandeja/src/owner/data/padels/dto/padel.dto.dart';
import 'package:bandeja/src/owner/data/padels/dto/padel.feature.dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/duration.dart';
import '../../../../core/domain/padels/entities/padel.group.dart';
import '../../../../core/domain/padels/repositories/i.padel.group.repository.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/util.dart';
import '../../../../main/domain/core/entities/address.dart';
import '../../../../main/domain/core/repositories/i.address.repository.dart';
import '../../../domain/padels/i.owner.padel.repository.dart';

class AddPadelPageController extends GetxController {
  AddPadelPageController({PadelModel? padel}) {
    if (padel != null) {
      padelDto = Rx<PadelDto>(PadelDto.fromPadelModel(padel));
      padelScheduleDtos =
          Rx<List<PadelScheduleDto>>(padelDto.value.padelSchedules);
      pickedFeatures =
          Rx<List<PadelFeatureDto>>(padelDto.value.padelFeatureDto);
    }
  }

  final pageViewController = PageController(initialPage: 0);
  RxBool loading = false.obs;
  RxInt validated = 0.obs;
  final formKeyCourt = GlobalKey<FormState>();
  final formKeySetting = GlobalKey<FormState>();
  final formKeyTiming = GlobalKey<FormState>();

  RxInt curIndex = RxInt(0);
  RxInt lastIndex = RxInt(0);

  final statuses = List.generate(
    3,
    (index) => SizedBox.square(
      dimension: 24,
      child: Center(
          child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Container(
          width: 8,
          height: 8,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
      )),
    ),
  );

  Rx<PadelDto> padelDto = Rx<PadelDto>(PadelDto.empty());
  Rx<List<PadelFeatureDto>> pickedFeatures = Rx<List<PadelFeatureDto>>([]);
  Rx<List<PadelScheduleDto>> padelScheduleDtos = Rx<List<PadelScheduleDto>>([]);
  Rxn<DurationModel> pickedDuration = Rxn<DurationModel>();
  Rxn<PadelGroupModel> pickedGroup = Rxn<PadelGroupModel>();
  Rxn<AddressModel> addressPicked = Rxn<AddressModel>();

  final addressRepository = getIt<IAddressRepository>();
  final padelRepository = getIt<IOwnerPadelRepository>();
  final padelGroupRepository = getIt<IPadelGroupRepository>();

  Rx<WrapperDto<List<PadelGroupModel>>> padelGroups =
      Rx<WrapperDto<List<PadelGroupModel>>>(EmptyState());
  Rx<WrapperDto<List<AddressModel>>> addresses =
      Rx<WrapperDto<List<AddressModel>>>(WrapperDto.emptyState());
  Rx<WrapperDto<List<FeatureModel>>> features =
      Rx<WrapperDto<List<FeatureModel>>>(WrapperDto.emptyState());
  Rx<WrapperDto<List<DurationModel>>> durations =
      Rx<WrapperDto<List<DurationModel>>>(WrapperDto.emptyState());

  @override
  void onInit() {
    curIndex.value = 0;
    lastIndex.value = 0;
    loadAddresses();
    loadFeatures();
    loadDurations();
    super.onInit();
  }

  void loadAddresses({int? page}) async {
    addresses.value = WrapperDto<List<AddressModel>>.loadingState();
    final result = await addressRepository.getAddresses(limit: 200);
    if (result == null) {
      addresses.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => addresses.value = WrapperDto.errorState(failure: l),
          (r) {
        addresses.value = WrapperDto<List<AddressModel>>.loadedState(value: r);
        if ((padelDto.value.addressId ?? 0) > 0) {
          addressPicked.value = r
              .where((element) => element.id == padelDto.value.addressId!)
              .first;
        }
      });
    }
  }

  getPadelGroup() async {
    padelGroups.value = WrapperDto<List<PadelGroupModel>>.loadingState();
    final result = await padelGroupRepository.getPadelGroups();
    if (result == null) {
      padelGroups.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => padelGroups.value = WrapperDto.errorState(failure: l),
          (r) {
        if ((padelDto.value.padelGroupId ?? 0) > 0) {
          pickedGroup.value = r
              .where((element) => element.id == padelDto.value.padelGroupId!)
              .first;
        }
        padelGroups.value =
            WrapperDto<List<PadelGroupModel>>.loadedState(value: r);
      });
      ;
    }
  }

  void loadFeatures({int? page}) async {
    features.value = WrapperDto<List<FeatureModel>>.loadingState();
    final result = await padelRepository.getFeatures();
    if (result == null) {
      features.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => features.value = WrapperDto.errorState(failure: l),
          (r) {
        features.value = WrapperDto<List<FeatureModel>>.loadedState(value: r);
      });
    }
  }

  void loadDurations({int? page}) async {
    durations.value = WrapperDto<List<DurationModel>>.loadingState();
    final result = await padelRepository.getDurations();
    if (result == null) {
      durations.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => durations.value = WrapperDto.errorState(failure: l),
          (r) {
        if (r.isNotEmpty) {
          if ((padelDto.value.durationId ?? 0) > 0) {
            pickedDuration.value = r
                .where((element) => element.id == padelDto.value.durationId!)
                .first;
          } else {
            pickedDuration.value = r[0];
          }
        }
        durations.value = WrapperDto<List<DurationModel>>.loadedState(value: r);
      });
    }
  }

  bool moveBack() {
    if (curIndex.value > 0) {
      if (lastIndex.value < curIndex.value) {
        curIndex.value = lastIndex.value;
      } else {
        lastIndex.value = curIndex.value - 1;
        curIndex.value = lastIndex.value;
      }
      pageViewController.animateToPage(curIndex.value,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      return false;
    }
    return true;
  }

  void moveNext(BuildContext context) {
    if (curIndex.value == 0) {
      if (!validateCourt()) return;
    } else if (curIndex.value == 1) {
      if (!validateSettings()) return;
    } else {
      if (!validateTiming()) return;
      save(context);
    }
    if (curIndex.value >= statuses.length - 1) {
    } else {
      // if(curIndex.value==lastIndex.value)
      lastIndex.value = curIndex.value;
      curIndex.value = curIndex.value + 1;
    }
    pageViewController.animateToPage(curIndex.value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  bool validateCourt() {
    validated.value = 1;
    if ((formKeyCourt.currentState != null &&
        formKeyCourt.currentState!.validate() &&
        (padelDto.value.avatarLocalImage != null ||
            padelDto.value.avatar != null) &&
        padelDto.value.locationDto != null)) {
      return true;
    }
    if (padelDto.value.avatarLocalImage == null &&
        padelDto.value.avatar == null) {
      AppSnackBar.error(
          message: 'Court Image is required!', position: SnackPosition.TOP);
    }
    return false;
  }

  void generateSchedule() {
    if (padelDto.value.startTime == null ||
        padelDto.value.endTime == null ||
        pickedDuration.value == null) return;
    padelScheduleDtos.value = Util.getAllSchedules(pickedDuration.value!,
            padelDto.value.startTime!, padelDto.value.endTime!)
        .map((e) {
      e.price = padelDto.value.price;
      return e;
    }).toList();
  }

  void updateSchedulePrice() {
    if (padelScheduleDtos.value.isEmpty) return;
    padelScheduleDtos.value = padelScheduleDtos.value.map((e) {
      if (e.price == null || e.price! <= 0) {
        e.price = padelDto.value.price;
      }
      return e;
    }).toList();
  }

  void updateSchdule(PadelScheduleDto schedule) {
    List<PadelScheduleDto> temp = padelScheduleDtos.value;
    for (int i = 0; i < temp.length; i++) {
      if (temp[i].startTime == schedule.startTime) {
        temp[i] = schedule;
      }
    }
    padelScheduleDtos.value = temp;
  }

  bool containsFeature(FeatureModel feature) {
    for (PadelFeatureDto dto in pickedFeatures.value) {
      if (feature.id == dto.featureId) return true;
    }
    return false;
  }

  bool isFeatureFree(FeatureModel feature) {
    for (PadelFeatureDto dto in pickedFeatures.value) {
      if (feature.id == dto.featureId) return dto.free;
    }
    return true;
  }

  void removeFeature(FeatureModel feature) {
    pickedFeatures.value = pickedFeatures.value
        .where((element) => element.featureId != feature.id)
        .toList();
  }

  bool validateSettings() {
    validated.value = 2;
    if ((formKeySetting.currentState != null &&
        formKeySetting.currentState!.validate())) {
      return true;
    }
    return false;
  }

  bool validateTiming() {
    validated.value = 3;
    if ((formKeyTiming.currentState != null &&
        formKeyTiming.currentState!.validate())) {
      return true;
    }
    return false;
  }

  void save(BuildContext context) async {
    loading.value = true;
    padelDto.value.addressId = addressPicked.value?.id;
    padelDto.value.padelGroupId = pickedGroup.value?.id;
    padelDto.value.durationId = pickedDuration.value?.id;
    padelDto.value.padelFeatureDto = pickedFeatures.value;
    padelDto.value.padelSchedules = padelScheduleDtos.value
        .where((element) => !(element.remove ?? false))
        .toList();

    final result = ((padelDto.value.id) > 0)
        ? await padelRepository.editPadel(padelDto: padelDto.value)
        : await padelRepository.addPadel(padelDto: padelDto.value);
    loading.value = false;
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) {
      Get.back<String?>(result: 'saved');
      if (padelDto.value.id > 0) {
        AppSnackBar.success(message: 'Court updated!');
      } else {
        AppSnackBar.success(message: 'New court has been added!');
      }
    });
  }
}
