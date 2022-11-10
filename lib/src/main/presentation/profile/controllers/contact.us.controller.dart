import 'package:get/state_manager.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';

class ContactUsController extends GetxController {
  RxBool loading = false.obs;
  final userRepository = getIt<IUserRepository>();
  Rx<UserModel> user = Rx<UserModel>(UserModel(fullName: '-'));
  Rx<WrapperDto<UserModel>> userWrapper =
      Rx<WrapperDto<UserModel>>(EmptyState());

  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  void loadUser() async {
    loading.value = true;
    final result = await userRepository.loadUser();
    if (result == null) {
      loading.value = false;
      userWrapper.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      userWrapper.value = WrapperDto.errorState(failure: l);
      loading.value = false;
    }, (r) {
      user.value = r;
      userWrapper.value = WrapperDto.loadedState(value: r);
      loading.value = false;
    });
  }
}
