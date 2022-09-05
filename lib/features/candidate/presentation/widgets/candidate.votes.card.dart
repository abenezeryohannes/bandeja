import 'package:flutter/material.dart';
import 'package:app/core/widgets/show.error.dart';
import 'package:app/features/candidate/presentation/bloc/Candidate/candidate.bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/widgets/big.text.button.dart';
import '../../domain/entities/candidate.dart';

class CandidateVotesCard extends StatefulWidget {
  const CandidateVotesCard(
      {Key? key, required this.candidateState, required this.candidate})
      : super(key: key);
  final CandidateState candidateState;
  final Candidate candidate;

  @override
  State<CandidateVotesCard> createState() => _CandidateVotesCardState();
}

class _CandidateVotesCardState extends State<CandidateVotesCard> {
  @override
  Widget build(BuildContext context) {
    switch (widget.candidateState.runtimeType) {
      case CandidateStateLoading:
        return _bigButtonShimmer();
      // case CandidateStateError:
      //   return Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 20),
      //     child: ShowError(
      //       ErrorShowType: ErrorShowType.TextOnly,
      //       failure: (widget.candidateState as CandidateStateError).failure,
      //     ),
      //   );
      case CandidateStateLoaded:
        return _bigButton(
            (widget.candidateState as CandidateStateLoaded).candidate);
      default:
        return _bigButtonEmpty();
    }
  }

  Widget _bigButtonEmpty() {
    return BigTextButton(
        onClick: () {},
        fontSize: 18,
        isExpanded: false,
        // text: "voice ${candidate.votes}",
        textWidget: RichText(
            text: TextSpan(
                text: "صوت",
                style: TextStyle(
                    color: Colors.amber.shade400,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                children: <TextSpan>[
              TextSpan(
                text: " ${widget.candidate.votes}",
                style: TextStyle(
                    color: Colors.amber.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w900),
              )
            ])),
        backgroudColor: Colors.black87,
        textColor: Colors.amber.shade400,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6));
  }

  Widget _bigButton(Candidate candidate) {
    return BigTextButton(
        onClick: () {},
        fontSize: 18,
        isExpanded: false,
        // text: "voice ${candidate.votes}",
        textWidget: RichText(
            text: TextSpan(
                text: "صوت",
                style: TextStyle(
                    color: Colors.amber.shade400,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                children: <TextSpan>[
              TextSpan(
                text: " ${candidate.votes}",
                style: TextStyle(
                    color: Colors.amber.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w900),
              )
            ])),
        backgroudColor: Colors.black87,
        textColor: Colors.amber.shade400,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6));
  }

  Widget _bigButtonShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: BigTextButton(
          onClick: () {},
          fontSize: 18,
          isExpanded: false,
          // text: "voice ${candidate.votes}",
          textWidget: RichText(
              text: TextSpan(
                  text: "صوت",
                  style: TextStyle(
                      color: Colors.amber.shade400,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[])),
          backgroudColor: Colors.black87,
          textColor: Colors.amber.shade400,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6)),
    );
  }
}
