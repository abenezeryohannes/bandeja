import 'package:feekpadel/main/injection/injector.dart';
import 'package:feekpadel/src/main/domain/core/entities/address.dart';
import 'package:get/get.dart';

import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/core/repositories/i.address.repository.dart';
import '../../../domain/padels/entities/padel.group.dart';
import '../../../domain/padels/repositories/i.padel.group.repository.dart';

enum ActiveSearchFilter { address, time, groupType }

class SearchController extends GetxController {
  var datePicked = DateTime.now().obs;
  Rx<ActiveSearchFilter> activeFilter =
      Rx<ActiveSearchFilter>(ActiveSearchFilter.groupType);

  Rxn<AddressModel> addressPicked = Rxn<AddressModel>();
  Rxn<PadelGroupModel> padelPicked = Rxn<PadelGroupModel>();
  final addressRepository = getIt<IAddressRepository>();
  final itemGroupRepository = getIt<IPadelGroupRepository>();

  Rx<WrapperDto<List<AddressModel>>> addresses =
      Rx<WrapperDto<List<AddressModel>>>(WrapperDto.emptyState());

  Rx<WrapperDto<List<PadelGroupModel>>> padelGroups =
      Rx<WrapperDto<List<PadelGroupModel>>>(WrapperDto.emptyState());

  @override
  void onInit() {
    loadAddresses();
    loadPadelGroup();
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
        addresses.value = WrapperDto<List<AddressModel>>.loadedState(value: r);
        // if (r.isNotEmpty) {
        //   addressPicked.value = r.first;
        // }
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
        // if (r.isNotEmpty) {
        //   padelPicked.value = r.first;
        // }
        padelGroups.value =
            WrapperDto<List<PadelGroupModel>>.loadedState(value: r);
      });
    }
  }
}
