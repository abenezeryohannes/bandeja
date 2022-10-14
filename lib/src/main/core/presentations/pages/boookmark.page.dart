import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/domain/padels/entities/padel.dart';
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: PagedListView<int, PadelModel>(
                shrinkWrap: true,
                pagingController: c.pagingController,
                builderDelegate: PagedChildBuilderDelegate<PadelModel>(
                    itemBuilder: (context, item, index) => Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: const EdgeInsets.only(
                            left: 14, right: 14, bottom: 20),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  opaque: false, // set to false
                                  pageBuilder: (_, __, ___) => PadelPage(
                                        padel: item,
                                      )));
                            },
                            child: PadelCard(item: item)))),
              ),
            ),
          ],
        ));
  }
}
