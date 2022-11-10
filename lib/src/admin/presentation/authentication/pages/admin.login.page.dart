import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/text.input.form.dart';
import '../controllers/admin.login.page.controller.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final controller = Get.put(AdminLoginPageController());
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
                      'Weclome \nTo Bandeja!!',
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
                          Obx(() => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8),
                                child: TextInputForm(
                                    placeholder: 'Email',
                                    elevation: 1,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    radius: 30,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 5,
                                          right: 0,
                                          bottom: 15),
                                      child: SizedBox(
                                          height: 4,
                                          child: Image.asset(
                                              'assets/icons/envelope.png',
                                              color: Colors.grey.shade400)),
                                    ),
                                    validator: (value) => Util.validEmail(
                                        controller.userDto.value.emailAddress),
                                    focusedBorderColor:
                                        Theme.of(context).colorScheme.secondary,
                                    focusedBorderWidth: 1.4,
                                    initialValue:
                                        controller.userDto.value.emailAddress,
                                    onChanged: (change) {
                                      controller.userDto.value.emailAddress =
                                          change;
                                    }),
                              )),
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
                    controller.logIn();
                  },
                  isLoading: controller.loading.value,
                  text: 'Log in',
                  horizontalMargin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  cornerRadius: 12,
                )))
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
