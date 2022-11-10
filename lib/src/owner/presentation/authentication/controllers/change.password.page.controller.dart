import 'package:bandeja/src/core/data/authentication/repositories/auth.repository.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/data/authentication/dto/user.dto.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../flavors.dart';

class ChangePaswordPageController extends GetxController {
  final userRepository = getIt<IUserRepository>();
  final authRepository = AuthRepository();
  RxBool loading = false.obs;
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  final formKey = GlobalKey<FormState>();

  RxnString newPassword = RxnString();
  RxnString confirmPassword = RxnString();

  Rx<WrapperDto<UserModel>> userWrapper =
      Rx<WrapperDto<UserModel>>(EmptyState());
  Rx<UserDto> userDto = Rx<UserDto>(UserDto(fullName: '', role: FF.env.name));
  Rx<UserModel> user = Rx<UserModel>(UserModel(fullName: '-'));

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
      userDto.value = r.getDTO();
      userWrapper.value = WrapperDto.loadedState(value: r);
      loading.value = false;
    });
  }

  void save() async {
    if (!validate()) return;
    loading.value = true;
    if (!(await changeFirebasePassword())) {
      return;
    }
    final result = await userRepository.editUser(user: userDto.value);
    if (result == null) {
      loading.value = false;
      AppSnackBar.failure(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        loading.value = false;
        AppSnackBar.failure(failure: l);
      }, (r) {
        loading.value = false;
        AppSnackBar.success(message: 'Password Changed');
        Get.back();
      });
    }
  }

  Future<bool> changeFirebasePassword() async {
    final result =
        await authRepository.changePassword(newPassword: newPassword.value!);
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
      return false;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) {
      userDto.value.password = newPassword.value;
    });
    return userDto.value.password != null &&
        userDto.value.password == newPassword.value;
  }

  bool validate() {
    if ((formKey.currentState != null && formKey.currentState!.validate())) {
      return true;
    }
    return false;
  }
}
