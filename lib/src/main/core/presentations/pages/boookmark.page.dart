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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: PagedListView<int, PadelModel?>(
                  shrinkWrap: true,
                  pagingController: c.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<PadelModel?>(
                      firstPageErrorIndicatorBuilder: (_) => ShowError(
                          failure: c.pagingController.error as Failure),
                      firstPageProgressIndicatorBuilder: (_) => ListView(
                            shrinkWrap: true,
                            children: const [
                              PadelCard(),
                              PadelCard(),
                              PadelCard(),
                              PadelCard(),
                              PadelCard(),
                              PadelCard()
                            ],
                          ),
                      itemBuilder: (context, item, index) => Card(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          margin: const EdgeInsets.only(
                              left: 14, right: 14, bottom: 20),
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
                              child: PadelCard(item: item)))),
                ),
              )
            ],
          ),
        ));
  }
}
