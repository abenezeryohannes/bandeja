import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/owner/core/presentation/controllers/owner.profile.controller.dart';
import 'package:bandeja/src/owner/presentation/authentication/pages/change.password.page.dart';
import 'package:bandeja/src/owner/presentation/profile/widgets/owner.recent.padels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/data/authentication/dto/user.dto.dart';
import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/presentation/widgets/custom.shimmer.dart';
import '../../../../core/presentation/widgets/loading.bar.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../../core/presentation/widgets/toggle.form.dart';
import '../../../../main/presentation/profile/widgets/user.avatar.dart';

class OwnerProfilePage extends StatefulWidget {
  const OwnerProfilePage({Key? key}) : super(key: key);

  @override
  State<OwnerProfilePage> createState() => _OwnerProfilePageState();
}

class _OwnerProfilePageState extends State<OwnerProfilePage> {
  final controller = Get.put(OwnerProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.getUser();
          },
          child: Column(children: [
            if (controller.loading.value) const LoadingBar(),
            _appBar(),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: UserAvatar(
                userDto: controller.userWrapper.value,
                size: 100,
                onUpload: (x) {
                  controller.userDto.value.localImage = x;
                  controller.saveUser(controller.userDto.value);
                },
                isLoading: (loading) {
                  controller.loading.value = loading;
                },
                localImage: controller.userDto.value.localImage,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: controller.userWrapper.value.when(
                    emptyState: () => const SizedBox(),
                    loadingState: (_) => const CustomShimmer(
                        show: true, child: Text("                ")),
                    loadedState: (value) => Text((value as UserModel).fullName,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 16)),
                    errorState: (_) => const SizedBox())),
            Padding(
                padding: const EdgeInsets.only(top: 8),
                child: controller.userWrapper.value.when(
                    emptyState: () => const SizedBox(),
                    loadingState: (_) => CustomShimmer(
                          show: true,
                          child: Text(
                            '               ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                    loadedState: (value) => Text(
                        (value as UserModel).emailAddress ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14)),
                    errorState: (_) => const SizedBox())),
            const SizedBox(height: 20),
            _items(
                text: 'Change my password',
                asset: 'assets/icons/key.png',
                onClick: () {
                  Get.to(() => const ChangePasswordPage());
                }),
            Obx(() => _items(
                text: 'Booking notification',
                asset: 'assets/icons/owner_notification.png',
                action: SizedBox(
                  height: 22,
                  width: 40,
                  child: ToggleForm(
                    activeBackgroundColor:
                        Theme.of(context).colorScheme.secondary,
                    inActiveBackgroundColor: Colors.grey.shade200,
                    onChange: (bool val) {
                      UserDto temp = controller.userDto.value;
                      temp.bookingNotification = val;
                      controller.saveUser(temp);
                    },
                    value:
                        controller.userDto.value.bookingNotification ?? false,
                    activeText: '',
                    inactiveText: '',
                  ),
                ),
                onClick: () {})),
            Obx(() => _items(
                text: 'Face ID',
                asset: 'assets/icons/face_id.png',
                action: SizedBox(
                  height: 22,
                  width: 40,
                  child: ToggleForm(
                    activeBackgroundColor:
                        Theme.of(context).colorScheme.secondary,
                    inActiveBackgroundColor: Colors.grey.shade200,
                    onChange: (bool val) {
                      UserDto temp = controller.userDto.value;
                      temp.faceId = val;
                      controller.saveUser(temp);
                    },
                    value: controller.userDto.value.faceId ?? false,
                    activeText: '',
                    inactiveText: '',
                  ),
                ),
                onClick: () {})),
            const SizedBox(
              height: 10,
            ),
            Obx(() => controller.padels.value.when(
                emptyState: () => const SizedBox(),
                loadingState: (_) => RecentOwnerPadels(
                      padel: const [null, null, null, null, null],
                      onRefresh: () {},
                    ),
                loadedState: (value) {
                  return RecentOwnerPadels(
                    padel: (value as List<PadelModel?>),
                    onRefresh: () => controller.loadMyPadels(),
                  );
                },
                errorState: (failure) => ShowError(failure: failure)))
          ]),
        ),
      )),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        "Profile",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
            icon: Image.asset(
              'assets/icons/logout.png',
              color: Theme.of(context).colorScheme.secondary,
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Get.dialog(Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 40, vertical: Get.height / 3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Are You sure?',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'This will delete your session.',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'No',
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                        TextButton(
                            onPressed: () {
                              // Get.back();

                              controller.logout();
                            },
                            child: Text(
                              'Yes, am sure',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            )),
                      ],
                    )
                  ],
                ),
              ));
            },
          ),
        )
      ],
    );
  }
  // Widget _appBar() {

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
  //     child: Stack(
  //       children: [
  //         Align(
  //           alignment: const Alignment(1, -1),
  //           child: Padding(
  //             padding: const EdgeInsets.only(right: 20.0, top: 10),
  //             child: IconButton(
  //               icon: Image.asset(
  //                 'assets/icons/logout.png',
  //                 color: Theme.of(context).colorScheme.secondary,
  //                 width: 24,
  //                 height: 24,
  //               ),
  //               onPressed: () {
  //                 Get.defaultDialog(
  //                     title: 'Are you sure?',
  //                     middleText: 'This will delete your session.',
  //                     textConfirm: 'Yes, am sure',
  //                     textCancel: 'No',
  //                     onConfirm: () {
  //                       controller.logout();
  //                     },
  //                     onCancel: () {
  //                       Get.back();
  //                     });
  //               },
  //             ),
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               'Profile',
  //               style: Theme.of(context).textTheme.titleLarge,
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _items(
      {required String text,
      required String asset,
      Widget? action,
      required Function onClick}) {
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      asset,
                      height: 20,
                      color: Colors.grey.shade400,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(text,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600)),
                  ],
                ),
              ),
              action ?? const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
