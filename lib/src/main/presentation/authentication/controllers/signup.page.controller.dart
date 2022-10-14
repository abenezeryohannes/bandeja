import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Country {
  final String name;
  final String flag;
  final String code;
  Country({required this.name, required this.flag, required this.code});
}

class SignupPageController extends GetxController {
  late PageController pageController;
  RxString phoneNumber = ''.obs;
  Rx<List<Country>> countries = Rx<List<Country>>([
    Country(name: 'Kuwait', flag: 'assets/img/kuwait.png', code: '+965'),
    Country(name: 'Dubai', flag: 'assets/img/kuwait.png', code: '+971'),
  ]);
  late Rx<Country> country;
  RxString code = ''.obs;
  @override
  void onInit() {
    country = Rx<Country>(countries.value[0]);
    pageController = PageController(initialPage: 0);
    super.onInit();
  }
}
