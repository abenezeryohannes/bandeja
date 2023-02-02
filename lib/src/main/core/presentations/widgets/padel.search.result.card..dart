import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../presentation/booking/pages/checkout.page.dart';
import 'padel.card.dart';
import 'schedules.card.dart';

class PadelSearchResultCard extends StatefulWidget {
  const PadelSearchResultCard({
    Key? key,
    this.user,
  }) : super(key: key);
  final UserModel? user;

  @override
  State<PadelSearchResultCard> createState() => _PadelSearchResultCardState();
}

class _PadelSearchResultCardState extends State<PadelSearchResultCard> {
  DateTime? selectedDate;
  late PageController _pageController;
  double _scrollAmount = 0.0;
  bool showScroll = false;

  @override
  void initState() {
    _scrollAmount = 0.0;
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          showScroll = (widget.user?.Padels?.length ?? 0) > 0;
        });
      }
    });
    _pageController = PageController(initialPage: _scrollAmount.toInt());
    _pageController.addListener(() {
      setState(() {
        _scrollAmount = _pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ExpandablePageView.builder(
                  controller: _pageController,
                  itemCount: widget.user?.getPadels().length ?? 1,
                  itemBuilder: ((context, index) => InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: PadelCard(
                                  item: widget.user?.getPadels()[index]),
                            ),
                            SchedulesCard(
                              schedules: widget.user == null
                                  ? [null]
                                  : widget.user!
                                          .getPadels()[index]
                                          .PadelSchedules ??
                                      [null],
                              date: DateTime.now(),
                              onClick: (PadelScheduleModel scheduleModel) {
                                selectedDate = scheduleModel.startTime;
                                // if (scheduleModel.booked) return;
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                      opaque: false, // set to false
                                      pageBuilder: (_, __, ___) => CheckoutPage(
                                          padel:
                                              widget.user!.getPadels()[index],
                                          schedule: scheduleModel)),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ))),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: showScroll ? 1 : 0,
              child: DotsIndicator(
                dotsCount: widget.user?.getPadels().length ?? 1,
                position: _scrollAmount,
                decorator: DotsDecorator(
                    size: const Size(10, 10),
                    activeSize: const Size(40, 10),
                    activeShape: const StadiumBorder(),
                    color: Colors.grey.shade300,
                    activeColor: Theme.of(context).colorScheme.secondary),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ));
  }
}
