import 'package:bandeja/src/admin/core/presentations/pages/admin.main.page.dart';
import 'package:bandeja/src/admin/presentation/authentication/pages/waiting.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/data/authentication/dto/user.dto.dart';
import '../../../../core/data/authentication/repositories/auth.repository.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';

class AdminLoginPageController extends GetxController {
  RxBool showPassword = false.obs;
  RxBool loading = false.obs;
  AuthRepository authRepository = AuthRepository();
  final formKey = GlobalKey<FormState>();

  Rx<UserDto> userDto =
      Rx<UserDto>(UserDto(fullName: '', role: 'admin', enabled: false));

  Rx<WrapperDto<UserModel>> user = Rx<WrapperDto<UserModel>>(EmptyState());

  final userRepository = getIt<IUserRepository>();

  void logIn() async {
    if (!validate()) return;
    loading.value = true;
    final firebaseApproved = await loginWithFirebase();
    if (!firebaseApproved || userDto.value.UID == null) {
      loading.value = false;
      return;
    }
    final result = await userRepository.loginUser(user: userDto.value);
    loading.value = false;
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        AppSnackBar.failure(failure: l);
      }, (r) {
        GetStorage().write('token', r.Token?.token);
        if (r.enabled) {
          Get.offAll(const AdminMainPage());
        } else {
          Get.offAll(const WaitingPage());
        }
      });
    }
  }

  Future<bool> loginWithFirebase() async {
    final result =
        await authRepository.loginWIthEmailAndPassword(userDto: userDto.value);
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
      return false;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
      return false;
    }, (r) {
      userDto.value.UID = r.user?.uid;
      return true;
    });
    return true;
  }

  bool validate() {
    if ((formKey.currentState != null && formKey.currentState!.validate())) {
      return true;
    }
    return false;
  }
}
