import 'package:bandeja/src/main/core/presentations/widgets/padel.search.result.card..dart';
import 'package:bandeja/src/main/domain/core/entities/address.dart';
import 'package:bandeja/src/main/presentation/search/search.result.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../core/domain/authentication/entities/user.dart';
import '../../../core/domain/padels/entities/duration.dart';
import '../../../core/domain/padels/entities/padel.group.dart';
import '../../../core/error/failure.dart';
import '../../../core/presentation/widgets/show.error.dart';
import '../../../core/presentation/widgets/tab.bar.dart';
import '../../../core/presentation/widgets/toggle.form.dart';
import '../../../core/utils/util.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage(
      {Key? key,
      this.addressModel,
      this.padelGroupModel,
      required this.date,
      this.duration})
      : super(key: key);
  final DurationModel? duration;
  final AddressModel? addressModel;
  final PadelGroupModel? padelGroupModel;
  final DateTime date;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late SearchResultController controller;
  late List<DateTime> times;

  @override
  void initState() {
    times = Util.times(widget.date);
    times.insert(0, DateTime(0, 0, 0));
    controller = Get.put(SearchResultController(
        address: widget.addressModel,
        duration: widget.duration,
        date: widget.date,
        padelGroup: widget.padelGroupModel));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SearchResultController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.grey.shade100,
                  floating: true,
                  iconTheme: const IconThemeData(size: 0),
                  leadingWidth: 0,
                  leading: null,
                  collapsedHeight: 60,
                  expandedHeight: 100,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    title: _tabBar(),
                    titlePadding: EdgeInsets.zero,
                    expandedTitleScale: 1,
                    background: _appBar(),
                  ),
                ),
              ];
            },
            body: _body()));
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
            },
            child: PagedListView<int, UserModel>(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<UserModel>(
                  noItemsFoundIndicatorBuilder: (context) => Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: ShowError(
                          img: 'assets/icons/NoSearchResult.png',
                          imgSize: 200,
                          failure: Failure.noDataFailure(
                              message:
                                  'Sorry, No open Courts at this time yet.'),
                          errorShowType: ErrorShowType.vertical,
                        ),
                      ),
                  firstPageErrorIndicatorBuilder: (_) => Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: ShowError(
                            failure:
                                controller.pagingController.error as Failure),
                      ),
                  firstPageProgressIndicatorBuilder: (_) => ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        children: const [
                          PadelSearchResultCard(),
                          PadelSearchResultCard(),
                          PadelSearchResultCard(),
                          PadelSearchResultCard(),
                          PadelSearchResultCard(),
                          PadelSearchResultCard(),
                        ],
                      ),
                  itemBuilder: (context, item, index) {
                    if ((item).getPadels().isEmpty) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: (index + 1 >=
                                  (controller
                                          .pagingController.itemList?.length ??
                                      0))
                              ? 50
                              : 0),
                      child: PadelSearchResultCard(
                        user: item,
                      ),
                    );
                  }),
            ),
          ),
        )
      ],
    );
  }

  Widget _tabBar() {
    var tt = times
        .map((e) =>
            CircularTab(text: DateFormat.jm().format(e), color: Colors.white))
        .toList();
    tt.removeAt(0);
    tt.insert(0, CircularTab(text: 'Anytime', color: Colors.white));
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CircularTabBar(
            onItemClick: (int index) {
              setState(() {
                controller.pickedTimeIndex.value = index;
                if (index == 0) {
                  controller.pickedTime.value = null;
                  return;
                }
                controller.pickeddate.value = (times[index]);
                controller.pickedTime.value = (times[index]);
              });
            },
            tabs: tt,
            value: controller.pickedTimeIndex.value),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "Near By",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
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
              Icons.close,
              size: 24,
              color: Colors.black,
            ),
          )),
      actions: [
        Container(
          width: 86,
          margin: const EdgeInsets.only(top: 14, bottom: 14, right: 10),
          child: ToggleForm(
              value: controller.indoor.value,
              inactiveText: "Outdoor",
              activeText: "Indoor",
              width: 86,
              onChange: (val) {
                setState(() {
                  controller.indoor.value = val;
                });
              }),
        )
      ],
    );
  }
}
