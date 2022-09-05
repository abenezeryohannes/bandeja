import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';

import 'candidate.cover.carousal.card.dart';

class CandidateCoverCarousal extends StatefulWidget {
  const CandidateCoverCarousal(
      {Key? key,
      required this.candidate,
      this.height = 400,
      this.indicator = false,
      this.viewFraction = (9 / 12),
      this.indicatorLocation = "center",
      this.showAvatar = true,
      this.showName = true,
      this.showVotes = true,
      required this.avatarHeroTag,
      required this.carousalHeroTag})
      : super(key: key);
  final double height;
  final String indicatorLocation;
  final bool showAvatar;
  final bool showName;
  final String avatarHeroTag;
  final String carousalHeroTag;
  final bool showVotes;
  final bool indicator;
  final double viewFraction;
  final Candidate candidate;
  @override
  State<CandidateCoverCarousal> createState() => _CandidateCoverCarousalState();
}

class _CandidateCoverCarousalState extends State<CandidateCoverCarousal> {
  late PageController _pageController;
  double _scrollAmount = 0.0;
  int currentPosition = 0;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: widget.viewFraction);

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
        widget.candidate.coverImages.isEmpty
            ? Container(
                height: widget.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade300),
              )
            : SizedBox(
                height: widget.height,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.candidate.coverImages.length,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      onPageChange(index);
                    },
                    itemBuilder: (context, index) => CandidateCoverCarousalCard(
                        image: widget.candidate.coverImages[index],
                        candidate: widget.candidate,
                        avatarBorderColor: Colors.black,
                        avatarRadius: 25,
                        carousalHeroTag: (index == 0)
                            ? widget.carousalHeroTag
                            : widget.carousalHeroTag + index.toString(),
                        showAvatar: widget.showAvatar,
                        showName: widget.showName,
                        showVotes: widget.showVotes,
                        scrollAmount: _scrollAmount,
                        index: index,
                        avatarMargins: const EdgeInsets.fromLTRB(0, 5, 10, 0))),
              ),
        SizedBox(height: 8),
        if (widget.indicator)
          Row(
            mainAxisAlignment: (widget.indicatorLocation == "start"
                ? (MainAxisAlignment.start)
                : ((widget.indicatorLocation == "end")
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center)),
            children: [
              DotsIndicator(
                dotsCount: widget.candidate.coverImages.length,
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
        SizedBox(height: 8),
      ],
    );
  }
}
