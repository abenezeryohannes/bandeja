import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/main/presentation/authentication/controllers/auth.state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/data/authentication/dto/user.dto.dart';
import '../../../../core/data/authentication/repositories/auth.repository.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../flavors.dart';
import '../../../../core/domain/authentication/entities/user.dart' as MyUser;

class Country {
  final String name;
  final String flag;
  final String code;
  Country({required this.name, required this.flag, required this.code});
}

class SignupPageController extends GetxController {
  late AuthRepository authRepository;
  final userRepository = getIt<IUserRepository>();

  late PageController pageController;

  Rx<AuthState> state = Rx<AuthState>(NotVerifiedState());

  RxString phoneNumber = ''.obs;
  RxBool keyboard = false.obs;
  RxBool isLoading = false.obs;
  RxBool isPhoneNumberValid = true.obs;
  RxBool isConfirmationCodeValid = true.obs;
  Rx<UserDto> userDto = Rx<UserDto>(UserDto(fullName: '', role: 'user'));

  Rx<WrapperDto<MyUser.UserModel>> userModel =
      Rx<WrapperDto<MyUser.UserModel>>(EmptyState());

  late Rx<Country> country;
  RxString code = ''.obs;

  Rx<List<Country>> countries = Rx<List<Country>>([
    Country(name: 'Kuwait', flag: 'assets/img/kuwait.png', code: '+965'),
    Country(name: 'UAE', flag: 'assets/img/uae.png', code: '+971'),
  ]);

  @override
  void onInit() {
    country = Rx<Country>(countries.value[0]);
    pageController = PageController(initialPage: 0);

    authRepository = AuthRepository(
        onVerficationComplete: (PhoneAuthCredential credential) async {
      OnVerficationComplete(credential: credential);
    }, onCodeSent: (String verificationId, int? resendToken) async {
      OnCodeSent(verificationId: verificationId, resendToken: resendToken);
    }, onCodeAutoRetrievalTimeout: (String verificationId) async {
      OnCodeAutoRetrievalTimeout(verificationId: verificationId);
    }, onVerificationFailed: (FirebaseAuthException exception) async {
      OnVerificationFailed(exception: exception);
    });

    super.onInit();
  }

  OnVerficationComplete({required PhoneAuthCredential credential}) {
    state.value = VerifiedState(phoneAuthCredential: credential);
  }

  OnCodeSent({required String verificationId, int? resendToken}) {
    state.value =
        CodeSentState(verificationId: verificationId, resendToken: resendToken);

    pageController.animateToPage(1,
        duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
  }

  OnCodeAutoRetrievalTimeout({required String verificationId}) {}

  OnVerificationFailed({required FirebaseAuthException exception}) {
    state.value = VerificationFailedState(
        failure: UnExpectedFailure(message: exception.message));
  }

  verify(
    String phoneNumber,
  ) async {
    state.value = VerifiyingState();
    AuthRepository.PHONENUMBER = phoneNumber;
    // User? user =
    await authRepository.verifyPhoneNumber(phoneNumber);
    // if (user != null) {
    //   signIn(user: user, isLogin: true);
    //   //state.value = ConfirmedState(user: user!);
    // }
  }

  confirm({required String code, required Function onAuthentication}) async {
    state.value = ConfirmingState();
    AuthRepository.SMSCODE = code;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: AuthRepository.VERIFICATION_ID, smsCode: code);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Login(user: user, onAuthentication: onAuthentication);
      } else {
        state.value = ConfirmationFailedState(
            failure: UnExpectedFailure(
                message: "Sorry, something went wrong, please try again!"));
      }
    } on FirebaseAuthException catch (e) {
      state.value = ConfirmationFailedState(
          failure: UnExpectedFailure(message: e.message));
    } finally {}
  }

  Login(
      {required User user,
      bool isLogin = true,
      required Function onAuthentication}) async {
    MyUser.UserModel myUser = MyUser.UserModel(
      phoneNumber: ((user.phoneNumber != null) ? user.phoneNumber! : "unknown"),
      fullName: '',
      UID: user.uid,
      role: FF.env.name,
      id: -1,
    );

    final response =
        await userRepository.loginUser(user: UserDto.fromModel(myUser));

    if (response == null) {
      state.value = ConfirmedState(user: user);
      return;
    }

    response.fold((l) {
      state.value = ConfirmationFailedState(failure: l);
    }, (r) {
      GetStorage().write('token', r.Token?.token ?? 'user');
      updateFCMToken();

      state.value = ConfirmedState(user: user);
      loadUser();
      if (r.fullName.trim().isNotEmpty) {
        onAuthentication();
      } else {
        pageController.animateToPage(2,
            duration: const Duration(microseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  Future<User?> resendCode() async {
    return await authRepository.resendPhoneConfirmationCode();
  }

  void loadUser() async {
    isLoading.value = true;
    final result = await userRepository.loadUser();
    if (result == null) {
      isLoading.value = false;
      userModel.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      userModel.value = WrapperDto.errorState(failure: l);
      isLoading.value = false;
    }, (r) {
      GetStorage().write('token', r.Token?.token ?? 'user');
      userDto.value =
          UserDto(fullName: r.fullName, role: r.role, avatar: r.avatar);

      userModel.value = WrapperDto.loadedState(value: r);
      isLoading.value = false;
    });
  }

  void saveUser(Function onAuthentication) async {
    isLoading.value = true;

    final result = await userRepository.editUser(user: userDto.value);
    if (result == null) {
      isLoading.value = false;
    }
    result?.fold((l) {
      isLoading.value = false;
      AppSnackBar.failure(failure: l);
    }, (r) {
      userDto.value =
          UserDto(fullName: r.fullName, role: r.role, avatar: r.avatar);
      userModel.value = WrapperDto.loadedState(value: r);
      isLoading.value = false;

      onAuthentication();
    });
  }

  void updateFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;
    await userRepository.setFCMToken(token: token);
  }
}
