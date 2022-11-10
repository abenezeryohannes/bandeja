import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../admin/presentation/authentication/pages/admin.landing.page.dart';
import '../../../../core/data/authentication/dto/user.dto.dart';
import '../../../../core/data/authentication/repositories/auth.repository.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../../flavors.dart';
import '../../../../main/presentation/authentication/page/user.landing.page.dart';
import '../../../data/padels/dto/padel.dto.dart';
import '../../../domain/padels/i.owner.padel.repository.dart';
import '../../../presentation/authentication/pages/owner.landing.page.dart';

class OwnerProfileController extends GetxController {
  final userRepository = getIt<IUserRepository>();
  RxBool loading = false.obs;
  static const pageSize = 12;

  Rx<UserDto> userDto = Rx<UserDto>(UserDto(role: FF.env.name));
  Rx<UserModel> user = Rx<UserModel>(UserModel());

  Rx<WrapperDto<UserModel>> userWrapper =
      Rx<WrapperDto<UserModel>>(EmptyState());

  final padelRepsotitory = getIt<IOwnerPadelRepository>();

  Rx<WrapperDto<List<PadelModel>>> padels =
      Rx<WrapperDto<List<PadelModel>>>(WrapperDto.emptyState());

  @override
  void onInit() {
    loadUser();
    loadMyPadels();
    super.onInit();
  }

  void loadMyPadels({int? page}) async {
    padels.value = LoadingState();
    final result = await padelRepsotitory.getPadels(page: page, limit: 3);
    if (result == null) {
      padels.value = ErrorState(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      padels.value = ErrorState(failure: l);
    }, (r) {
      padels.value = LoadedState(value: r);
    });
  }

  void disablePadel(PadelModel padel) async {
    PadelDto dto = PadelDto.fromPadelModel(padel);
    dto.enabled = !dto.enabled;
    final result = await padelRepsotitory.editPadel(padelDto: dto);
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) {
      AppSnackBar.success(
          message: 'Court has been ${dto.enabled ? 'enabled' : 'disabled'}.');
      loadMyPadels();
    });
  }

  void loadUser() async {
    final result = await userRepository.loadUser();
    if (result == null) {
      userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      userWrapper.value = WrapperDto.errorState(failure: l);
    }, (r) {
      user.value = r;
      userDto.value = r.getDTO();
      userWrapper.value = WrapperDto.loadedState(value: r);
    });
  }

  void saveUser(UserDto dto) async {
    loading.value = true;
    final result = await userRepository.editUser(user: dto);
    if (result == null) {
      loading.value = false;

      loadUser();
      if (userWrapper.value.runtimeType ==
          LoadedState(value: null).runtimeType) {
        AppSnackBar.failure(failure: UnExpectedFailure());
      } else {
        userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
      }
      userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      loading.value = false;
      if (userWrapper.value.runtimeType ==
          WrapperDto<UserModel>.loadedState(value: UserModel(fullName: ''))
              .runtimeType) {
        AppSnackBar.failure(failure: l);
      } else {
        userWrapper.value = WrapperDto.errorState(failure: l);
      }
    }, (r) {
      loading.value = false;
      user.value = r;
      userDto.value = r.getDTO();
      userWrapper.value = WrapperDto.loadedState(value: r);
      AppSnackBar.success(message: "Profile updated !");
    });
  }

  void getUser() async {
    if (user.value.id <= 0) return;
    loading.value = true;
    final result = await userRepository.getUser(id: user.value.id);
    if (result == null) {
      loading.value = false;
      userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      loading.value = false;

      userWrapper.value = WrapperDto.errorState(failure: l);
    }, (r) {
      loading.value = false;
      user.value = r;
      userDto.value = r.getDTO();
      userWrapper.value = WrapperDto.loadedState(value: r);
    });
  }

  void logout() async {
    if (user.value.id <= 0) {
      goToLanding();
      return;
    }
    loading.value = true;
    final pre = await AuthRepository().signOut();
    if (pre == null) {
      loading.value = false;
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    pre.fold((l) => AppSnackBar.failure(failure: l), (r) async {
      final result = await userRepository.logoutUser();
      if (result == null) {
        loading.value = false;
        userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
      }
      result?.fold((l) {
        loading.value = false;
        userWrapper.value = WrapperDto.errorState(failure: l);
      }, (r) {
        loading.value = false;
      });
    });
    goToLanding();
  }

  void goToLanding() {
    switch (FF.appFlavor) {
      case Flavor.admin:
        Get.offAll(const AdminLandingPage());
        break;
      case Flavor.owner:
        Get.offAll(const OwnerLandingPage());
        break;
      default:
        Get.offAll(const UserLandingPage());
        break;
    }
  }
}
