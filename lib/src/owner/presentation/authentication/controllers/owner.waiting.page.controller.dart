import 'package:bandeja/src/core/data/authentication/dto/user.dto.dart';
import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:bandeja/src/core/domain/authentication/repositories/i.user.repository.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';

class OwnerWaitingPageController extends GetxController {
  RxBool showPassword = false.obs;
  RxBool loading = false.obs;
  final formKey = GlobalKey<FormState>();

  Rx<UserDto> userDto =
      Rx<UserDto>(UserDto(fullName: '', role: 'owner', enabled: false));

  Rx<WrapperDto<UserModel>> user = Rx<WrapperDto<UserModel>>(EmptyState());

  final userRepository = getIt<IUserRepository>();

  void logIn() async {
    if (!validate()) return;
    loading.value = true;
    final result = await userRepository.loginUser(user: userDto.value);
    loading.value = false;
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        AppSnackBar.failure(failure: l);
      }, (r) {
        // AppSnackBar.success(message: 'Sign up Complete!');
      });
    }
  }

  bool validate() {
    if ((formKey.currentState != null && formKey.currentState!.validate())) {
      return true;
    }
    return false;
  }
}
