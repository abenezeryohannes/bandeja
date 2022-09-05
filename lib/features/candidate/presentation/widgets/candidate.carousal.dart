import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';
import 'package:app/features/candidate/presentation/widgets/candidate.carousal.card.dart';

import '../../../../core/pages/candidate.page.dart';

class CandidateCarousal extends StatefulWidget {
  const CandidateCarousal(
      {Key? key,
      required this.candidates,
      this.height = 400,
      this.cornerRadius = 25,
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
  final double cornerRadius;
  final bool showName;
  final bool showVotes;
  final bool indicator;
  final double viewFraction;
  final List<Candidate> candidates;
  @override
  State<CandidateCarousal> createState() => _CandidateCarousalState();
}

class _CandidateCarousalState extends State<CandidateCarousal> {
  late PageController _pageController;
  double _scrollAmount = 0.0;
  // final blocProvider = sl<FeaturedCandidatesBloc>();

  @override
  void initState() {
    _scrollAmount = (widget.candidates.length) / 2;
    _pageController = PageController(
        viewportFraction: widget.viewFraction,
        initialPage: _scrollAmount.toInt());
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
    return _body(widget.candidates);
  }

  Widget _body(List<Candidate> candidates) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
              controller: _pageController,
              itemCount: candidates.length,
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemBuilder: (context, index) => CandidateCarousalCard(
                  avatarHeroTag:
                      "${candidates[index].name}${candidates[index].id}${Random()}avatar-carousal",
                  cardHeroTag:
                      "${candidates[index].name}${candidates[index].id}${Random()}cover",
                  candidate: candidates[index],
                  onClick: (avatar_hero, card_hero) {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (_, __, ___) => CandidatePage(
                                candidate: candidates[index],
                                avatar_hero_tag: avatar_hero,
                                cover_hero_tag: card_hero)));
                  },
                  avatarBorderColor: Colors.black,
                  avatarRadius: 25,
                  showAvatar: widget.showAvatar,
                  showName: widget.showName,
                  showVotes: widget.showVotes,
                  scrollAmount: _scrollAmount,
                  cornerRadius: widget.cornerRadius,
                  index: index,
                  avatarMargins: const EdgeInsets.fromLTRB(10, 5, 10, 0))),
        ),
        const SizedBox(height: 8),
        if (widget.indicator)
          Row(
            mainAxisAlignment: (widget.indicatorLocation == "start"
                ? (MainAxisAlignment.start)
                : ((widget.indicatorLocation == "end")
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center)),
            children: [
              DotsIndicator(
                dotsCount: candidates.length,
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
        const SizedBox(height: 5),
      ],
    );
  }
}
