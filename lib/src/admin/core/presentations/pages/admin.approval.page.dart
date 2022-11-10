import 'package:bandeja/src/admin/core/presentations/controllers/admin.approval.page.controller.dart';
import 'package:bandeja/src/admin/presentation/padels/pages/admin.padel.page.dart';
import 'package:bandeja/src/admin/presentation/padels/pages/approve.padel.bottom.sheet.dart';
import 'package:bandeja/src/admin/presentation/padels/widgets/approve.padel.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/drop.down.form.dart';
import '../../../../core/presentation/widgets/show.error.dart';

class AdminApprovalPage extends StatefulWidget {
  const AdminApprovalPage({Key? key}) : super(key: key);

  @override
  State<AdminApprovalPage> createState() => _AdminApprovalPageState();
}

class _AdminApprovalPageState extends State<AdminApprovalPage> {
  AdminApprovalPageController controller =
      Get.put(AdminApprovalPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50, appBar: _appBar(), body: _body());
  }

  Widget _body() {
    return Column(
      children: [
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
                          failure:
                              Failure.noDataFailure(message: 'No Request!'),
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
                            (index) => ApprovePadelCard(
                                  onClick: (_) {},
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
    return ApprovePadelCard(
      padel: item,
      onClick: (padel) async {
        final result = await Get.to(AdminPadelPage(padel: padel));
        if (result != null) {
          controller.pagingController.refresh();
        }
      },
    );
  }

  Widget _tabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropDownForm(
            value: (controller.approved.value ?? true)
                ? 'Approved'
                : 'Not Approved',
            placeholder: 'Not Approved',
            onChange: (_, dynamic value) {
              if ((value as String) == 'Approved') {
                controller.approved.value = true;
              } else {
                controller.approved.value = false;
              }
            },
            options: const [
              {'Approved': true},
              {'Not Approved': false}
            ],
            label: '',
            elevation: 1,
            radius: 14,
          ),
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "New Courts",
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
}
