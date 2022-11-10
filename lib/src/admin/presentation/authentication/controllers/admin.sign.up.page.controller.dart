import 'package:bandeja/src/admin/core/presentations/pages/admin.main.page.dart';
import 'package:bandeja/src/admin/presentation/authentication/pages/waiting.page.dart';
import 'package:bandeja/src/core/data/authentication/dto/user.dto.dart';
import 'package:bandeja/src/core/data/authentication/repositories/auth.repository.dart';
import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:bandeja/src/core/domain/authentication/repositories/i.user.repository.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';

class AdminSignUpPageController extends GetxController {
  RxBool showPassword = false.obs;
  RxBool termsAndServiceAccepted = false.obs;
  RxBool validated = false.obs;
  RxBool loading = false.obs;
  final formKey = GlobalKey<FormState>();
  final userRepository = getIt<IUserRepository>();
  AuthRepository authRepository = AuthRepository();
  Rx<UserDto> userDto =
      Rx<UserDto>(UserDto(fullName: '', role: 'admin', enabled: false));

  Rx<WrapperDto<UserModel>> user = Rx<WrapperDto<UserModel>>(EmptyState());

  void signUp() async {
    if (!validate()) return;
    loading.value = true;
    final firebaseApproved = await signUpWithFirebase();
    if (!firebaseApproved) {
      loading.value = false;
      return;
    }
    final result = await userRepository.signupUser(user: userDto.value);
    loading.value = false;
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
      await authRepository.signOut();
    } else {
      result.fold((l) async {
        AppSnackBar.failure(failure: l);
        await authRepository.deleteUser();
      }, (r) {
        GetStorage().write('token', r.Token?.token ?? 'admin8');
        updateFCMToken();

        if (r.enabled) {
          Get.offAll(const AdminMainPage());
        } else {
          Get.offAll(const WaitingPage());
        }
      });
    }
  }

  Future<bool> signUpWithFirebase() async {
    final result = await authRepository.createUserWithEmailAndPassword(
        userDto: userDto.value);
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
      return false;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) {
      userDto.value.UID = r.user?.uid;
    });
    return userDto.value.UID != null && userDto.value.UID!.isNotEmpty;
  }

  bool validate() {
    validated.value = true;
    if ((formKey.currentState != null && formKey.currentState!.validate()) &&
        termsAndServiceAccepted.value) {
      return true;
    }
    return false;
  }

  void updateFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;
    await userRepository.setFCMToken(token: token);
  }
}
