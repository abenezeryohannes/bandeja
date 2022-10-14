import 'package:feekpadel/src/main/presentation/authentication/controllers/signup.page.controller.dart';
import 'package:feekpadel/src/main/presentation/authentication/widgets/confirm.widget.dart';
import 'package:feekpadel/src/main/presentation/authentication/widgets/signup.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupPageController controller = Get.put(SignupPageController());

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = true;
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: Get.height * 5 / 12,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  Obx(() => SignupSlide(
                        hint: '0000000000',
                        onChanged: (String val) {
                          controller.phoneNumber.value = val;
                        },
                        value: controller.phoneNumber.value,
                        onCountryChange: (Country country) {
                          controller.country.value = country;
                        },
                        countries: controller.countries.value,
                        country: controller.country.value,
                      )),
                  Obx(() => ConfirmSlide(
                        onResendCode: () {},
                        onCodeChange: (val) {
                          controller.code.value = val;
                        },
                        code: controller.code.value,
                      ))
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: isKeyboardOpen ? 40 : 0),
              child: InkWell(
                onTap: () {
                  if (controller.pageController.page == 0) {
                    //check number validity and move to confirmation
                    controller.pageController.animateToPage(1,
                        duration: const Duration(microseconds: 300),
                        curve: Curves.easeInOut);
                  } else {
                    //
                    controller.pageController.animateToPage(0,
                        duration: Duration(microseconds: 300),
                        curve: Curves.easeInOut);
                  }
                },
                child: Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.all(
                          Radius.circular(isKeyboardOpen ? 20 : 0))),
                  child: Text(
                    'Next',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      leadingWidth: 56,
      backgroundColor: Colors.grey.shade50,
      elevation: 0,
      leading: Container(
          margin: const EdgeInsets.only(top: 14, bottom: 14, left: 25),
          // decoration: BoxDecoration(
          //     borderRadius: const BorderRadius.all(Radius.circular(10)),
          //     border: Border.all(width: 1, color: Colors.grey.shade600)),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 32,
              color: Colors.black,
            ),
          )),
    );
  }
}
