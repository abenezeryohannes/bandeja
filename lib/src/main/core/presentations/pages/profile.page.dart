import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/main/core/presentations/controllers/profile.controller.dart';
import 'package:bandeja/src/main/presentation/profile/widgets/user.avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/custom.shimmer.dart';
import '../../../../core/presentation/widgets/image.form.dart';
import '../../../../core/presentation/widgets/loading.bar.dart';
import '../../../presentation/profile/widgets/mine.post.card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void dispose() {
    Get.delete<ProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Obx(() => Column(
            children: [
              if (controller.loading.value) const LoadingBar(),
              _appBar(context),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: UserAvatar(
                  userDto: controller.user.value,
                  size: 100,
                  onUpload: (x) {
                    controller.avatar.value = x;
                  },
                  isLoading: (loading) {
                    controller.loading.value = loading;
                  },
                  localImage: controller.avatar.value,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: controller.user.value.when(
                      emptyState: () => const SizedBox(),
                      loadingState: (_) => const CustomShimmer(
                          show: true, child: Text("This is place holder")),
                      loadedState: (value) => Text(value.phoneNumber,
                          style: Theme.of(context).textTheme.bodyText2),
                      errorState: (_) => const SizedBox())),
              Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: controller.user.value.when(
                      emptyState: () => const SizedBox(),
                      loadingState: (_) => const CustomShimmer(
                            show: true,
                            child: Text("+9765432145789"),
                          ),
                      loadedState: (value) => Text(value.phoneNumber,
                          style: Theme.of(context).textTheme.bodyText2),
                      errorState: (_) => const SizedBox())),
              controller.user.value.when(
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
                            padding: const EdgeInsets.only(top: 60),
                            child: InkWell(
                              onTap: () {},
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
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {},
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
                            height: 60,
                          ),
                          _myPosts(context),
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
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                "assets/icons/bell.png",
                height: 30,
                width: 24,
              ),
            ),
          )
        ])
      ],
    );
  }

  _myPosts(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Posts",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text("Add",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),
              )
            ],
          ),
        ),
        // ListView(
        //   shrinkWrap: true,
        //   scrollDirection: Axis.horizontal,
        //   children: [MyPostCard()],
        // )
        Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            MinePostCard(),
          ],
        )
      ],
    );
  }
}
