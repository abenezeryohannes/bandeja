import 'dart:ui';

import 'package:flutter/material.dart';

import 'candidate.avatar.shimmer.dart';

class CandidateCarousalCardShimmer extends StatefulWidget {
  const CandidateCarousalCardShimmer({
    Key? key,
    required this.avatarBorderColor,
    required this.avatarRadius,
    this.scrollAmount = 1,
    this.showAvatar = true,
    this.showName = true,
    this.showVotes = true,
    this.index = 1,
    required this.avatarMargins,
  }) : super(key: key);

  final Color avatarBorderColor;
  final double avatarRadius;
  final double scrollAmount;
  final bool showAvatar;
  final bool showName;
  final bool showVotes;
  final int index;
  final EdgeInsetsGeometry avatarMargins;

  @override
  State<CandidateCarousalCardShimmer> createState() =>
      _CandidateCarousalCardShimmerState();
}

class _CandidateCarousalCardShimmerState
    extends State<CandidateCarousalCardShimmer> {
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
            ),
            if (widget.showName)
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
                      CandidateAvatarShimmer(
                        borderColor: widget.avatarBorderColor,
                        radius: widget.avatarRadius,
                        margins: widget.avatarMargins,
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.showName)
                          const Text(
                            "",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (widget.showVotes)
                          Text(
                            "",
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
        ));
  }
}
