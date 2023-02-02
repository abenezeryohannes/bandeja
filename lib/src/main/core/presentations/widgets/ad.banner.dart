import 'package:bandeja/src/core/domain/ads/entities/ad.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/util.dart';
import 'ad.banner.card.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({Key? key, required this.ads, this.height = 200})
      : super(key: key);
  final List<AdModel?> ads;
  final double height;
  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  late PageController _pageController;
  double _scrollAmount = 2.0;

  int currentPosition = 2;

  @override
  void initState() {
    currentPosition = widget.ads.length > 2 ? 1 : 0;

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
        ExpandablePageView.builder(
            controller: _pageController,
            itemCount: widget.ads.length,
            itemBuilder: (context, index) {
              return AdBannerCard(
                  scrollAmount: _scrollAmount,
                  ad: widget.ads[index],
                  height: widget.height,
                  index: index,
                  onClick: () {
                    if (widget.ads[index] == null) return;
                    Util.launchUrI(Uri.parse(widget.ads[index]!.link));
                  });
            })
      ],
    );
  }
}
