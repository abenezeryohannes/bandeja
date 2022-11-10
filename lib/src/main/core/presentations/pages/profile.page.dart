import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:bandeja/src/main/core/presentations/controllers/profile.controller.dart';
import 'package:bandeja/src/main/presentation/booking/widgets/recent.bookings.dart';
import 'package:bandeja/src/main/presentation/notification/pages/notification.page.dart';
import 'package:bandeja/src/main/presentation/posts/pages/my.posts.page.dart';
import 'package:bandeja/src/main/presentation/profile/pages/contact.us.page.dart';
import 'package:bandeja/src/main/presentation/profile/widgets/user.avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import '../../../../core/presentation/widgets/custom.shimmer.dart';
import '../../../../core/presentation/widgets/image.form.dart';
import '../../../../core/presentation/widgets/loading.bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.loadBookings();
    controller.loadNotifications();
    controller.loadBookings();
    controller.loadNotificationCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(controller.notificationCount.value.toString());
    return Scaffold(
        body: SingleChildScrollView(
      child: Obx(() => Column(
            children: [
              if (controller.loading.value) const LoadingBar(),
              _appBar(context),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: UserAvatar(
                  userDto: controller.userWrapper.value,
                  size: 100,
                  onUpload: (x) {
                    controller.avatar.value = x;
                    controller.saveUser();
                  },
                  isLoading: (loading) {
                    controller.loading.value = loading;
                  },
                  localImage: controller.avatar.value,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: controller.userWrapper.value.when(
                      emptyState: () => const SizedBox(),
                      loadingState: (_) => const CustomShimmer(
                          show: true, child: Text("                ")),
                      loadedState: (value) => Text(
                          toBeginningOfSentenceCase(
                                  (value as UserModel).fullName) ??
                              '',
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
                              '                   ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                      loadedState: (value) => Text(
                          (value as UserModel).phoneNumber,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 14)),
                      errorState: (_) => const SizedBox())),
              controller.userWrapper.value.when(
                  emptyState: () => const Center(),
                  loadingState: (_) => CustomShimmer(
                        show: true,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle),
                        ),
                      ),
                  loadedState: (value) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => const MyPostPage());
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Image.asset(
                                      "assets/icons/marketing_active.png",
                                      height: 20,
                                      color: Colors.grey.shade400,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Text("My Ads",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => const ContactUsPage());
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Image.asset(
                                      "assets/icons/contact.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Text("Contact Us",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() => controller.recentBookingWrapper.value.when(
                              emptyState: () => const SizedBox(),
                              loadingState: (_) => const RecentBooking(
                                  padelOrders: [null, null, null]),
                              loadedState: (value) {
                                return ((value as List<PadelOrderModel?>)
                                        .isNotEmpty)
                                    ? RecentBooking(padelOrders: (value))
                                    : ShowError(
                                        failure: NoDataFailure(
                                          message:
                                              'Your recent booking will be shown here.',
                                        ),
                                        errorShowType: ErrorShowType.vertical,
                                      );
                              },
                              errorState: (failure) => ShowError(
                                    failure: failure,
                                    errorShowType: ErrorShowType.vertical,
                                  )))
                        ],
                      ),
                  errorState: (Failure f) => ImageForm(
                        placeholder: Image.asset(
                          "assets/icons/error.png",
                          height: 100,
                        ),
                        onUpload: (x) {},
                        isLoading: (loading) {},
                      )),
            ],
          )),
    ));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text("My Profile", style: Theme.of(context).textTheme.titleMedium),
      actions: [
        Stack(alignment: Alignment.center, children: [
          Align(
            alignment: const Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () async {
                  await Get.to(() => const NotificationPage());
                  controller.loadNotificationCount();
                },
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/icons/notification.png",
                        height: 30,
                        width: 24,
                      ),
                      Obx(() => (controller.notificationCount.value == 0)
                          ? const SizedBox()
                          : Align(
                              alignment: const Alignment(2, 3),
                              child: Card(
                                shape: const CircleBorder(),
                                color: Theme.of(context).colorScheme.secondary,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: Text(
                                      '${controller.notificationCount.value}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                    ],
                  ),
                ),
              ),
            ),
          )
        ])
      ],
    );
  }

  // _myPosts(BuildContext context) {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 24.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "My Posts",
  //               style: Theme.of(context).textTheme.titleSmall,
  //             ),
  //             TextButton(
  //               onPressed: () {},
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.add,
  //                     color: Theme.of(context).colorScheme.secondary,
  //                   ),
  //                   Text("Add",
  //                       style: TextStyle(
  //                           color: Theme.of(context).colorScheme.secondary,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 16)),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //       Row(
  //         children: const [
  //           SizedBox(
  //             width: 10,
  //           ),
  //           MinePostCard(),
  //         ],
  //       )
  //     ],
  //   );
  // }
}
