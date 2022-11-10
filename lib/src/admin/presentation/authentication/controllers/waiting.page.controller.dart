import 'package:bandeja/src/admin/core/presentations/pages/admin.main.page.dart';
import 'package:bandeja/src/admin/presentation/authentication/pages/admin.landing.page.dart';
import 'package:bandeja/src/main/core/presentations/pages/main.page.dart';
import 'package:bandeja/src/main/presentation/authentication/page/user.landing.page.dart';
import 'package:bandeja/src/owner/core/presentation/pages/owner.main.page.dart';
import 'package:bandeja/src/owner/presentation/authentication/pages/owner.landing.page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../../flavors.dart';

class WaitingPageController extends GetxController {
  Rx<WrapperDto<UserModel>> user = Rx<WrapperDto<UserModel>>(EmptyState());
  RxBool loading = true.obs;

  final userRepository = getIt<IUserRepository>();

  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  void loadUser() async {
    loading.value = true;
    final result = await userRepository.loadUser();
    if (result == null) {
      goToLandingPage();
    }
    result?.fold((l) {
      loading.value = false;
      goToLandingPage();
    }, (r) {
      user.value = WrapperDto.loadedState(value: r);
      getUser(r.id);
    });
  }

  void getUser(int id) async {
    loading.value = true;
    final result = await userRepository.getUser(id: id);
    if (result == null) {
      loading.value = false;
      AppSnackBar.failure(failure: UnExpectedFailure());
    } else {
      loading.value = false;
      result.fold((l) {
        AppSnackBar.failure(failure: l);
      }, (r) {
        loading.value = false;
        if (r.Token != null) {
          GetStorage().write('token', r.Token?.token);
        }
        if (r.enabled) {
          goToMainPage();
        }
      });
    }
  }

  void goToLandingPage() {
    switch (FF.appFlavor) {
      case Flavor.admin:
        Get.off(const AdminLandingPage());
        break;
      case Flavor.owner:
        Get.off(const OwnerLandingPage());
        break;
      default:
        Get.off(const UserLandingPage());
        break;
    }
  }

  void goToMainPage() {
    switch (FF.appFlavor) {
      case Flavor.admin:
        Get.off(const AdminMainPage());
        break;
      case Flavor.owner:
        Get.off(const OwnerMainPage());
        break;
      default:
        Get.off(const MainPage());
        break;
    }
  }
}
