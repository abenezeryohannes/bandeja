import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/widgets/show.error.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';
import 'package:app/features/candidate/presentation/widgets/shimmers/candidate.avatar.shimmer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/pages/candidate.page.dart';
import '../bloc/top_voted_candidates/top.voted.candidates.bloc.dart';
import 'candidate.avatar.dart';

class CandidateAvatarListHorizontal extends StatefulWidget {
  const CandidateAvatarListHorizontal(
      {Key? key, this.height = 70, required this.state})
      : super(key: key);
  final TopVotedCandidateState state;
  final double height;

  @override
  State<CandidateAvatarListHorizontal> createState() =>
      _CandidateAvatarListHorizontalState();
}

class _CandidateAvatarListHorizontalState
    extends State<CandidateAvatarListHorizontal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.state.runtimeType) {
      case TopVotedStateEmpty:
        return const SizedBox();
      case TopVotedStateLoading:
        return Column(
          children: [
            _title(),
            SizedBox(height: widget.height, child: _onLoading()),
          ],
        );
      case TopVotedCandidateStateError:
        return SizedBox();
      // return SizedBox(height: widget.height, child: _onError(widget.state));
      case TopVotedCandidateStateLoaded:
        List<Candidate> candidates =
            (widget.state as TopVotedCandidateStateLoaded).candidates;
        return Column(
          children: [
            _title(),
            SizedBox(height: widget.height, child: _onLoaded(candidates)),
          ],
        );
      default:
        return const Center();
    }
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "الأعلى تصويت",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _onLoaded(List<Candidate> candidates) {
    return ListView.builder(
        shrinkWrap: true,
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: candidates.length,
        itemBuilder: (BuildContext context, int index) {
          return CandidateAvatar(
              hero:
                  "${candidates[index].name}${candidates[index].id}avatar-list",
              candidate: candidates[index],
              borderColor: const Color(0XFFFFD337),
              radius: 25,
              onClick: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => CandidatePage(
                            candidate: candidates[index],
                            avatar_hero_tag:
                                "${candidates[index].name}${candidates[index].id}avatar-list",
                            cover_hero_tag: "${Random()}")));
              },
              margins: EdgeInsets.fromLTRB(
                  index == candidates.length - 1 ? 24 : 3,
                  0,
                  index == 0 ? 24 : 3,
                  0));
        });
  }

  Widget _onLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            reverse: true,
            dragStartBehavior: DragStartBehavior.start,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return CandidateAvatarShimmer(
                  borderColor: Colors.amber.shade400,
                  radius: 25,
                  margins: EdgeInsets.fromLTRB(
                      index == 6 ? 24 : 3, 0, index == 0 ? 24 : 3, 0));
            }));
  }

  Widget _onError(TopVotedCandidateState state) {
    if ((state as TopVotedCandidateStateError).failure.runtimeType !=
        NoDataFailure) {
      return Center(
          child: ShowError(
        ErrorShowType: ErrorShowType.Horizontal,
        failure: (state as TopVotedCandidateStateError).failure,
      ));
    } else {
      return const SizedBox();
    }
  }
}
