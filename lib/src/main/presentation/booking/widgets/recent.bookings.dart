import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/main/presentation/booking/pages/my.booking.page.dart';
import 'package:bandeja/src/main/presentation/booking/widgets/recent.booking.card.dart';
import 'package:bandeja/src/main/presentation/padels/widgets/qr.modal.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../../core/utils/util.dart';
import '../../padels/pages/booking.page.dart';

class RecentBooking extends StatefulWidget {
  const RecentBooking({Key? key, required this.padelOrders}) : super(key: key);
  final List<PadelOrderModel?> padelOrders;
  @override
  State<RecentBooking> createState() => _RecentBookingState();
}

class _RecentBookingState extends State<RecentBooking> {
  late PageController _pageController;
  double _scrollAmount = 2.0;

  int currentPosition = 2;

  @override
  void initState() {
    currentPosition = widget.padelOrders.length > 2 ? 2 : 0;

    _scrollAmount = (currentPosition).toDouble();

    _pageController =
        PageController(initialPage: currentPosition, viewportFraction: 0.85);

    _pageController.addListener(() {
      setState(() {
        _scrollAmount = _pageController.page!;
      });
    });

    super.initState();
  }

  void onPageChange(int index) {
    setState(() {
      currentPosition = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Last booking',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => const MyBookingPage()),
                    );
                  },
                  child: Text(
                    'View All',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.grey.shade600),
                  ))
            ],
          ),
        ),
        ExpandablePageView.builder(
            controller: _pageController,
            itemCount: widget.padelOrders.length,
            itemBuilder: (context, index) {
              return RecentBookingCard(
                  scrollAmount: _scrollAmount,
                  padelOrder: widget.padelOrders[index],
                  height: 220,
                  index: index,
                  onQrClick: () {
                    if (widget.padelOrders[index] == null) return;
                    Get.dialog(Container(
                        margin:
                            EdgeInsets.symmetric(vertical: Get.height * 1 / 6),
                        child: Center(
                            child: QrModal(
                                padelOrder: widget.padelOrders[index]!))));
                  },
                  onLocationClick: () async {
                    if (widget.padelOrders[index] == null) return;
                    if (widget.padelOrders[index]!.getPadel().Location ==
                        null) {
                      return;
                    }
                    try {
                      await Util.launchUrI(Api.mapUrI(
                          widget.padelOrders[index]!.getPadel().Location!));
                    } on Failure catch (f) {
                      AppSnackBar.failure(failure: f);
                    }
                  },
                  onClick: () {
                    if (widget.padelOrders[index] == null) return;
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => BookingPage(
                          padel: widget.padelOrders[index]!.getPadel(),
                          order: widget.padelOrders[index]!,
                        ),
                      ),
                    );
                  });
            })
      ],
    );
  }
}
