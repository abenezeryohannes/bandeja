import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/core/utils/util.dart';
import 'package:bandeja/src/owner/presentation/authentication/controllers/owner.sign.up.page.controller.dart';
import 'package:bandeja/src/owner/presentation/authentication/pages/owner.waiting.page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/text.input.form.dart';

class OwnerSignupPage extends StatefulWidget {
  const OwnerSignupPage({Key? key}) : super(key: key);

  @override
  State<OwnerSignupPage> createState() => _OwnerSignupPageState();
}

class _OwnerSignupPageState extends State<OwnerSignupPage> {
  final controller = Get.put(OwnerSignUpPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 20),
                    child: Text(
                      'Create your \nBusiness Account!',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.grey.shade900),
                    ),
                  ),
                  Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8),
                            child: TextInputForm(
                                placeholder: 'Owner Name',
                                elevation: 1,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                radius: 30,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 5, right: 0, bottom: 15),
                                  child: SizedBox(
                                    height: 4,
                                    child: Image.asset('assets/icons/user.png',
                                        color: Colors.grey.shade400),
                                  ),
                                ),
                                validator: (value) => Util.validateNoEmpty(
                                    controller.userDto.value.fullName),
                                focusedBorderColor:
                                    Theme.of(context).colorScheme.secondary,
                                focusedBorderWidth: 1.4,
                                initialValue: controller.userDto.value.fullName,
                                onChanged: (change) {
                                  controller.userDto.value.fullName = change;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8),
                            child: TextInputForm(
                                placeholder: 'Mobile Number',
                                elevation: 1,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                radius: 30,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 5, right: 0, bottom: 15),
                                  child: SizedBox(
                                      height: 4,
                                      child: Image.asset(
                                          'assets/icons/mobile.png',
                                          color: Colors.grey.shade400)),
                                ),
                                validator: (value) => Util.validateNoEmpty(
                                    controller.userDto.value.phoneNumber),
                                focusedBorderColor:
                                    Theme.of(context).colorScheme.secondary,
                                focusedBorderWidth: 1.4,
                                initialValue:
                                    controller.userDto.value.phoneNumber,
                                onChanged: (change) {
                                  controller.userDto.value.phoneNumber = change;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8),
                            child: TextInputForm(
                                placeholder: 'Business Email',
                                elevation: 1,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                radius: 30,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 5, right: 0, bottom: 15),
                                  child: SizedBox(
                                      height: 4,
                                      child: Image.asset(
                                          'assets/icons/envelope.png',
                                          color: Colors.grey.shade400)),
                                ),
                                validator: (value) => Util.validEmail(controller
                                    .userDto.value.emailAddress
                                    ?.trim()),
                                focusedBorderColor:
                                    Theme.of(context).colorScheme.secondary,
                                focusedBorderWidth: 1.4,
                                initialValue:
                                    controller.userDto.value.emailAddress,
                                onChanged: (change) {
                                  controller.userDto.value.emailAddress =
                                      change.trim();
                                }),
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8),
                              child: TextInputForm(
                                  placeholder: 'Password',
                                  elevation: 1,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  radius: 30,
                                  obscureText: !controller.showPassword.value,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 5, right: 0, bottom: 15),
                                    child: SizedBox(
                                      height: 4,
                                      child: Image.asset(
                                        'assets/icons/lock.png',
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => controller.showPassword.value =
                                        !controller.showPassword.value,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 0,
                                          right: 10,
                                          bottom: 15),
                                      child: SizedBox(
                                        height: 4,
                                        child: Image.asset(
                                          controller.showPassword.value
                                              ? 'assets/icons/icon_eye_2.png'
                                              : 'assets/icons/icon_eye.png',
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  validator: (value) =>
                                      Util.validatePassworkStrong(value),
                                  focusedBorderColor:
                                      Theme.of(context).colorScheme.secondary,
                                  focusedBorderWidth: 1.4,
                                  initialValue:
                                      controller.userDto.value.password,
                                  onChanged: (change) {
                                    controller.userDto.value.password = change;
                                  }),
                            ),
                          ),
                          Obx(() => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                            value: controller
                                                .termsAndServiceAccepted.value,
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                width: 2),
                                            checkColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            activeColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            onChanged: (value) => controller
                                                .termsAndServiceAccepted
                                                .value = value ?? false),
                                        Text(
                                          'I accept term of service',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                    if (controller.validated.value &&
                                        !controller
                                            .termsAndServiceAccepted.value)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          'Sorry, To continue you must read and agree with our privacy policy and terms of service.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                  ],
                                ),
                              )),
                        ],
                      ))
                ],
              ),
            ),
            // if (MediaQuery.of(context).viewInsets.bottom == 0)
            Obx(() => Align(
                alignment: Alignment.bottomCenter,
                child: BigTextButton(
                    onClick: () {
                      controller.signUp();
                      // Get.to(() => const OwnerWaitingPage());
                    },
                    text: 'Get Started',
                    isLoading: controller.loading.value,
                    horizontalMargin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    cornerRadius: 0)))
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: null,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(
          margin: const EdgeInsets.only(top: 14, bottom: 14, left: 25),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1, color: Colors.grey.shade600)),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.chevron_left,
              size: 24,
              color: Colors.black,
            ),
          )),
    );
  }
}
