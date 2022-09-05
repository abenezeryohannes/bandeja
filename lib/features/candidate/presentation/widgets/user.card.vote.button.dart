import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/core/widgets/show.error.dart';
import 'package:app/features/authentication/presentation/bloc/user/user.bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/widgets/big.text.button.dart';
import '../../../authentication/domain/entities/user.dart';
import '../../../authentication/presentation/pages/sign.up.page.dart';
import '../../domain/entities/candidate.dart';

// user.votedFor = widget.candidate.id;
//                     userBlocProvider.add(SetUserVoteEvent(
//                         candidate: widget.candidate, user: user));
//                     Navigator.of(context, rootNavigator: true).pop('dialog');

class UserCardVoteButton extends StatefulWidget {
  const UserCardVoteButton({
    Key? key,
    required this.userState,
    required this.onVote,
    required this.user,
    required this.candidate,
    required this.onSignUp,
  }) : super(key: key);

  final UserState userState;
  final User? user;
  final Candidate candidate;
  final Function onSignUp;
  final Function onVote;

  @override
  State<UserCardVoteButton> createState() => _UserCardVoteButtonState();
}

class _UserCardVoteButtonState extends State<UserCardVoteButton> {
  @override
  Widget build(BuildContext context) {
    switch (widget.userState.runtimeType) {
      case UserStateLoading:
        return _bigButtonShimmer();
      case UserStateVoted:
        return _buttonOnLoaded((widget.userState as UserStateVoted).user);
      case UserStateLoaded:
        return _buttonOnLoaded((widget.userState as UserStateLoaded).user);
      case UserStateError:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 20),
          child: ShowError(
            ErrorShowType: ErrorShowType.TextOnly,
            failure: (widget.userState as UserStateError).failure,
          ),
        );
      default:
        return (widget.user == null)
            ? _buttonOnEmpty()
            : _buttonOnLoaded(widget.user!);
    }
  }

  Widget _buttonOnEmpty() {
    return BigTextButton(
        elevation: 0,
        cornerRadius: 5,
        // text: "voice ${widget.candidate.votes}",
        textWidget: RichText(
            text: TextSpan(
                text: "${widget.candidate.votes}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w800),
                children: const [
              TextSpan(
                text: "صوت",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )
            ])),
        onClick: () {
          // showCupertinoModalBottomSheet(
          //     closeProgressThreshold: 90,
          //     expand: false,
          //     backgroundColor: Colors.black,
          //     elevation: 10,
          //     context: context,
          //     builder: (context) => SizedBox(
          //           height: MediaQuery.of(context).size.height * 9 / 12,
          //           child: SIgnUpPage(
          //             onClick: (BuildContext context) {
          //               Navigator.pop(context);
          //             },
          //           ),
          //         )).then((value) => {widget.onSignUp()});
        },
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0));
  }

  Widget _buttonOnLoaded(User user) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BigTextButton(
          elevation: 0,
          cornerRadius: 5,
          backgroudColor: (widget.candidate.id == user.votedFor)
              ? Colors.green.shade700
              : const Color(0XFFFFD337),
          // text: "voice ${widget.candidate.votes}",
          textWidget: RichText(
              text: TextSpan(
                  text: " ${widget.candidate.votes}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                  children: const [
                TextSpan(
                  text: "صوت",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ])),
          onClick: () {
            // if (user.votedFor == null) {
            //   _openAlertBoxToConfirm(user, context);
            // } else
            //   _openAlertBoxToForbid(Failure(message: "لقد صوت بالفعل"), context);
          },
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0)),
    );
  }

  Widget _bigButtonShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: BigTextButton(
          onClick: () {},
          cornerRadius: 15,
          horizontalMargin: 42,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
    );
  }

  void _openAlertBoxToConfirm(User user, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(("Are you sure?"),
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                // const SizedBox(height: 20),
                Text(
                    "You can only vote for one candidate and it will not be reversable latter."),
              ],
            ),
            actionsOverflowButtonSpacing: 20,
            actions: [
              TextButton(
                  onPressed: () {
                    widget.onVote();
                  },
                  child: const Text("Yes, I am sure",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          );
        });
  }

  void _openAlertBoxToForbid(Failure failure, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              ("You already voted!"),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(failure.message ??
                    "Sorry, something went wrong, try again later."),
              ],
            ),
            actionsOverflowButtonSpacing: 20,
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: const Text(("ok"))),
            ],
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          );
        });
  }
}
