import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'candidate.carousal.card.shimmer.dart';

class CandidateCarousalShimmer extends StatefulWidget {
  const CandidateCarousalShimmer(
      {Key? key,
      this.height = 400,
      this.indicator = false,
      this.viewFraction = (9 / 12),
      this.indicatorLocation = "center",
      this.showAvatar = true,
      this.showName = true,
      this.showVotes = true})
      : super(key: key);
  final double height;
  final String indicatorLocation;
  final bool showAvatar;
  final bool showName;
  final bool showVotes;
  final bool indicator;
  final double viewFraction;
  @override
  State<CandidateCarousalShimmer> createState() =>
      _CandidateCarousalShimmerState();
}

class _CandidateCarousalShimmerState extends State<CandidateCarousalShimmer> {
  late PageController _pageController;
  double _scrollAmount = 0.0;
  // final blocProvider = sl<FeaturedCandidatesBloc>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: widget.viewFraction);
    _pageController.addListener(() {
      setState(() {
        _scrollAmount = _pageController.page!;
      });
    });
    // blocProvider.add(GetFeaturedCandidatesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CandidateCarousalCardShimmer(
                    avatarBorderColor: Colors.black,
                    avatarRadius: 25,
                    showAvatar: widget.showAvatar,
                    showName: widget.showName,
                    showVotes: widget.showVotes,
                    scrollAmount: _scrollAmount,
                    index: index,
                    avatarMargins: const EdgeInsets.fromLTRB(10, 5, 10, 0))),
          ),
        ),
        const SizedBox(height: 8),
        if (widget.indicator)
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Row(
              mainAxisAlignment: (widget.indicatorLocation == "start"
                  ? (MainAxisAlignment.start)
                  : ((widget.indicatorLocation == "end")
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.center)),
              children: [
                DotsIndicator(
                  dotsCount: 3,
                  position: _scrollAmount,
                  decorator: DotsDecorator(
                      size: const Size(8, 8),
                      activeSize: const Size(20, 8),
                      activeShape: const StadiumBorder(),
                      color: Colors.grey.shade300,
                      activeColor: Colors.amber.shade400),
                ),
                if ((widget.indicatorLocation == "end"))
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 1 / 12),
                  )
              ],
            ),
          ),
        const SizedBox(height: 5),
      ],
    );
  }
}
