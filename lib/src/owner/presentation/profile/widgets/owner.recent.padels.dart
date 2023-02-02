import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/owner/presentation/padels/pages/add.padel.page.dart';
import 'package:bandeja/src/owner/presentation/padels/pages/owner.padels.page.dart';
import 'package:bandeja/src/owner/presentation/profile/widgets/recent.owner.padel.card.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentOwnerPadels extends StatefulWidget {
  const RecentOwnerPadels(
      {Key? key, required this.padel, required this.onRefresh})
      : super(key: key);
  final List<PadelModel?> padel;
  final Function onRefresh;
  @override
  State<RecentOwnerPadels> createState() => _RecentOwnerPadelsState();
}

class _RecentOwnerPadelsState extends State<RecentOwnerPadels> {
  late PageController _pageController;
  double _scrollAmount = 2.0;

  int currentPosition = 2;

  @override
  void initState() {
    currentPosition = widget.padel.length > 2 ? 1 : 0;

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
                'Courts',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                  onPressed: () async {
                    await Get.to(const OwnerPadelsPage());
                    widget.onRefresh();

                    // Navigator.of(context).push(
                    //   PageRouteBuilder(
                    //       opaque: false, // set to false
                    //       pageBuilder: (_, __, ___) => const OwnerPadelsPage()),
                    // );
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
        SizedBox(
          height: 200,
          child: PageView.builder(
              controller: _pageController,
              itemCount: widget.padel.length,
              itemBuilder: (context, index) {
                return RecentOwnerPadelCard(
                    scrollAmount: _scrollAmount,
                    padel: widget.padel[index],
                    height: 200,
                    length: widget.padel.length,
                    index: index,
                    onPowerClick: () {
                      if (widget.padel[index] == null) return;
                    },
                    onEditClick: () async {
                      if (widget.padel[index] == null) return;
                      final result = await Get.to(
                          AddPadelPage(padel: widget.padel[index]));
                      if (result != null) {
                        widget.onRefresh();
                      }
                    },
                    onClick: () {
                      if (widget.padel[index] == null) return;
                      // Navigator.of(context).push(
                      //   PageRouteBuilder(
                      //     opaque: false,
                      //     pageBuilder: (_, __, ___) => PadelPage(
                      //       padel: widget.padel[index]!,
                      //     ),
                      //   ),
                      // );
                    });
              }),
        )
      ],
    );
  }
}
