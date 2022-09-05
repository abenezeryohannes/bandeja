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

class UserVoteButton extends StatefulWidget {
  const UserVoteButton({
    Key? key,
    required this.userState,
    required this.onVote,
    required this.candidate,
    required this.onSignUp,
  }) : super(key: key);
  final UserState userState;
  final Candidate candidate;
  final Function onSignUp;
  final Function onVote;

  @override
  State<UserVoteButton> createState() => _UserVoteButtonState();
}

class _UserVoteButtonState extends State<UserVoteButton> {
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
        return _buttonOnEmpty();
    }
  }

  Widget _buttonOnEmpty() {
    return BigTextButton(
        onClick: () {
          showCupertinoModalBottomSheet(
              closeProgressThreshold: 90,
              expand: false,
              backgroundColor: Colors.black,
              elevation: 10,
              context: context,
              builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 9 / 12,
                    child: SIgnUpPage(
                      onClick: (BuildContext context) {
                        Navigator.pop(context);
                      },
                    ),
                  )).then((value) => {widget.onSignUp()});
        },
        text: "صوّت",
        fontWight: FontWeight.bold,
        fontSize: 18,
        cornerRadius: 15,
        horizontalMargin: 42,
        backgroudColor: const Color(0XFFFFD337),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10));
  }

  Widget _buttonOnLoaded(User user) {
    return BigTextButton(
        onClick: () {
          if (user.votedFor == null) {
            _openAlertBoxToConfirm(user, context);
          } else
            // ignore: curly_braces_in_flow_control_structures
            _openAlertBoxToForbid(Failure(message: "لقد صوت بالفعل"), context);
        },
        text: "صوّت",
        fontWight: FontWeight.bold,
        fontSize: 18,
        cornerRadius: 15,
        horizontalMargin: 42,
        backgroudColor: (widget.candidate.id == user.votedFor)
            ? Colors.green.shade700
            : const Color(0XFFFFD337),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10));
  }

  // Widget _button(User user) {
  // return Column(
  //   children: [
  //     BlocProvider(
  //       create: (_) => userBlocProvider,
  //       child: BlocBuilder<UserBloc, UserState>(
  //         builder: (context, state) {
  //           if (state.runtimeType == UserStateLoading) {
  //             return Shimmer.fromColors(
  //               baseColor: Colors.grey.shade300,
  //               highlightColor: Colors.grey.shade100,
  //               enabled: true,
  //               child: BigTextButton(
  //                   onClick: () {},
  //                   cornerRadius: 15,
  //                   horizontalMargin: 42,
  //                   padding: const EdgeInsets.symmetric(
  //                       horizontal: 10, vertical: 10)),
  //             );
  //           }
  //           // else if ((state.runtimeType == UserStateLoaded) &&
  //           //     (state as UserStateLoaded).user.votedFor ==
  //           //         widget.candidate.id) {
  //           //   return const SizedBox();
  //           // }
  //           return BigTextButton(
  //               onClick: () {
  //                 switch (state.runtimeType) {
  //                   case UserStateEmpty:
  //                     showCupertinoModalBottomSheet(
  //                         closeProgressThreshold: 90,
  //                         expand: false,
  //                         backgroundColor: Colors.black,
  //                         elevation: 10,
  //                         context: context,
  //                         builder: (context) => SizedBox(
  //                               height: MediaQuery.of(context).size.height *
  //                                   9 /
  //                                   12,
  //                               child: SIgnUpPage(
  //                                 onClick: (BuildContext context) {
  //                                   Navigator.pop(context);
  //                                 },
  //                               ),
  //                             )).then(
  //                         (value) => {userBlocProvider.add(LoadUserEvent())});
  //                     break;
  //                   case UserStateError:
  //                     _openAlertBoxToForbid(
  //                         (state as UserStateError).failure, context);
  //                     break;
  //                   case UserStateLoaded:
  //                     User user = (state as UserStateLoaded).user;
  //                     if (user.votedFor == null) {
  //                       _openAlertBoxToConfirm(user, context);
  //                     } else
  //                       // ignore: curly_braces_in_flow_control_structures
  //                       _openAlertBoxToForbid(
  //                           Failure(message: "You have already voted."),
  //                           context);
  //                     break;
  //                   case UserStateLoading:
  //                     break;
  //                   default:
  //                 }
  //               },
  //               text: "صوّت",
  //               fontWight: FontWeight.bold,
  //               fontSize: 18,
  //               cornerRadius: 15,
  //               horizontalMargin: 42,
  //               backgroudColor: (state.runtimeType != UserStateLoaded ||
  //                       (state.runtimeType == UserStateLoaded &&
  //                           (state as UserStateLoaded).user.votedFor == null)
  //                   ? const Color(0XFFFFD337)
  //                   : ((state as UserStateLoaded).user.votedFor ==
  //                           candidate.id
  //                       ? Colors.black
  //                       : const Color(0XFFFFD337))),
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 10, vertical: 10));
  //         },
  //       ),
  //     ),
  //     const SizedBox(height: 20)
  //   ],
  // );

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
            title: const Text(("هل أنت واثق؟"),
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                // const SizedBox(height: 20),
                Text(
                    "يمكنك التصويت لمرشح واحد فقط ولن يكون هذا الأخير قابلاً للعكس."),
              ],
            ),
            actionsOverflowButtonSpacing: 20,
            actions: [
              TextButton(
                  onPressed: () {
                    widget.onVote();
                  },
                  child: const Text("نعم أنا متأكد",
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
              "لقد صوت بالفعل.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(failure.message ?? "يمكنك التصويت لمرشح واحد فقط."),
              ],
            ),
            actionsOverflowButtonSpacing: 20,
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: const Text(("موافق"))),
            ],
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          );
        });
  }
}
