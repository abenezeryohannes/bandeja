import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../presentation/padels/pages/checkout.page.dart';
import 'padel.card.dart';
import 'schedules.card.dart';

class PadelSearchResultCard extends StatefulWidget {
  const PadelSearchResultCard({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  State<PadelSearchResultCard> createState() => _PadelSearchResultCardState();
}

class _PadelSearchResultCardState extends State<PadelSearchResultCard> {
  DateTime? selectedDate;
  late PageController _pageController;
  double _scrollAmount = 0.0;

  @override
  void initState() {
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ExpandablePageView.builder(
                  controller: _pageController,
                  itemCount: widget.user.getPadels().length,
                  itemBuilder: ((context, index) => InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PadelCard(item: widget.user.getPadels()[index]),
                            SchedulesCard(
                              padel: widget.user.getPadels()[index],
                              date: DateTime.now(),
                              onClick: (DateTime time) {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                      opaque: false, // set to false
                                      pageBuilder: (_, __, ___) => CheckoutPage(
                                          padel: widget.user.getPadels()[index],
                                          time: time)),
                                );
                              },
                              onDateSelected: (DateTime d) {
                                selectedDate = d;
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
            DotsIndicator(
              dotsCount: widget.user.getPadels().length,
              position: _scrollAmount,
              decorator: DotsDecorator(
                  size: const Size(10, 10),
                  activeSize: const Size(40, 10),
                  activeShape: const StadiumBorder(),
                  color: Colors.grey.shade300,
                  activeColor: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ));
  }
}
