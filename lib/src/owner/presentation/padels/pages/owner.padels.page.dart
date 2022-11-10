import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:bandeja/src/owner/presentation/padels/controllers/owner.padels.page.controller.dart';
import 'package:bandeja/src/owner/presentation/padels/pages/add.padel.page.dart';
import 'package:bandeja/src/owner/presentation/padels/widgets/owner.padel.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';

class OwnerPadelsPage extends StatefulWidget {
  const OwnerPadelsPage({Key? key}) : super(key: key);

  @override
  State<OwnerPadelsPage> createState() => _OwnerPadelsPageState();
}

class _OwnerPadelsPageState extends State<OwnerPadelsPage> {
  final c = Get.put(OwnerPadelsPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Get.to(() => const AddPadelPage());
            if (result != null) {
              c.pagingController.refresh();
            }
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            leading: Container(
                margin: const EdgeInsets.only(top: 14, bottom: 14, left: 25),
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
            title: Text(
              "My Courts",
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
                        firstPageErrorIndicatorBuilder: (_) => ShowError(
                            failure: c.pagingController.error as Failure),
                        firstPageProgressIndicatorBuilder: (_) => ListView(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              children: const [
                                SizedBox(
                                  height: 10,
                                ),
                                OwnerPadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                OwnerPadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                OwnerPadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                OwnerPadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                OwnerPadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                                OwnerPadelCard(),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                        itemBuilder: (context, item, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: InkWell(
                                  onTap: () async {
                                    if (item != null) {
                                      final result = await Get.to(AddPadelPage(
                                        padel: item,
                                      ));
                                      if (result != null) {
                                        c.pagingController.refresh();
                                      }
                                    }
                                  },
                                  child: OwnerPadelCard(item: item)),
                            )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
