import 'package:get/get.dart';

import '../main/injection/injector.dart';
import 'core/domain/authentication/entities/user.dart';
import 'core/domain/authentication/repositories/i.user.repository.dart';
import 'core/dto/wrapper.dto.dart';
import 'core/error/failure.dart';

class AppController extends GetxController {
  final userRepository = getIt<IUserRepository>();
  Rx<WrapperDto<UserModel>> user = Rx<WrapperDto<UserModel>>(EmptyState());
  RxBool loading = false.obs;
  void loadUser() async {
    loading.value = true;
    final result = await userRepository.loadUser();
    if (result == null) {
      loading.value = false;
      user.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      user.value = WrapperDto.errorState(failure: l);
      loading.value = false;
    }, (r) {
      user.value = WrapperDto.loadedState(value: r);
      loading.value = false;
    });
  }
}
