import 'package:flutter/material.dart';

class CandidateCategoryButtonShimmer extends StatefulWidget {
  const CandidateCategoryButtonShimmer({Key? key}) : super(key: key);
  @override
  State<CandidateCategoryButtonShimmer> createState() =>
      _CandidateCategoryButtonShimmerState();
}

class _CandidateCategoryButtonShimmerState
    extends State<CandidateCategoryButtonShimmer> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      elevation: 2.0,
      fillColor: Colors.amber.shade400,
      padding: const EdgeInsets.all(5.0),
      shape: const CircleBorder(),
      child: const Text(
        "",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
    ;
  }
}
