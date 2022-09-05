import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app/features/candidate/presentation/widgets/candidate.avatar.dart';

import '../../../../core/widgets/cached.image.provider.dart';
import '../../domain/entities/candidate.dart';

class CandidateCoverCarousalCard extends StatefulWidget {
  const CandidateCoverCarousalCard(
      {Key? key,
      required this.image,
      required this.candidate,
      required this.avatarBorderColor,
      required this.avatarRadius,
      this.scrollAmount = 1,
      this.showAvatar = true,
      this.showName = true,
      this.showVotes = true,
      this.index = 1,
      required this.avatarMargins,
      required this.carousalHeroTag})
      : super(key: key);

  final String image;
  final Candidate candidate;
  final Color avatarBorderColor;
  final String carousalHeroTag;
  final double avatarRadius;
  final double scrollAmount;
  final bool showAvatar;
  final bool showName;
  final bool showVotes;
  final int index;
  final EdgeInsetsGeometry avatarMargins;

  @override
  State<CandidateCoverCarousalCard> createState() =>
      _CandidateCoverCarousalCardState();
}

class _CandidateCoverCarousalCardState
    extends State<CandidateCoverCarousalCard> {
  late double scale;
  late Offset offset;
  late double clampedDifference;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    clampedDifference = (widget.scrollAmount - widget.index).clamp(-1, 1);

    offset = Offset(0.0, 128.0 * clampedDifference);

    scale = lerpDouble(1.0, 0.8, clampedDifference.abs())!;

    return Transform.scale(
        scale: scale,
        child: GestureDetector(
            onTapDown: (_) {
              //print("clicked button");
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Hero(
                  tag: widget.carousalHeroTag,
                  child: CachedImageProvider(
                    borderRadius: 25,
                    image: widget.candidate.coverImages.isNotEmpty
                        ? widget.candidate.coverImages[0]
                        : "assets/img/placeholder.png",
                  ),
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(25),
                  //     image: DecorationImage(
                  //       image: AssetImage(widget.image),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (widget.showAvatar)
                          CandidateAvatar(
                              onClick: () {},
                              hero: widget.candidate.image,
                              candidate: widget.candidate,
                              borderColor: widget.avatarBorderColor,
                              radius: widget.avatarRadius,
                              margins: widget.avatarMargins),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.showName)
                              Text(
                                widget.candidate.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (widget.showVotes)
                              Text(
                                "${widget.candidate.votes} votes",
                                style: TextStyle(
                                    color: Colors.amber.shade400,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
