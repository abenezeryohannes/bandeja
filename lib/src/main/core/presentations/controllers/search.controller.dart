import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/duration.dart';
import '../../../../core/domain/padels/entities/padel.group.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/core/entities/address.dart';
import '../../../domain/core/repositories/i.address.repository.dart';
import '../../../../core/domain/padels/repositories/i.padel.group.repository.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';

enum ActiveSearchFilter { address, time, groupType }

class SearchController extends GetxController {
  var datePicked = DateTime.now().obs;
  Rx<ActiveSearchFilter> activeFilter =
      Rx<ActiveSearchFilter>(ActiveSearchFilter.groupType);

  Rxn<AddressModel> addressPicked = Rxn<AddressModel>();
  Rxn<PadelGroupModel> padelPicked = Rxn<PadelGroupModel>();
  Rxn<DurationModel> durationPicked = Rxn<DurationModel>();
  final addressRepository = getIt<IAddressRepository>();
  final itemGroupRepository = getIt<IPadelGroupRepository>();

  Rx<WrapperDto<List<AddressModel>>> addresses =
      Rx<WrapperDto<List<AddressModel>>>(WrapperDto.emptyState());

  Rx<WrapperDto<List<DurationModel>>> durations =
      Rx<WrapperDto<List<DurationModel>>>(WrapperDto.emptyState());

  Rx<WrapperDto<List<PadelGroupModel>>> padelGroups =
      Rx<WrapperDto<List<PadelGroupModel>>>(WrapperDto.emptyState());

  final allPadelGroup =
      PadelGroupModel(id: -1, name: 'All', icon: 'icons/all.png');

  @override
  void onInit() {
    loadAddresses();
    loadPadelGroup();
    loadDurations();
    super.onInit();
  }

  void loadAddresses({int? page}) async {
    addresses.value = WrapperDto<List<AddressModel>>.loadingState();
    final result = await addressRepository.getAddresses();
    if (result == null) {
      addresses.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => addresses.value = WrapperDto.errorState(failure: l),
          (r) {
        r.insert(0, AddressModel(id: -1, name: 'Near by'));
        addresses.value = WrapperDto<List<AddressModel>>.loadedState(value: r);
        if (r.isNotEmpty) {
          addressPicked.value = r.first;
        }
      });
    }
  }

  void loadPadelGroup({int? page}) async {
    padelGroups.value = WrapperDto<List<PadelGroupModel>>.loadingState();
    final result = await itemGroupRepository.getPadelGroups();
    if (result == null) {
      padelGroups.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => padelGroups.value = WrapperDto.errorState(failure: l),
          (r) {
        r.insert(0, allPadelGroup);
        if (r.isNotEmpty) {
          padelPicked.value = r.first;
        }
        padelGroups.value =
            WrapperDto<List<PadelGroupModel>>.loadedState(value: r);
      });
    }
  }

  void loadDurations({int? page}) async {
    durations.value = WrapperDto<List<DurationModel>>.loadingState();
    final result = await (getIt<IPadelRepository>()).findAllDurations();
    if (result == null) {
      durations.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => durations.value = WrapperDto.errorState(failure: l),
          (r) {
        r.insert(0, DurationModel(id: -1, minute: 0));
        if (r.isNotEmpty) {
          durationPicked.value = r.first;
        }
        durations.value = WrapperDto<List<DurationModel>>.loadedState(value: r);
      });
    }
  }
}
