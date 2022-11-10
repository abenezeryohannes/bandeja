import 'package:bandeja/src/core/data/authentication/dto/user.dto.dart';
import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:bandeja/src/core/domain/authentication/repositories/i.user.repository.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/data/authentication/repositories/auth.repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../core/presentation/pages/owner.main.page.dart';
import '../pages/owner.waiting.page.dart';

class OwnerLoginPageController extends GetxController {
  RxBool showPassword = false.obs;
  RxBool loading = false.obs;
  AuthRepository authRepository = AuthRepository();
  final formKey = GlobalKey<FormState>();

  Rx<UserDto> userDto =
      Rx<UserDto>(UserDto(fullName: '', role: 'owner', enabled: false));

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
        GetStorage().write('token', r.Token?.token ?? 'owner');
        if (r.enabled) {
          Get.offAll(const OwnerMainPage());
        } else {
          Get.offAll(const OwnerWaitingPage());
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
