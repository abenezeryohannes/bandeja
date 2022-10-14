import 'package:feekpadel/src/core/widgets/toggle.form.dart';
import 'package:feekpadel/src/main/core/presentations/widgets/padel.search.result.card..dart';
import 'package:feekpadel/src/main/domain/authentication/entities/user.dart';
import 'package:feekpadel/src/main/domain/core/entities/address.dart';
import 'package:feekpadel/src/main/domain/padels/entities/padel.group.dart';
import 'package:feekpadel/src/main/presentation/search/search.result.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/util.dart';
import '../../../core/widgets/show.error.dart';
import '../../../core/widgets/tab.bar.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage(
      {Key? key, this.addressModel, this.padelGroupModel, required this.date})
      : super(key: key);
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
    controller = Get.put(SearchResultController(
        address: widget.addressModel,
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
        backgroundColor: Colors.grey.shade50,
        appBar: _appBar(),
        body: SafeArea(
          child: Column(
            children: [
              _tabBar(),
              const SizedBox(
                height: 10,
              ),
              Obx(() => controller.filterOwners.value.when(emptyState: () {
                    return const SizedBox();
                  }, errorState: (failure) {
                    return Expanded(
                        child: Center(child: ShowError(failure: failure)));
                  }, loadedState: (value) {
                    return Expanded(
                      child: PagedListView<int, UserModel>(
                        shrinkWrap: true,
                        pagingController: controller.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<UserModel>(
                            itemBuilder: (context, item, index) =>
                                PadelSearchResultCard(
                                  user: value[index],
                                )),
                      ),
                    );
                  }, loadingState: (_) {
                    return const CircularProgressIndicator();
                  })),
            ],
          ),
        ));
  }

  Widget _tabBar() {
    var tt =
        times.map((e) => CircularTab(text: DateFormat.jm().format(e))).toList();
    tt.insert(0, CircularTab(text: 'Anytime'));
    return Container(
      color: Colors.white,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CircularTabBar(
          onItemClick: (int index) {
            setState(() {
              controller.pickeddate.value = (times[index]);
              controller.pickedTime.value = (times[index]);
            });
          },
          tabs: tt,
          value: (controller.pickedTime.value == null)
              ? 0
              : times.indexOf(controller.pickedTime.value!),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "Near by",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ToggleForm(
              value: controller.indoor.value,
              inactiveText: "Out",
              activeText: "In",
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
