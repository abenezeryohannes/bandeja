import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:bandeja/src/owner/core/presentation/controllers/owner.promo.code.page.controller.dart';
import 'package:bandeja/src/owner/presentation/promo_code/page/edit.promo.code.bottom.sheet.dart';
import 'package:bandeja/src/owner/presentation/promo_code/page/promo.code.bottom.sheet.dart';
import 'package:bandeja/src/owner/presentation/promo_code/widgets/owner.promo.code.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/show.error.dart';

class OwnerPromoCodePage extends StatefulWidget {
  const OwnerPromoCodePage({Key? key}) : super(key: key);

  @override
  State<OwnerPromoCodePage> createState() => _OwnerPromoCodePageState();
}

class _OwnerPromoCodePageState extends State<OwnerPromoCodePage> {
  OwnerPromoCodePageController controller =
      Get.put(OwnerPromoCodePageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          _appBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: addNewButton(),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.pagingController.refresh();
              },
              child: PagedListView<int, PromoCodeModel?>(
                shrinkWrap: true,
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<PromoCodeModel?>(
                    firstPageErrorIndicatorBuilder: (_) => ShowError(
                        failure: controller.pagingController.error as Failure),
                    firstPageProgressIndicatorBuilder: (_) => ListView(
                          shrinkWrap: true,
                          children: [
                            OwnerPromoCodeCard(onClick: (_) {}),
                            OwnerPromoCodeCard(onClick: (_) {}),
                            OwnerPromoCodeCard(onClick: (_) {}),
                            OwnerPromoCodeCard(onClick: (_) {}),
                            OwnerPromoCodeCard(onClick: (_) {}),
                            OwnerPromoCodeCard(onClick: (_) {}),
                          ],
                        ),
                    itemBuilder: (context, item, index) => OwnerPromoCodeCard(
                          promo: item,
                          onClick: (promo) async {
                            final result = await Get.bottomSheet(
                                isScrollControlled: true,
                                EditPromoCodeBottomSheet(
                                  promoCode: promo,
                                ));
                            if (result != null) {
                              controller.pagingController.refresh();
                            }
                          },
                        )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget addNewButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Promo Codes',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Card(
          color: Theme.of(context).colorScheme.secondary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: InkWell(
            onTap: () async {
              final result = await Get.bottomSheet(
                  isScrollControlled: true, const PromoCodeBottomSheet());
              if (result != null) {
                controller.pagingController.refresh();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Promo",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        )
      ],
    );
  }
}
