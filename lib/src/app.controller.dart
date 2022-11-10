import 'package:bandeja/src/core/data/authentication/dto/location.dto.dart';
import 'package:bandeja/src/owner/presentation/authentication/pages/owner.waiting.page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../main/injection/injector.dart';
import 'core/domain/authentication/entities/user.dart';
import 'core/domain/authentication/repositories/i.user.repository.dart';
import 'core/dto/wrapper.dto.dart';
import 'core/error/failure.dart';
import 'package:location/location.dart';

class AppController extends GetxController {
  final userRepository = getIt<IUserRepository>();
  Rx<WrapperDto<UserModel>> userWrap = Rx<WrapperDto<UserModel>>(EmptyState());
  Rxn<UserModel> user = Rxn<UserModel>();
  RxBool loading = false.obs;

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
      userWrap.value = WrapperDto.errorState(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      userWrap.value = WrapperDto.errorState(failure: l);
      loading.value = false;
    }, (r) {
      updateFCMToken();
      updateLocation();
      // onAppVisitStart();

      userWrap.value = WrapperDto.loadedState(value: r);
      loading.value = false;
      user.value = r;
      if (!r.enabled) {
        Get.offAll(const OwnerWaitingPage());
      }
    });
  }

  void updateFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token == null) return;
      await userRepository.setFCMToken(token: token);
    } catch (_) {}
  }

  // void onAppVisitStart() async {
  //   final result = await userRepository.onAppVisit();
  // }

  // void onAppVisitEnd() async {
  //   final result = await userRepository.onAppVisit();
  // }

  void updateLocation() async {
    try {
      var location = Location();

      var serviceEnabled = await location.serviceEnabled();

      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted != PermissionStatus.granted &&
          permissionGranted != PermissionStatus.grantedLimited) {
        var permission = await location.requestPermission();
        if (permission != PermissionStatus.granted &&
            permission != PermissionStatus.grantedLimited) {
          return;
        }
      }

      var currentLocation = await location.getLocation();
      GetStorage().write('latitude', currentLocation.latitude);
      GetStorage().write('longitude', currentLocation.longitude);

      //get the location and convert it to location DTO
      LocationDto locationDto = LocationDto.empty(
        id: user.value?.Location?.id,
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      );

      await userRepository.updateLocation(locationDto: locationDto);
    } catch (e) {
      e.printError();
    }
  }
}
