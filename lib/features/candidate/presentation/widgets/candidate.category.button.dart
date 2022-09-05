import 'package:flutter/material.dart';

import '../../domain/entities/candidate.category.dart';

class CandidateCategoryButton extends StatefulWidget {
  const CandidateCategoryButton(
      {Key? key, required this.onClick, required this.category})
      : super(key: key);
  final Function onClick;
  final CandidateCategory category;
  @override
  State<CandidateCategoryButton> createState() =>
      _CandidateCategoryButtonState();
}

class _CandidateCategoryButtonState extends State<CandidateCategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment(0.08, -0.38),
        children: [
          Align(
            alignment: Alignment(0, 0.65),
            child: InkWell(
              onTap: () => {widget.onClick()},
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0XFFECCA34),
                ),
                alignment: Alignment.bottomCenter,
                // child: ,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () => {widget.onClick()},
              child: Text(
                widget.category.number,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    // backgroundColor: Colors.red,
                    color: Colors.black,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w900,
                    fontSize: 32),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
