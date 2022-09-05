import 'package:app/core/widgets/cached.image.provider.dart';
import 'package:flutter/material.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';

class CandidateAvatar extends StatefulWidget {
  const CandidateAvatar(
      {Key? key,
      required this.candidate,
      required this.borderColor,
      required this.radius,
      required this.margins,
      required this.hero,
      required this.onClick})
      : super(key: key);

  final Candidate candidate;
  final Color borderColor;
  final String hero;
  final double radius;
  final Function onClick;
  final EdgeInsetsGeometry margins;

  @override
  State<CandidateAvatar> createState() => _CandidateAvatarState();
}

class _CandidateAvatarState extends State<CandidateAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.radius * 2) + 10,
      height: (widget.radius * 2) + 10,
      margin: widget.margins,
      // child:
      // Hero(
      //   tag: widget.hero,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: widget.radius,
                child: CachedImageProvider(
                  borderRadius: 100,
                  height: widget.radius * 2,
                  image: widget.candidate.image,
                  width: widget.radius * 2,
                ),
                // backgroundImage: AssetImage(widget.candidate.image),
              ),
            ),
            InkWell(
              onTap: () {
                widget.onClick();
              },
              child: Container(
                width: (widget.radius * 2) + 10,
                height: (widget.radius * 2) + 10,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: widget.borderColor, width: 2.3)),
              ),
            ),
            if (widget.candidate.verified)
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/img/verify.png",
                  width: 24,
                  height: 24,
                ),
              )
          ],
        ),
      ),
      // ),
    );
  }
}
