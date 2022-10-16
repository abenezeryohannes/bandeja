import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../../core/presentation/widgets/sizable.pageview.dart';
import '../../../presentation/home/widget/padel.card.with.avatar.dart';
import '../../../presentation/home/widget/padel.groups.tab.dart';
import '../../../presentation/home/widget/post.avatar.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(() => c.itemsGroup.value.when(emptyState: () {
                return const SizedBox();
              }, errorState: (failure) {
                return Expanded(
                    child: Center(child: ShowError(failure: failure)));
              }, loadedState: (value) {
                return SizedBox(
                  height: 70,
                  child: ItemGroupsTab(
                      itemGroups: value,
                      onItemClick: (value) {
                        c.padelRepository.getFeaturedPadels();
                      }),
                );
              }, loadingState: (_) {
                return SizedBox(
                  height: 70,
                  child: ItemGroupsTab(
                      itemGroups: const [
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null
                      ],
                      onItemClick: (value) {
                        c.padelRepository.getFeaturedPadels();
                      }),
                );
              })),
          Expanded(
            child: Center(
              child: SizedBox(
                height: Get.height * (6 / 12),
                child:
                    Obx(() => c.featuredPedalItems.value.when(emptyState: () {
                          return const SizedBox();
                        }, errorState: (failure) {
                          return Expanded(
                              child:
                                  Center(child: ShowError(failure: failure)));
                        }, loadedState: (value) {
                          return _featuredPadelList(value);
                        }, loadingState: (_) {
                          return _featuredPadelList([null, null, null]);
                        })),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Obx(() => c.featuredAds.value.when(emptyState: () {
                  return const SizedBox();
                }, errorState: (failure) {
                  return ShowError(failure: failure);
                }, loadedState: (value) {
                  return _featuredOffers(value);
                }, loadingState: (_) {
                  return _featuredOffers([null, null, null, null, null, null]);
                })),
          ),
          const SizedBox(height: 24)
        ],
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
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            margin: EdgeInsets.only(
                left: (index == 0) ? 20 : 12,
                right: (index == value.length - 1) ? 20 : 4),
            child: Column(
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
                Text(value[index] == null ? '' : value[index]!.title,
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          );
        });
  }
}
