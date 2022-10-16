import 'package:bandeja/src/main/presentation/authentication/controllers/auth.state.dart';
import 'package:bandeja/src/main/presentation/authentication/widgets/fill.user.form.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/data/authentication/dto/user.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/loading.bar.dart';
import '../controllers/signup.page.controller.dart';
import '../widgets/confirm.widget.dart';
import '../widgets/signup.widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupPageController controller = Get.put(SignupPageController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.state.value.runtimeType ==
                ConfirmingState().runtimeType ||
            controller.state.value.runtimeType ==
                CodeSentState(verificationId: '').runtimeType) {
          controller.state.value = NotVerifiedState();
          return false;
        } else {
          Navigator.maybePop(context);
          return false;
        }
      },
      child: Scaffold(
          // appBar: _appBar(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
              child: Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          if (controller.state.value == VerifiyingState() ||
                              controller.state.value == ConfirmingState() ||
                              controller.isLoading.value)
                            const LoadingBar(),
                          _appBar(),
                          SizedBox(
                            // height: Get.height * 5 / 12,
                            child: ExpandablePageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: controller.pageController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                SignupSlide(
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
                                  error: controller.isPhoneNumberValid.value
                                      ? (controller.state.value.runtimeType ==
                                              VerificationFailedState(
                                                      failure:
                                                          UnExpectedFailure())
                                                  .runtimeType)
                                          ? (controller.state.value
                                                  as VerificationFailedState)
                                              .failure
                                              .message
                                          : null
                                      : "Phone Number is not valid.",
                                  onFocustChange: (bool focus) {
                                    setState(() {
                                      controller.keyboard.value = focus;
                                    });
                                  },
                                ),
                                ConfirmSlide(
                                  onFocustChange: (bool focus) {
                                    setState(() {
                                      controller.keyboard.value = focus;
                                    });
                                  },
                                  onResendCode: () {
                                    controller.resendCode();
                                  },
                                  error: controller
                                          .isConfirmationCodeValid.value
                                      ? (controller.state.value.runtimeType ==
                                              ConfirmationFailedState(
                                                      failure:
                                                          UnExpectedFailure())
                                                  .runtimeType)
                                          ? (controller.state.value
                                                  as ConfirmationFailedState)
                                              .failure
                                              .message
                                          : null
                                      : 'Invalid Confirmation code.',
                                  onCodeChange: (val) {
                                    controller.code.value = val;
                                  },
                                  code: controller.code.value,
                                ),
                                FillUserForm(
                                  userW: controller.userModel.value,
                                  userDto: controller.userDto.value,
                                  isLoading: (isLoading) =>
                                      controller.isLoading.value = isLoading,
                                  onUpload: (path) => controller.userDto.value =
                                      UserDto(
                                          fullName:
                                              controller.userDto.value.fullName,
                                          role: controller.userDto.value.role,
                                          avatar:
                                              controller.userDto.value.avatar,
                                          localImage: path),
                                  onNameChange: (name) =>
                                      controller.userDto.value = UserDto(
                                          fullName: name,
                                          role: controller.userDto.value.role,
                                          localImage: controller
                                              .userDto.value.localImage,
                                          avatar:
                                              controller.userDto.value.avatar),
                                  onFocus: (bool focus) {
                                    setState(() {
                                      controller.keyboard.value = true;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: controller.keyboard.value ? 0 : 40,
                            horizontal: controller.keyboard.value ? 0 : 40),
                        child: InkWell(
                          onTap: () {
                            if (controller.pageController.page == 0) {
                              String phoneNumber =
                                  "${controller.country.value.code}${controller.phoneNumber.value}";
                              controller.isPhoneNumberValid.value =
                                  GetUtils.isPhoneNumber(phoneNumber);
                              if (controller.isPhoneNumberValid.value) {
                                controller.verify(phoneNumber);
                              }
                            } else if (controller.pageController.page == 1) {
                              controller.isConfirmationCodeValid.value =
                                  (controller.code.value.length <= 6);
                              controller.confirm(
                                  code: controller.code.value.substring(0, 6));
                            } else {
                              controller.saveUser();
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
                                borderRadius: BorderRadius.all(Radius.circular(
                                    controller.keyboard.value ? 0 : 20))),
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
                  )))),
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
