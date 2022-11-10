import 'package:bandeja/src/admin/presentation/padels/widgets/admin.padel.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/drop.down.form.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../controllers/admin.padels.page.controller.dart';

class AdminPadelsPage extends StatefulWidget {
  const AdminPadelsPage({Key? key}) : super(key: key);

  @override
  State<AdminPadelsPage> createState() => _AdminPadelsPageState();
}

class _AdminPadelsPageState extends State<AdminPadelsPage> {
  AdminPadelsPageController controller = Get.put(AdminPadelsPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.grey.shade50,
                  floating: true,
                  iconTheme: const IconThemeData(size: 0),
                  leadingWidth: 0,
                  leading: null,
                  collapsedHeight: 60,
                  expandedHeight: 100,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: _search(),
                    ),
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
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
            child: Obx(() => _tabs())),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
            },
            child: PagedListView<int, PadelModel?>(
              shrinkWrap: true,
              pagingController: controller.pagingController,
              padding: EdgeInsets.zero,
              builderDelegate: PagedChildBuilderDelegate<PadelModel?>(
                  noItemsFoundIndicatorBuilder: (context) => Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: ShowError(
                          failure: Failure.noDataFailure(message: 'No Courts!'),
                          errorShowType: ErrorShowType.vertical,
                        ),
                      ),
                  firstPageErrorIndicatorBuilder: (_) => Padding(
                        padding: const EdgeInsets.only(
                            top: 50.0, left: 20, right: 20),
                        child: ShowError(
                            errorShowType: ErrorShowType.vertical,
                            failure:
                                controller.pagingController.error as Failure),
                      ),
                  firstPageProgressIndicatorBuilder: (_) => ListView(
                        shrinkWrap: true,
                        children: List.generate(
                            6,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16, bottom: 16),
                                  child: AdminPadelCard(
                                      height: 220,
                                      index: 0,
                                      onPowerClick: () {},
                                      onPhoneClick: () async {},
                                      onClick: (_) {}),
                                )),
                      ),
                  itemBuilder: (context, item, index) => _item(index, item)),
            ),
          ),
        )
      ],
    );
  }

  Widget _item(int index, PadelModel? item) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      child: AdminPadelCard(
          padel: item,
          height: 220,
          index: 0,
          onPowerClick: () {},
          onPhoneClick: () {},
          onClick: (_) {}),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        "Courts",
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(),
    );
  }

  Widget _search() {
    return Material(
      elevation: 1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 24,
            color: Theme.of(context).hintColor.withOpacity(0.4),
          ),
          hintText: 'Search by Courts Name',
          filled: true,
          fillColor: Colors.grey.shade100,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        ),
        onChanged: (val) {
          if (val.isEmpty) {
            controller.search.value = null;
          } else {
            controller.search.value = val;
          }
        },
      ),
    );
  }

  Widget _tabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Row(
            children: [
              Text('All Courts ',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
              Text('${controller.padelsCount.value ?? ''}',
                  style: Theme.of(context).textTheme.subtitle2),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
          child: DropDownForm(
            value: (controller.enabled.value ?? true) ? 'Active' : 'In Active',
            placeholder: 'Active',
            onChange: (_, dynamic value) {
              controller.enabled.value = value as bool;
            },
            options: const [
              {'Active': true},
              {'In Active': false}
            ],
            label: '',
            elevation: 1,
            radius: 14,
          ),
        ),
      ],
    );
  }
}
