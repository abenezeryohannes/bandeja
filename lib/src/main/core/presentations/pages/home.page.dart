import 'package:bandeja/src/core/domain/padels/entities/padel.group.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../../core/presentation/widgets/sizable.pageview.dart';
import '../../../presentation/home/widget/padel.card.with.avatar.dart';
import '../../../presentation/home/widget/post.avatar.dart';
import '../../../presentation/home/widget/scrollable_tab_bar.dart';
import '../../../presentation/padels/pages/padel.page.dart';
import '../../../presentation/posts/widget/post.bottom.sheet.dart';
import '../controllers/home.controller.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({Key? key}) : super(key: key);
  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  final HomeController c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Material(
              elevation: 2,
              child: Obx(() => c.itemsGroup.value.when(emptyState: () {
                    return const SizedBox();
                  }, errorState: (failure) {
                    return const SizedBox();
                    // return Expanded(
                    //     child: Center(child: ShowError(failure: failure)));
                  }, loadedState: (value) {
                    return SizedBox(
                      height: 70,
                      child: ScrollableTabBar(
                          (value as List<PadelGroupModel?>)
                              .map((e) => ScrollableTab(e?.icon, e?.name))
                              .toList(),
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey.shade700,
                          iconSize: 24,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                          height: 80, onSelected: (index) {
                        if (c.itemsGroups.value.length > index) {
                          if (index == 0) {
                            c.pickedPadelGroup.value = null;
                            return;
                          }
                          c.pickedPadelGroup.value = c.itemsGroups.value[index];
                        }
                      }),
                    );
                  }, loadingState: (_) {
                    return SizedBox(
                      height: 70,
                      child: ScrollableTabBar(
                        ((const [null, null, null, null, null]))
                            .map((e) => ScrollableTab(null, null))
                            .toList(),
                        activeColor: Colors.grey.shade900,
                        inactiveColor: Theme.of(context).disabledColor,
                        iconSize: 25,
                        height: 80,
                        onSelected: (_) {},
                      ),
                    );
                  })),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  c.loadUser();
                  c.getItemGroup();
                  c.getFeaturedAds();
                  c.getFeaturedPadelItems();
                },
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 20, bottom: 10),
                      child: Row(
                        children: [
                          Obx(() => c.featuredPedalItems.value.when(
                              emptyState: () => const SizedBox(),
                              loadingState: (_) => Text(
                                    'Near By',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                              loadedState: (x) =>
                                  (x as List<PadelModel>).isNotEmpty
                                      ? Text(
                                          'Near By',
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400),
                                        )
                                      : const SizedBox(),
                              errorState: (_) => const SizedBox())),
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: Get.height * (7 / 15),
                        child: Obx(() =>
                            c.featuredPedalItems.value.when(emptyState: () {
                              return const SizedBox();
                            }, errorState: (failure) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ShowError(
                                  failure: failure,
                                  errorShowType: ErrorShowType.vertical,
                                ),
                              );
                            }, loadedState: (value) {
                              if ((value as List<PadelModel>).isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 120.0),
                                  child: ShowError(
                                    failure: Failure.noDataFailure(
                                        message: 'No Court found here!'),
                                    errorShowType: ErrorShowType.vertical,
                                  ),
                                );
                              }
                              return _featuredPadelList(value);
                            }, loadingState: (_) {
                              return _featuredPadelList([null, null, null]);
                            })),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 20, bottom: 10),
                      child: Row(
                        children: [
                          Obx(() => c.featuredAds.value.when(
                              emptyState: () => const SizedBox(),
                              loadingState: (_) => Text(
                                    'Padels Posts!',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                              loadedState: (x) =>
                                  (x as List<PostModel>).isNotEmpty
                                      ? Text(
                                          'Padels Posts!',
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400),
                                        )
                                      : const SizedBox(),
                              errorState: (_) => const SizedBox())),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Obx(() => c.featuredAds.value.when(emptyState: () {
                            return const SizedBox();
                          }, errorState: (failure) {
                            return const SizedBox();
                            // return ShowError(failure: failure);
                          }, loadedState: (value) {
                            return _featuredOffers(value);
                          }, loadingState: (_) {
                            return _featuredOffers(
                                [null, null, null, null, null, null]);
                          })),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }

  Widget _featuredPadelList(List<PadelModel?> value) {
    return SizablePageView(
        bodies: value
            .map((e) => Padding(
                  padding: EdgeInsets.only(
                      right: value.indexOf(e) == value.length - 1 ? 20 : 0,
                      left: value.indexOf(e) > 0 ? 20 : 20),
                  child: PadelCardWithAvatar(
                    item: e,
                    avatarBorderColor: Colors.white,
                    avatarRadius: 40,
                    onClick: (_, __) {
                      if (e != null) {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false, // set to false
                            pageBuilder: (_, __, ___) => PadelPage(
                                  padel: e,
                                )));
                      }
                    },
                    avatarHeroTag: "avatarHeroTag",
                    cardHeroTag: "cardHeroTag",
                    avatarMargins:
                        const EdgeInsets.only(left: 16, right: 4, bottom: 2),
                  ),
                ))
            .toList(),
        viewFraction: 0.85);
  }

  Widget _featuredOffers(List<PostModel?> value) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: value.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            color: Colors.transparent,
            margin: EdgeInsets.only(
                left: (index == 0) ? 20 : 12,
                right: (index == value.length - 1) ? 20 : 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PostAvatar(
                    item: value[index],
                    borderColor: Colors.black,
                    radius: 30,
                    margins: const EdgeInsets.only(bottom: 5),
                    hero: "hero",
                    onClick: () {
                      if (value[index] == null) return;
                      Get.bottomSheet(PostBottomSheet(post: value[index]!));
                    }),
                Text(value[index]?.User?.fullName ?? '',
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          );
        });
  }
}
