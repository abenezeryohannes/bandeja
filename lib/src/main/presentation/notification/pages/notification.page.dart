import 'package:bandeja/src/main/presentation/notification/controllers/notification.page.controller.dart';
import 'package:bandeja/src/main/presentation/notification/widgets/notification.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/domain/notifications/entities/notification.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/show.error.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationPageController controller = Get.put(NotificationPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  primary: true,
                  pinned: true,
                  backgroundColor: Colors.grey.shade50,
                  expandedHeight: 140,
                  actions: [
                    Obx(() => controller.notificationWrapper.value.when(
                          emptyState: () => const SizedBox(),
                          loadingState: (_) => const SizedBox(),
                          loadedState: (val) => TextButton(
                              onPressed: () {
                                controller.clearNotifications();
                              },
                              child: TextButton(
                                  onPressed: () {
                                    Get.dialog(Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 40,
                                          vertical: Get.height / 3),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Are You sure?',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              Text(
                                                'This will delete all of your saved notifications!',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    'No.',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                    controller
                                                        .clearNotifications();
                                                  },
                                                  child: Text(
                                                    'Yes, I am sure.',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                                  },
                                  child: Text(
                                    'Clear',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  ))),
                          errorState: (_) => const SizedBox(),
                        ))
                  ],
                  leading: Container(
                      margin:
                          const EdgeInsets.only(top: 14, bottom: 14, left: 20),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              width: 1, color: Colors.grey.shade600)),
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
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.grey.shade50,
                    ),
                    title: Text(
                      "Notifications",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(bottom: 0.0, top: 10),
              child: body(),
            )));
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.pagingController.refresh();
              },
              child: PagedListView<int, NotificationModel?>(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<NotificationModel?>(
                    noItemsFoundIndicatorBuilder: (context) => const Padding(
                        padding: EdgeInsets.only(top: 0.0), child: SizedBox()
                        // child: ShowError(
                        //   failure: Failure.noDataFailure(
                        //       message: 'No Notification\'s for now!'),
                        //   errorShowType: ErrorShowType.vertical,
                        // ),
                        ),
                    firstPageErrorIndicatorBuilder: (_) => Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: ShowError(
                              failure:
                                  controller.pagingController.error as Failure),
                        ),
                    firstPageProgressIndicatorBuilder: (_) => ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 0.0),
                          children: const [
                            NotificationCard(),
                            NotificationCard(),
                            NotificationCard(),
                            NotificationCard()
                          ],
                        ),
                    itemBuilder: (context, item, index) => Card(
                        elevation: 0,
                        color: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: EdgeInsets.only(
                            left: 14,
                            right: 14,
                            bottom: index + 1 ==
                                    controller.pagingController.itemList?.length
                                ? 50
                                : 14),
                        child: InkWell(
                            onTap: () {
                              if (item != null) {}
                            },
                            child: NotificationCard(
                              notification: item,
                            )))),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leadingWidth: 56,
      leading: Container(
          margin: const EdgeInsets.only(top: 14, bottom: 14, left: 20),
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
      actions: [
        TextButton(
            onPressed: () {
              controller.clearNotifications();
            },
            child: Text(
              'Clear',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ))
      ],
    );
  }
}
