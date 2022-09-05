import 'package:flutter/material.dart';
import 'package:app/core/widgets/big.text.button.dart';

import 'candidate.avatar.shimmer.dart';

class CandidateCardShimmer extends StatefulWidget {
  const CandidateCardShimmer({
    Key? key,
    this.avatarRadius = 30,
    this.cardRadius = 10,
  }) : super(key: key);

  final double avatarRadius;
  final double cardRadius;

  @override
  State<CandidateCardShimmer> createState() => _CandidateCardShimmerState();
}

class _CandidateCardShimmerState extends State<CandidateCardShimmer> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.cardRadius)),
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            const CandidateAvatarShimmer(
              borderColor: Colors.transparent,
              radius: 32,
              margins: EdgeInsets.zero,
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text("",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 11)),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: BigTextButton(
                  // text: "voice ${widget.candidate.votes}",
                  textWidget: RichText(
                      text: const TextSpan(
                          text: " ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                        TextSpan(
                          text: " ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        )
                      ])),
                  onClick: () {},
                  fontSize: 12,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
            ),
            const SizedBox(
              height: 6,
            ),
          ]),
        ));
  }
}
