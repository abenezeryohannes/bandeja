import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app/features/candidate/presentation/widgets/candidate.avatar.dart';

import '../../../../core/widgets/cached.image.provider.dart';
import '../../domain/entities/candidate.dart';

class CandidateCarousalCard extends StatefulWidget {
  const CandidateCarousalCard(
      {Key? key,
      required this.candidate,
      required this.avatarBorderColor,
      required this.avatarRadius,
      this.scrollAmount = 1,
      this.cornerRadius = 25,
      this.showAvatar = true,
      this.showName = true,
      this.showVotes = true,
      this.index = 1,
      required this.avatarMargins,
      required this.onClick,
      required this.avatarHeroTag,
      required this.cardHeroTag})
      : super(key: key);

  final Candidate candidate;
  final Color avatarBorderColor;
  final double avatarRadius;
  final double cornerRadius;
  final double scrollAmount;
  final bool showAvatar;
  final bool showName;
  final String avatarHeroTag;
  final String cardHeroTag;
  final bool showVotes;
  final Function(String, String) onClick;
  final int index;
  final EdgeInsetsGeometry avatarMargins;

  @override
  State<CandidateCarousalCard> createState() => _CandidateCarousalCardState();
}

class _CandidateCarousalCardState extends State<CandidateCarousalCard> {
  late double scale;
  late Offset offset;
  late double clampedDifference;
  @override
  void initState() {
    super.initState();
  }

  //"${widget.candidate.name}${widget.candidate.id}avatar-carousal",
  // "${widget.candidate.name}${widget.candidate.id}cover"
  @override
  Widget build(BuildContext context) {
    clampedDifference = (widget.scrollAmount - widget.index).clamp(-1, 1);

    offset = Offset(0.0, 128.0 * clampedDifference);

    scale = lerpDouble(1.0, 0.8, clampedDifference.abs())!;

    return Transform.scale(
        scale: scale,
        child: GestureDetector(
            onTapDown: (_) {
              widget.onClick(widget.avatarHeroTag, widget.cardHeroTag);
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Hero(
                //   tag: (widget.candidate.coverImages.isNotEmpty)
                //       ? widget.cardHeroTag
                //       : "${Random()}",
                //   child:
                CachedImageProvider(
                  borderRadius: widget.cornerRadius,
                  image: widget.candidate.coverImages.isNotEmpty
                      ? widget.candidate.coverImages[0]
                      : "assets/img/placeholder.png",
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(widget.cornerRadius),
                //     image: DecorationImage(
                //       image: AssetImage(widget.candidate.coverImages.isNotEmpty
                //           ? widget.candidate.coverImages[0]
                //           : "assets/img/placeholder.png"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                // ),
                // if (widget.showName)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      )),
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
                            hero: widget.avatarHeroTag,
                            candidate: widget.candidate,
                            borderColor: widget.avatarBorderColor,
                            radius: widget.avatarRadius,
                            margins: widget.avatarMargins,
                            onClick: () {
                              widget.onClick(
                                  widget.avatarHeroTag, widget.cardHeroTag);
                            },
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                                "${widget.candidate.votes} صوت",
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
