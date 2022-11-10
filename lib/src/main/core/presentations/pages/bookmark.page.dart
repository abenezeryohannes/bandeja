import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../presentation/padels/pages/padel.page.dart';
import '../controllers/bookmark.controller.dart';
import '../widgets/padel.card.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final c = Get.put(BookmarkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Saved",
              style: Theme.of(context).textTheme.titleLarge,
            )),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              c.pagingController.refresh();
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: PagedListView<int, PadelModel?>(
                    shrinkWrap: true,
                    pagingController: c.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<PadelModel?>(
                        noItemsFoundIndicatorBuilder: (context) => Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: ShowError(
                                failure: Failure.noDataFailure(
                                    message: 'No bookmarked courts yet!'),
                                errorShowType: ErrorShowType.vertical,
                              ),
                            ),
                        firstPageErrorIndicatorBuilder: (_) => Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: ShowError(
                                failure: c.pagingController.error as Failure,
                                errorShowType: ErrorShowType.vertical,
                              ),
                            ),
                        firstPageProgressIndicatorBuilder: (_) => ListView(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              children: const [
                                PadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                PadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                PadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                PadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                PadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                PadelCard()
                              ],
                            ),
                        itemBuilder: (context, item, index) => Card(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 20),
                            child: InkWell(
                                onTap: () {
                                  if (item != null) {
                                    Navigator.of(context).push(PageRouteBuilder(
                                        opaque: false, // set to false
                                        pageBuilder: (_, __, ___) => PadelPage(
                                              padel: item,
                                            )));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: PadelCard(
                                    item: item,
                                    onBookmarkChanged: () {
                                      c.pagingController.refresh();
                                    },
                                  ),
                                )))),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
