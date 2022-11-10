import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/core/utils/util.dart';
import 'package:bandeja/src/owner/presentation/authentication/controllers/change.password.page.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/text.input.form.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final controller = Get.put(ChangePaswordPageController());
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
                      'Change Password',
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
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 20.0, vertical: 20),
                          //   child: TextInputForm(
                          //       placeholder: 'Old Password',
                          //       elevation: 1,
                          //       floatingLabelBehavior:
                          //           FloatingLabelBehavior.never,
                          //       radius: 30,
                          //       prefixIcon: Padding(
                          //         padding: const EdgeInsets.only(
                          //             top: 15, left: 5, right: 0, bottom: 15),
                          //         child: SizedBox(
                          //           height: 4,
                          //           child: Image.asset(
                          //             'assets/icons/lock.png',
                          //             color: Colors.grey.shade400,
                          //           ),
                          //         ),
                          //       ),
                          //       validator: (value) {
                          //         if (value != controller.user.value.password) {
                          //           return 'Old password not correct';
                          //         }
                          //         return null;
                          //       },
                          //       focusedBorderColor:
                          //           Theme.of(context).colorScheme.secondary,
                          //       focusedBorderWidth: 1.4,
                          //       onChanged: (_) {}),
                          // ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8),
                              child: TextInputForm(
                                  placeholder: 'New Password',
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
                                  validator: (value) => Util.validateNoEmpty(
                                      controller.newPassword.value),
                                  focusedBorderColor:
                                      Theme.of(context).colorScheme.secondary,
                                  focusedBorderWidth: 1.4,
                                  initialValue: controller.newPassword.value,
                                  onChanged: (change) {
                                    controller.newPassword.value = change;
                                  }),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8),
                              child: TextInputForm(
                                  placeholder: 'Confirm New Password',
                                  elevation: 1,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  radius: 30,
                                  obscureText:
                                      !controller.showConfirmPassword.value,
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
                                    onTap: () => controller
                                            .showConfirmPassword.value =
                                        !controller.showConfirmPassword.value,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 0,
                                          right: 10,
                                          bottom: 15),
                                      child: SizedBox(
                                        height: 4,
                                        child: Image.asset(
                                          controller.showConfirmPassword.value
                                              ? 'assets/icons/icon_eye_2.png'
                                              : 'assets/icons/icon_eye.png',
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  validator: (value) => Util.validateMatch(
                                      controller.newPassword.value,
                                      controller.confirmPassword.value),
                                  focusedBorderColor:
                                      Theme.of(context).colorScheme.secondary,
                                  focusedBorderWidth: 1.4,
                                  initialValue:
                                      controller.confirmPassword.value,
                                  onChanged: (change) {
                                    controller.confirmPassword.value = change;
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
                    controller.save();
                  },
                  isLoading: controller.loading.value,
                  text: 'save',
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
