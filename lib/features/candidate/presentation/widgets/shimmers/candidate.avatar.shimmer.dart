import 'package:flutter/material.dart';

class CandidateAvatarShimmer extends StatefulWidget {
  const CandidateAvatarShimmer(
      {Key? key,
      required this.borderColor,
      required this.radius,
      required this.margins})
      : super(key: key);

  final Color borderColor;
  final double radius;
  final EdgeInsetsGeometry margins;

  @override
  State<CandidateAvatarShimmer> createState() => _CandidateAvatarShimmerState();
}

class _CandidateAvatarShimmerState extends State<CandidateAvatarShimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.radius * 2) + 10,
      height: (widget.radius * 2) + 10,
      margin: widget.margins,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: widget.radius,
                backgroundColor: Colors.white,
                // backgroundImage: AssetImage(widget.candidate.image),
              ),
            ),
            Container(
              width: (widget.radius * 2) + 10,
              height: (widget.radius * 2) + 10,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: widget.borderColor, width: 2)),
            ),
          ],
        ),
      ),
    );
  }
}
